part of 'book_detail_bloc.dart';

@immutable
sealed class BookDetailState {}

sealed class BookDetailActionState extends BookDetailState {}

final class BookDetailInitial extends BookDetailState {}

class ChapterFetchingLoadingState extends BookDetailState {}

class ChapterFetchingFailureState extends BookDetailState {}

class ChapterFetchingSuccessState extends BookDetailState {
  final List<Chapter> chapters;
  final List<Genre> genres;
  ChapterFetchingSuccessState(this.chapters, this.genres);
}
