part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class DataFetchingLoadingState extends HomeState {}

class DataFetchingFailureState extends HomeState {}

class DataFetchingSuccessState extends HomeState {
  final List<Book> newBooks;
  final List<Book> topBooks;
  final List<Book> recommendedBooks;
  final List<Genre> popularGenre;
  DataFetchingSuccessState(
      this.newBooks, this.topBooks, this.recommendedBooks, this.popularGenre);
}

class NavigatedToDetailState extends HomeActionState {
  final Book book;
  NavigatedToDetailState(this.book);
}

class NavigateToViewAllBookState extends HomeActionState {
  final List<Book> books;
  final String bookListName;
  NavigateToViewAllBookState(this.books, this.bookListName);
}
