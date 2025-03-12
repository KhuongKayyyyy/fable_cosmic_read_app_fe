import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/chapter_read/continue_read_view_all.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/view_all_book/view_all_book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/search/books_by_genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/authentication/authentication_page.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/authentication/login.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/authentication/sign_up.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_page.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/chapter_read/chapter_read_page.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/home/homepage.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/library/library_page.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/main/search/search.dart';
import 'package:fable_cosmic_read_app_fe/mainwrapper.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: "Shell Home");
  // static final GlobalKey<NavigatorState> _shellNavigatorSettingKey =
  //     GlobalKey<NavigatorState>(debugLabel: "Shell Setting");
  static final GlobalKey<NavigatorState> _shellNavigatorLibraryKey =
      GlobalKey<NavigatorState>(debugLabel: "Shell Library");
  static final GlobalKey<NavigatorState> _shellNavigatorSearchKey =
      GlobalKey<NavigatorState>(debugLabel: "Search Profile");

  static Future<GoRouter> createRouter() async {
    final String? userId =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);

    return GoRouter(
      initialLocation: userId != null ? Routes.home : Routes.authentication,
      navigatorKey: _rootNavigatorKey,
      routes: [
        _buildMainShellRoute(),
        ..._buildBookRoutes(),
        ..._buildAuthenticationRoutes(),
      ],
    );
  }

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          Mainwrapper(navigationShell: navigationShell),
      branches: [
        _buildHomeBranch(),
        _buildSearchBranch(),
        _buildLibraryBranch(),
        // _buildSettingBranch(),
      ],
    );
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      routes: [
        GoRoute(
          path: Routes.home,
          name: Routes.home,
          builder: (context, state) => const Homepage(),
        ),
        GoRoute(
          path: Routes.continueReadingViewAll,
          name: Routes.continueReadingViewAll,
          builder: (context, state) {
            final List<ContinueReadChapter> continueChapters =
                state.extra as List<ContinueReadChapter>;
            return ContinueReadViewAll(continueReading: continueChapters);
          },
        ),
      ],
      navigatorKey: _shellNavigatorHomeKey,
    );
  }

  static StatefulShellBranch _buildLibraryBranch() {
    return StatefulShellBranch(
      routes: [
        GoRoute(
          path: Routes.library,
          name: Routes.library,
          builder: (context, state) => const LibraryPage(),
        ),
      ],
      navigatorKey: _shellNavigatorLibraryKey,
    );
  }

  static StatefulShellBranch _buildSearchBranch() {
    return StatefulShellBranch(
      routes: [
        GoRoute(
          path: Routes.search,
          name: Routes.search,
          builder: (context, state) => const Search(),
        ),
        GoRoute(
          path: Routes.getBookByGenre,
          name: Routes.getBookByGenre,
          builder: (context, state) => BooksByGenre(
            genre: state.extra as Genre,
          ),
        ),
      ],
      navigatorKey: _shellNavigatorSearchKey,
    );
  }

  // static StatefulShellBranch _buildSettingBranch() {
  //   return StatefulShellBranch(
  //     routes: [
  //       GoRoute(
  //         path: Routes.setting,
  //         name: Routes.setting,
  //         builder: (context, state) => const Setting(),
  //       ),
  //     ],
  //     navigatorKey: _shellNavigatorSettingKey,
  //   );
  // }

  static List<GoRoute> _buildBookRoutes() {
    return [
      GoRoute(
        path: Routes.bookDetail,
        name: Routes.bookDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final Book book = state.extra as Book;
          return BookDetailPage(bookModel: book);
        },
      ),
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

          return ViewAllBook(bookListName: bookListName, books: books);
        },
      ),
      GoRoute(
        path: "${Routes.chapterRead}/:bookId/:chapterId",
        name: Routes.chapterRead,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final String chapterId = state.pathParameters['chapterId']!;
          final String bookId = state.pathParameters['bookId']!;
          return ChapterReadPage(chapterId: chapterId, bookId: bookId);
        },
      ),
    ];
  }

  static List<GoRoute> _buildAuthenticationRoutes() {
    return [
      GoRoute(
        path: Routes.authentication,
        name: Routes.authentication,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AuthenticationPage(),
      ),
      GoRoute(
        path: Routes.signUp,
        name: Routes.signUp,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
    ];
  }

  static initRouter() {}
}
