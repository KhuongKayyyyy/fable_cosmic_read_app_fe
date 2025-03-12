import 'dart:developer';

import 'package:fable_cosmic_read_app_fe/core/constant/app_image.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/chapter_read/chapter_read_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChapterReadPage extends StatefulWidget {
  final String chapterId;
  final String bookId;
  const ChapterReadPage({
    super.key,
    required this.chapterId,
    required this.bookId,
  });

  @override
  State<ChapterReadPage> createState() => _ChapterReadPageState();
}

class _ChapterReadPageState extends State<ChapterReadPage> {
  final ChapterReadBloc chapterReadBloc = ChapterReadBloc();
  final ScrollController _scrollController = ScrollController();
  bool _isFirstChapter = false;
  bool _isLastChapter = false;
  bool _isBottomAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    chapterReadBloc
        .add(ChapterReadInitialEvent(widget.chapterId, widget.bookId));
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isBottomAppBarVisible) {
        setState(() {
          _isBottomAppBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isBottomAppBarVisible) {
        setState(() {
          _isBottomAppBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChapterReadBloc, ChapterReadState>(
      bloc: chapterReadBloc,
      listener: (context, state) {},
      listenWhen: (previous, current) => current is ChapterReadActionState,
      buildWhen: (previous, current) => current is! ChapterReadActionState,
      builder: (context, state) {
        switch (state) {
          case ChapterReadLoadingState _:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ChapterReadSuccessState _:
            final successState = state;
            _isFirstChapter =
                successState.book.isFirstChapter(successState.chapter.id);
            _isLastChapter =
                successState.book.isLastChapter(successState.chapter.id);
            return Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    title: Text("${successState.chapter.title} ",
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: successState.chapter.pages.map((pageUrl) {
                              return Image.network(
                                pageUrl,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(AppImage.defaultImage);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isBottomAppBarVisible ? 80 : 0,
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: _isFirstChapter
                            ? null
                            : () {
                                final prevChapterId = successState.book
                                    .getNextChapter(successState.chapter.id);
                                log('Previous Chapter ID: $prevChapterId');
                                chapterReadBloc.add(ChapterReadPreviousEvent(
                                  prevChapterId,
                                  widget.bookId,
                                ));
                              },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: _isFirstChapter ? Colors.grey : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showChaperList(context, successState.book);
                        },
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: _isLastChapter
                            ? null
                            : () {
                                final nextChapterId = successState.book
                                    .getPreviousChapter(
                                        successState.chapter.id);
                                log('Next Chapter ID: $nextChapterId');
                                chapterReadBloc.add(ChapterReadNextEvent(
                                  nextChapterId,
                                  widget.bookId,
                                ));
                              },
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: _isLastChapter ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case ChapterReadFailureState _:
            return const Scaffold(
              body: Center(
                child: Text("Failed to load chapter"),
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

  void _showChaperList(BuildContext context, Book book) async {
    final chapterList = await BookRepo.fetchBookChapters(book.id!);
    showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Chapter List",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 410,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: chapterList.length,
                  itemBuilder: (context, index) {
                    final chapter = chapterList[index];
                    return ListTile(
                      title: Text(
                        chapter.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        chapterReadBloc.add(ChapterReadInitialEvent(
                          chapter.id,
                          book.id!,
                        ));
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          );
        });
  }
}
