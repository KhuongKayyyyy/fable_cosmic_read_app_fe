import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/book_detail/book_detail_bloc.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/genre/genre_bloc.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/search/components/genre_search_item.dart';
import 'package:fable_cosmic_read_app_fe/presentation/widget/book/book_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late BookDetailBloc bookDetailBloc;
  late GenreBloc genreBloc;

  List<String> genre = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
  ];

  List<String> image = [
    AppImage.genre1,
    AppImage.genre2,
    AppImage.genre3,
    AppImage.genre4,
    AppImage.genre5,
    AppImage.genre6,
    AppImage.genre7,
    AppImage.genre8,
  ];

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    genreBloc = GenreBloc();
    genreBloc.add(GetAllGenresEvent(page: 1, size: 8, searchString: ''));
    bookDetailBloc = BookDetailBloc();
    bookDetailBloc.add(GetPopularBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showSearch(
                context: context,
                delegate: CustomSearchDelegate(bookDetailBloc: bookDetailBloc));
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: AppTheme.inkGrey,
                ),
                Text(
                  'Search',
                  style: TextStyle(color: AppTheme.inkGrey),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GenreBloc, GenreState>(
              bloc: genreBloc,
              builder: (context, genreState) {
                if (genreState is GenreLoadingState) {
                  Skeletonizer(
                      child: SizedBox(
                    height: MediaQuery.of(context)
                        .size
                        .height, // specify a fixed height
                    child: GridView.custom(
                      padding: const EdgeInsets.only(bottom: 220, top: 10),
                      gridDelegate: SliverWovenGridDelegate.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        pattern: [
                          const WovenGridTile(1),
                          const WovenGridTile(
                            6 / 7,
                            crossAxisRatio: 1,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: 8,
                        (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GenreSearchItem(
                              img: image[index],
                              color: colors[index],
                              genre: Genre(
                                  id: "1",
                                  name: "1",
                                  version: 1,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now())),
                        ),
                      ),
                    ),
                  ));
                } else if (genreState is GetAllGenresSuccess) {
                  return SizedBox(
                    height: MediaQuery.of(context)
                        .size
                        .height, // specify a fixed height
                    child: GridView.custom(
                      padding: const EdgeInsets.only(bottom: 220, top: 10),
                      gridDelegate: SliverWovenGridDelegate.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        pattern: [
                          const WovenGridTile(1),
                          const WovenGridTile(
                            6 / 7,
                            crossAxisRatio: 1,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        childCount: 8,
                        (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GenreSearchItem(
                              img: image[index],
                              color: colors[index],
                              genre: genreState.genres[index]),
                        ),
                      ),
                    ),
                  );
                } else if (genreState is GenreErrorState) {
                  return const Text("Error fetching data");
                }
                return const Text("No event added");
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final BookDetailBloc bookDetailBloc;
  CustomSearchDelegate({required this.bookDetailBloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: BookRepo.searchBookByName(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          List<Book> bookList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Search Results ",
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookList.length,
                    itemBuilder: (context, index) {
                      return BookSearchItem(book: bookList[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return buildResults(context);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Popular Now ",
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Icon(Icons.whatshot, color: Colors.red),
            ],
          ),
          BlocBuilder<BookDetailBloc, BookDetailState>(
            bloc: bookDetailBloc,
            builder: (context, bookState) {
              if (bookState is GetPopularBookSuccessState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bookState.books.take(4).length,
                  itemBuilder: (context, index) {
                    return BookSearchItem(book: bookState.books[index]);
                  },
                );
              }
              return const Text("No event added");
            },
          )
        ],
      ),
    );
  }
}
