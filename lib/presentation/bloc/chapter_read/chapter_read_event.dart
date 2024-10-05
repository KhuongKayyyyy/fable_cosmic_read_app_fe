part of 'chapter_read_bloc.dart';

@immutable
sealed class ChapterReadEvent {}

class ChapterReadInitialEvent extends ChapterReadEvent {
  final String chapterId;
  final String bookId;
  ChapterReadInitialEvent(
    this.chapterId,
    this.bookId,
  );
}

class ChapterReadNextEvent extends ChapterReadEvent {
  final String chapterId;
  final String bookId;
  ChapterReadNextEvent(
    this.chapterId,
    this.bookId,
  );
}

class ChapterReadPreviousEvent extends ChapterReadEvent {
  final String chapterId;
  final String bookId;
  ChapterReadPreviousEvent(
    this.chapterId,
    this.bookId,
  );
}
