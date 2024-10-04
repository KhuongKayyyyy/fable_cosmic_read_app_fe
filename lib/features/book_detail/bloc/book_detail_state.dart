part of 'book_detail_bloc.dart';

@immutable
sealed class BookDetailState {}

sealed class BookDetailActionState extends BookDetailState {}

final class BookDetailInitial extends BookDetailState {}

class ChapterFetchingLoadingState extends BookDetailState {}

class ChapterFetchingFailureState extends BookDetailState {}

class ChapterFetchingSuccessState extends BookDetailState {
  final List<ChapterModel> chapters;
  ChapterFetchingSuccessState(this.chapters);
}
