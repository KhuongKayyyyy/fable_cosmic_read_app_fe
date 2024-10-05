import 'package:fable_cosmic_read_app_fe/presentation/bloc/book_detail/book_detail_bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_heading.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailPage extends StatefulWidget {
  final Book bookModel;
  const BookDetailPage({Key? key, required this.bookModel}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookDetailBloc bookDetailBloc = BookDetailBloc();

  @override
  void initState() {
    super.initState();
    bookDetailBloc.add(BookDetailInitialEvent(widget.bookModel.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      bloc: bookDetailBloc,
      listenWhen: (previous, current) => current is BookDetailActionState,
      buildWhen: (previous, current) => current is! BookDetailActionState,
      builder: (context, state) {
        switch (state) {
          case ChapterFetchingLoadingState _:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ChapterFetchingFailureState _:
            return const Center(
              child: Text("Failed to fetch chapters"),
            );
          case ChapterFetchingSuccessState _:
            final successState = state as ChapterFetchingSuccessState;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    )
                  ],
                ),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.library_add,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4)),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.switch_access_shortcut_rounded,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookDetailHeading(
                        book: widget.bookModel, genres: state.genres),
                    BookDetailInformation(
                      book: widget.bookModel,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Chapters",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: successState.chapters.take(10).length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            final pathParameters = {
                              "bookId": widget.bookModel.id!,
                              "chapterId": successState.chapters[index].id,
                            };
                            context.pushNamed(Routes.chapterRead,
                                pathParameters: pathParameters);
                          },
                          title: Text(successState.chapters[index].title),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Nothing to show"),
              ),
            );
        }
      },
    );
  }
}
