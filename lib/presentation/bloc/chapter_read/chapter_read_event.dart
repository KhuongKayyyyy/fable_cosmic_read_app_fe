part of 'chapter_read_bloc.dart';

@immutable
sealed class ChapterReadEvent {}

class ChapterReadInitialEvent extends ChapterReadEvent {
  final String chapterId;
  ChapterReadInitialEvent(this.chapterId);
}
