import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/library.dart';
import 'package:fable_cosmic_read_app_fe/data/res/library_repo.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/library/library_bloc.dart';

import 'package:fable_cosmic_read_app_fe/presentation/views/main/library/components/favorite_book_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class FavoriteBookSection extends StatefulWidget {
  const FavoriteBookSection({super.key});

  @override
  State<FavoriteBookSection> createState() => _FavoriteBookSectionState();
}

class _FavoriteBookSectionState extends State<FavoriteBookSection> {
  LibraryBloc libraryBloc = LibraryBloc();
  late Library library;
  @override
  void initState() {
    super.initState();
    libraryBloc.add(GetLibraryRequested());
  }

  void clearLibrary() async {
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      await LibraryRepo().clearLibrary(userId: id, token: token);
    } else {
      print('User ID or token is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Favorite Books',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.bookListView, extra: {
                        'bookListName': 'Favorite Books',
                        'books': library.books,
                      });
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(color: AppTheme.primaryColor),
                    )),
              ],
            ),
          ),
          BlocBuilder<LibraryBloc, LibraryBlocState>(
            bloc: libraryBloc,
            builder: (context, libraryState) {
              if (libraryState is GetLibrarySuccess) {
                library = libraryState.library;
                if (library.books.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Your favorite books will appear here',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor),
                    ),
                  );
                }
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: libraryState.library.books.length,
                    itemBuilder: (context, index) {
                      return FavoriteBookItem(
                          book: libraryState.library.books.elementAt(index));
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      libraryBloc.add(GetLibraryRequested());
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.arrow_clockwise,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showClearLibDialog(context);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      CupertinoIcons.delete,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> showClearLibDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Clear Favorites'),
          content:
              const Text('Are you sure you want to clear all favorite books?'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                clearLibrary();
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}
