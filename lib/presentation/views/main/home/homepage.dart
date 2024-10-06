import "package:fable_cosmic_read_app_fe/presentation/views/main/home/book_by_type_section.dart";
import "package:fable_cosmic_read_app_fe/presentation/views/main/home/continue_reading_section.dart";
import "package:fable_cosmic_read_app_fe/presentation/views/main/home/new_book_section.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import "package:fable_cosmic_read_app_fe/presentation/widget/book/continue_read_book.dart";
import "package:fable_cosmic_read_app_fe/presentation/widget/book/new_coming_book.dart";
import "package:fable_cosmic_read_app_fe/core/constant/app_image.dart";
import "package:fable_cosmic_read_app_fe/presentation/widget/book/book_item.dart";
import "package:fable_cosmic_read_app_fe/core/router/routes.dart";
import 'package:fable_cosmic_read_app_fe/presentation/bloc/home/home_bloc.dart';

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
        } else if (state is NavigateToViewAllBookState) {
          final extraData = {
            "books": state.books,
            "bookListName": state.bookListName,
          };
          context.pushNamed(Routes.bookListView, extra: extraData);
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
                      NewBookSection(
                        books: successState.newBooks,
                        onTap: (selectedBook) {
                          homeBloc.add(BookSelectedEvent(selectedBook));
                        },
                        onViewAll: () {
                          homeBloc.add(BookListSelectedEvent(
                              successState.newBooks, "New Books"));
                        },
                      ),
                      // continue reading section
                      ContinueReadingSection(
                        books: successState.recommendedBooks,
                        onTap: (selectedBook) {
                          homeBloc.add(BookSelectedEvent(selectedBook));
                        },
                        onViewAll: () {
                          homeBloc.add(BookListSelectedEvent(
                              successState.recommendedBooks,
                              "Continue Reading"));
                        },
                      ),
                      // top manga section
                      const SizedBox(height: 10),
                      BookByTypeSection(
                          books: successState.topBooks,
                          sectionType: "Top Manga",
                          onTap: (selectedBook) {
                            homeBloc.add(BookSelectedEvent(selectedBook));
                          },
                          onViewAll: () {
                            homeBloc.add(BookListSelectedEvent(
                                successState.topBooks, "Top Manga"));
                          }),
                      const SizedBox(height: 10),
                      BookByTypeSection(
                          books: successState.newBooks,
                          sectionType: "Recommend for you",
                          onTap: (selectedBook) {
                            homeBloc.add(BookSelectedEvent(selectedBook));
                          },
                          onViewAll: () {
                            homeBloc.add(BookListSelectedEvent(
                                successState.newBooks, "Recommend for you"));
                          }),
                      const SizedBox(height: 110),
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
