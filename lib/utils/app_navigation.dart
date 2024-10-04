import 'package:fable_cosmic_read_app_fe/features/book_detail/model/chapter_model.dart';
import 'package:fable_cosmic_read_app_fe/features/book_detail/ui/book_detail_page.dart';
import 'package:fable_cosmic_read_app_fe/features/book_detail/ui/chapter_read.dart';
import 'package:fable_cosmic_read_app_fe/features/home/model/book_model.dart';
import 'package:fable_cosmic_read_app_fe/features/home/ui/homepage.dart';
import 'package:fable_cosmic_read_app_fe/features/library/ui/library.dart';
import 'package:fable_cosmic_read_app_fe/features/search/ui/search.dart';
import 'package:fable_cosmic_read_app_fe/features/setting/ui/setting.dart';
import 'package:fable_cosmic_read_app_fe/mainwrapper.dart';
import 'package:fable_cosmic_read_app_fe/utils/routes.dart';
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
              final BookModel book = state.extra as BookModel;
              return BookDetailPage(
                bookModel: book,
              );
            }),
        GoRoute(
            path: Routes.chapterRead,
            name: Routes.chapterRead,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final ChapterModel chapter = state.extra as ChapterModel;
              return ChapterRead(
                chapterModel: chapter,
              );
            })
      ]);
}
