import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_page.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/chapter_read/chapter_read_page.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/homepage.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/view_all_book/view_all_book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/library/library.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/search/search.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/setting/setting.dart';
import 'package:fable_cosmic_read_app_fe/mainwrapper.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: "Shell Home");
  static final _shellNavigatorSettingKey =
      GlobalKey<NavigatorState>(debugLabel: "Shell Setting");
  static final _shellNavigatorLibraryKey =
      GlobalKey<NavigatorState>(debugLabel: "Shell Library");
  static final _shellNavigatorSearchKey =
      GlobalKey<NavigatorState>(debugLabel: "Search Profile");

  static final GoRouter router = GoRouter(
      initialLocation: Routes.home,
      navigatorKey: _rootNavigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) => Mainwrapper(
                  navigationShell: navigationShell,
                ),
            branches: [
              // branch home
              StatefulShellBranch(routes: [
                GoRoute(
                    path: Routes.home,
                    name: Routes.home,
                    builder: (BuildContext context, GoRouterState state) {
                      return const Homepage();
                    })
              ], navigatorKey: _shellNavigatorHomeKey),

              // branch library
              StatefulShellBranch(routes: [
                GoRoute(
                    path: Routes.library,
                    name: Routes.library,
                    builder: (BuildContext context, GoRouterState state) {
                      return const Library();
                    })
              ], navigatorKey: _shellNavigatorLibraryKey),

              // branch search
              StatefulShellBranch(routes: [
                GoRoute(
                    path: Routes.search,
                    name: Routes.search,
                    builder: (BuildContext context, GoRouterState state) {
                      return const Search();
                    })
              ], navigatorKey: _shellNavigatorSearchKey),

              // branch setting
              StatefulShellBranch(routes: [
                GoRoute(
                    path: Routes.setting,
                    name: Routes.setting,
                    builder: (BuildContext context, GoRouterState state) {
                      return const Setting();
                    })
              ], navigatorKey: _shellNavigatorSettingKey),
            ]),
        GoRoute(
            path: Routes.bookDetail,
            name: Routes.bookDetail,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final Book book = state.extra as Book;
              return BookDetailPage(
                bookModel: book,
              );
            }),
        GoRoute(
          name: Routes.bookListView,
          path: Routes.bookListView,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final Map<String, dynamic> dataPackage =
                state.extra as Map<String, dynamic>;
            final String bookListName =
                dataPackage["bookListName"] as String? ?? "Currently null";
            final List<Book> books = List<Book>.from(dataPackage["books"]);
            return ViewAllBook(
              bookListName: bookListName,
              books: books,
            );
          },
        ),
        GoRoute(
            path: "${Routes.chapterRead}/:bookId/:chapterId",
            name: Routes.chapterRead,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final String chapterId = state.pathParameters['chapterId']!;
              final String bookId = state.pathParameters['bookId']!;
              return ChapterReadPage(
                chapterId: chapterId,
                bookId: bookId,
              );
            })
      ]);
}
