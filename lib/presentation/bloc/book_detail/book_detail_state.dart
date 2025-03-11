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
  final bool showAllChapters;
  ChapterFetchingSuccessState(this.chapters, this.genres, this.showAllChapters);
}

class NavigateToChapterReadState extends BookDetailActionState {
  final Chapter chapter;
  NavigateToChapterReadState(this.chapter);
}

class GetBookByGenreLoadingState extends BookDetailState {}

class GetBookByGenreFailureState extends BookDetailState {}

class GetBookByGenreSuccessState extends BookDetailState {
  final List<Book> books;
  GetBookByGenreSuccessState(this.books);
}

class GetPopularBookSuccessState extends BookDetailState {
  final List<Book> books;
  GetPopularBookSuccessState(this.books);
}

class GetPopularBookFailureState extends BookDetailState {}

class GetPopularBookLoadingState extends BookDetailState {}
