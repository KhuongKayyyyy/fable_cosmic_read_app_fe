import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/core/theme/app_theme.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/data/res/continue_reading_repo.dart';
import 'package:fable_cosmic_read_app_fe/data/res/library_repo.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/book_detail/book_detail_bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/core/router/routes.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_heading.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/book_detail_information.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/chapter_item.dart';
import 'package:fable_cosmic_read_app_fe/presentation/views/book/book_detail/like_follow_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class BookDetailPage extends StatefulWidget {
  final Book bookModel;
  const BookDetailPage({super.key, required this.bookModel});

  @override
  // ignore: library_private_types_in_public_api
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late ContinueReadChapter? continueReadChapter;
  bool isInLibrary = false;
  final BookDetailBloc bookDetailBloc = BookDetailBloc();
  void getContinueChapter() async {
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      continueReadChapter = await ContinueReadingRepo().checkIfBookIsReading(
          userId: id, token: token, bookId: widget.bookModel.id!);
    }
  }

  @override
  void initState() {
    super.initState();
    bookDetailBloc.add(BookDetailInitialEvent(widget.bookModel.id!));
    getBookStatus();
    getContinueChapter();
  }

  Future<void> _refreshPage() async {
    bookDetailBloc.add(BookDetailInitialEvent(widget.bookModel.id!));
    getBookStatus();
    getContinueChapter();
  }

  void getBookStatus() async {
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);

    if (id != null && token != null) {
      final result = await LibraryRepo().checkIfBookIsInLibrary(
          userId: id, bookId: widget.bookModel.id!, token: token);

      setState(() {
        isInLibrary = result;
      });
    }
  }

  void addBookToLibrary() async {
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      try {
        await LibraryRepo().addBookToLibrary(
            userId: id, bookId: widget.bookModel.id!, token: token);
        setState(() {
          isInLibrary = true;
        });
        EasyLoading.showSuccess("Added to library");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  void deleteBookFromLibrary() async {
    final id =
        await const FlutterSecureStorage().read(key: AppSettings.currentUser);
    final token =
        await const FlutterSecureStorage().read(key: AppSettings.token);
    if (id != null && token != null) {
      try {
        await LibraryRepo().removeBookFromLibrary(
            userId: id, bookId: widget.bookModel.id!, token: token);
        setState(() {
          isInLibrary = false;
        });
        EasyLoading.showSuccess("Removed from library");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  void dispose() {
    bookDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if (state is NavigateToChapterReadState) {
          final pathParameters = {
            "bookId": widget.bookModel.id!,
            "chapterId": state.chapter.id,
          };
          context.pushNamed(Routes.chapterRead, pathParameters: pathParameters);
        }
      },
      bloc: bookDetailBloc,
      listenWhen: (previous, current) => current is BookDetailActionState,
      buildWhen: (previous, current) => current is! BookDetailActionState,
      builder: (context, state) {
        switch (state) {
          case ChapterFetchingLoadingState _:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
            );
          case ChapterFetchingFailureState _:
            return const Center(
              child: Text("Failed to fetch chapters"),
            );
          case ChapterFetchingSuccessState _:
            final successState = state;
            final chapterToShow = successState.chapters.length < 5
                ? successState.chapters
                : successState.showAllChapters
                    ? successState.chapters
                    : successState.chapters.take(5).toList();
            return RefreshIndicator(
              color: AppTheme.primaryColor,
              onRefresh: _refreshPage,
              child: Scaffold(
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
                          onPressed: () {
                            if (isInLibrary) {
                              deleteBookFromLibrary();
                            } else {
                              addBookToLibrary();
                            }
                          },
                          icon: Icon(
                            isInLibrary
                                ? CupertinoIcons.check_mark
                                : CupertinoIcons.add,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                body: _buildBookDetailBody(state, successState, chapterToShow),
                bottomSheet: _buildBottomSheet(),
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

  SingleChildScrollView _buildBookDetailBody(ChapterFetchingSuccessState state,
      ChapterFetchingSuccessState successState, List<Chapter> chapterToShow) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookDetailHeading(book: widget.bookModel, genres: state.genres),
          BookDetailInformation(
            book: widget.bookModel,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text("Chapters",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  " - ${extractNumber(successState.chapters.last.title)}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(" (${widget.bookModel.status!})",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    )),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(5, 0),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        )
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.sort,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: chapterToShow.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: ChapterItem(
                  chapter: chapterToShow.elementAt(index),
                  onTap: () {
                    bookDetailBloc.add(
                        ChapterSelectedEvent(chapterToShow.elementAt(index)));
                  },
                ),
              );
            },
          ),
          Center(
            child: TextButton(
              onPressed: () {
                bookDetailBloc.add(ToggleChapterViewEvent());
              },
              child: Text(
                successState.showAllChapters ? "Show Less" : "Show All",
                style: TextStyle(
                    color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: LikeFollowSection(
              book: widget.bookModel,
              isLiked: isInLibrary,
              onLikeTap: isInLibrary
                  ? () {
                      deleteBookFromLibrary();
                    }
                  : () {
                      addBookToLibrary();
                    },
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Container _buildBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: InkWell(
        onTap: () {
          if (continueReadChapter != null) {
            final pathParameters = {
              "bookId": continueReadChapter!.bookId,
              "chapterId": continueReadChapter!.chapterId,
            };
            context.pushNamed(Routes.chapterRead,
                pathParameters: pathParameters);
          } else {
            final pathParameters = {
              "bookId": widget.bookModel.id!,
              "chapterId": widget.bookModel.chapters!.first,
            };
            context.pushNamed(Routes.chapterRead,
                pathParameters: pathParameters);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          // ignore: unnecessary_null_comparison
          child: continueReadChapter == null
              ? const Center(
                  child: Text(
                    "Read now",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            continueReadChapter!.bookImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Continue ${continueReadChapter!.chapterName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  String extractNumber(String input) {
    // Use regular expression to find numbers
    final RegExp numberRegExp = RegExp(r'\d+');
    final Match? match = numberRegExp.firstMatch(input);

    // Return the number as a string, or return an empty string if not found
    return match != null ? match.group(0)! : '';
  }

  void main() {}
}
