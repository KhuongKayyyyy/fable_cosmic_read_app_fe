import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/presentation/bloc/chapter_read/chapter_read_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChapterReadPage extends StatefulWidget {
  final String chapterId;
  final String bookId;
  ChapterReadPage({
    super.key,
    required this.chapterId,
    required this.bookId,
  });

  @override
  State<ChapterReadPage> createState() => _ChapterReadPageState();
}

class _ChapterReadPageState extends State<ChapterReadPage> {
  final ChapterReadBloc chapterReadBloc = ChapterReadBloc();
  // late final bool _isFirstChapter;
  // late final bool _isLastChapter;
  @override
  void initState() {
    super.initState();
    // _isFirstChapter = widget.book.isFirstChapter(widget.chapterId);
    // _isLastChapter = widget.book.isLastChapter(widget.chapterId);
    chapterReadBloc.add(ChapterReadInitialEvent(widget.chapterId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {},
      bloc: chapterReadBloc,
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
            final successState = state as ChapterReadSuccessState;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                ),
                title: Text("${successState.chapter.title} ",
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: state.chapter.pages.map((pageUrl) {
                            return Image.network(pageUrl);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SizedBox(
                height: 80,
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        disabledColor: Colors.grey,
                        onPressed: () {},
                        // onPressed: _isFirstChapter ? null : () {},
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.menu)),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        disabledColor: Colors.grey,
                        onPressed: () {},
                        // onPressed: _isLastChapter ? null : () {},
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
}
