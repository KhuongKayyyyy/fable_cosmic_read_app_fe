part of 'chapter_read_bloc.dart';

@immutable
sealed class ChapterReadState {}

sealed class ChapterReadActionState extends ChapterReadState {}

final class ChapterReadInitial extends ChapterReadState {}

final class ChapterReadLoadingState extends ChapterReadState {}

final class ChapterReadFailureState extends ChapterReadState {}

class ChapterReadSuccessState extends ChapterReadState {
  final Chapter chapter;
  final Book book;
  ChapterReadSuccessState(this.chapter, this.book);
}
