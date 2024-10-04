import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import "package:fable_cosmic_read_app_fe/features/home/ui/continue_read_book.dart";
import "package:fable_cosmic_read_app_fe/features/home/ui/new_coming_book.dart";
import "package:fable_cosmic_read_app_fe/global/app_image.dart";
import "package:fable_cosmic_read_app_fe/features/home/ui/book_item.dart";
import "package:fable_cosmic_read_app_fe/mainwrapper.dart";
import "package:fable_cosmic_read_app_fe/utils/routes.dart";
import 'package:fable_cosmic_read_app_fe/features/home/bloc/home_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is NavigatedToDetailState) {
          context.pushNamed(
            Routes.bookDetail,
            extra: state.book,
          );
        }
      },
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state) {
          case BookFetchingLoadingState _:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case BookFetchingSuccessState _:
            final successState = state as BookFetchingSuccessState;
            return Scaffold(
              appBar: AppBar(
                // backgroundColor: Colors.white.withOpacity(0.1),
                title: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(AppImage.defaultAvatar),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Hi Khuong !!!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 30,
                        ))
                  ],
                ),
              ),
              extendBodyBehindAppBar: true,
              body: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // new book section
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "New Coming",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View All",
                                      style: TextStyle(color: Colors.grey[500]),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: successState.books.length,
                              itemBuilder: (context, index) {
                                final book =
                                    successState.books.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: NewComingBook(book: book),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      // continue reading section
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Continue Reading",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View All",
                                      style: TextStyle(color: Colors.grey[500]),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: successState.books.length,
                              itemBuilder: (context, index) {
                                final book =
                                    successState.books.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ContinueReadBook(book: book),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      // top manga section
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Top manga",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View All",
                                      style: TextStyle(color: Colors.grey[500]),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: successState.books.length,
                              itemBuilder: (context, index) {
                                final book =
                                    successState.books.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: BookItem(book: book),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      // recommend for you section
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                const Text(
                                  "Recommend for you",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "View All",
                                      style: TextStyle(color: Colors.grey[500]),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: successState.books.length,
                              itemBuilder: (context, index) {
                                final book =
                                    successState.books.elementAt(index);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: BookItem(
                                    book: book,
                                    onTap: () {
                                      homeBloc.add(BookSelectedEvent(book));
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            );
          case BookFetchingFailureState _:
            return const Center(
              child: Text("Error fetching books"),
            );
          default:
            return const Center(
              child: Text("Nothing to show"),
            );
        }
      },
    );
  }
}
