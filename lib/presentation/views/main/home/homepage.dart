import "package:fable_cosmic_read_app_fe/core/theme/app_theme.dart";
import "package:fable_cosmic_read_app_fe/presentation/bloc/authentication/authentication_bloc.dart";
import "package:fable_cosmic_read_app_fe/presentation/views/main/home/book_by_type_section.dart";
import "package:fable_cosmic_read_app_fe/presentation/views/main/home/continue_reading_section.dart";
import "package:fable_cosmic_read_app_fe/presentation/views/main/home/new_book_section.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import "package:fable_cosmic_read_app_fe/core/constant/app_image.dart";
import "package:fable_cosmic_read_app_fe/core/router/routes.dart";
import 'package:fable_cosmic_read_app_fe/presentation/bloc/home/home_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? userId;
  final HomeBloc homeBloc = HomeBloc();
  final AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitialEvent());
    authenticationBloc.add(AuthenticatioGetUserRequested());
  }

  Future<void> _refreshData() async {
    homeBloc.add(HomeInitialEvent()); // Reload home page data
    authenticationBloc
        .add(AuthenticatioGetUserRequested()); // Refresh authentication state
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
          case DataFetchingLoadingState _:
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          case DataFetchingSuccessState _:
            final successState = state;
            return RefreshIndicator(
              color: AppTheme.primaryColor,
              onRefresh: _refreshData,
              child: Scaffold(
                appBar: _buildHomeAppBar(context),
                extendBodyBehindAppBar: true,
                body: _buildHomeBody(context, successState),
              ),
            );
          case DataFetchingFailureState _:
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

  Padding _buildHomeBody(
      BuildContext context, DataFetchingSuccessState successState) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // TextButton(
            //   onPressed: () async {
            //     final id = await const FlutterSecureStorage()
            //         .read(key: AppSettings.currentUser);
            //     final token = await const FlutterSecureStorage()
            //         .read(key: AppSettings.token);
            //     if (id != null && token != null) {
            //       await ContinueReadingRepo().checkIfBookIsReading(
            //           userId: id,
            //           token: token,
            //           bookId: "670129f9a3d6a4cd7e4bcb0f");
            //     }
            //   },
            //   child: const Text("Test"),
            // ),
            // new book section
            NewBookSection(
              books: successState.newBooks,
              onTap: (selectedBook) {
                homeBloc.add(BookSelectedEvent(selectedBook));
              },
              onViewAll: () {
                homeBloc.add(
                    BookListSelectedEvent(successState.newBooks, "New Books"));
              },
            ),
            // continue reading section
            ContinueReadingSection(
              onTap: (selectedBook) {
                homeBloc.add(BookSelectedEvent(selectedBook));
              },
              onViewAll: () {
                homeBloc.add(BookListSelectedEvent(
                    successState.recommendedBooks, "Continue Reading"));
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
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    return AppBar(
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
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (context, userState) {
              if (userState is AuthenticationGetUserSuccess) {
                return Text(userState.user.name);
              } else if (userState is AuthenticationGetUserFailure) {
                return const Text("User not found");
              } else if (userState is AuthenticationLoading) {
                return const Text("Loading...");
              }
              return const Text("Loading...");
            },
          ),
          const Spacer(),
          if (userId == null)
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.secondaryColor,
                  border: Border.all(width: 2, color: AppTheme.iconColor)),
              child: IconButton(
                  onPressed: () {
                    context.pushNamed(Routes.authentication);
                  },
                  icon: Icon(
                    Icons.notifications_none,
                    size: 30,
                    color: AppTheme.iconColor,
                  )),
            )
        ],
      ),
    );
  }
}
