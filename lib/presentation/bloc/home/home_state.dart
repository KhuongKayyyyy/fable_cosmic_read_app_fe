part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class BookFetchingLoadingState extends HomeState {}

class BookFetchingFailureState extends HomeState {}

class BookFetchingSuccessState extends HomeState {
  final List<Book> newBooks;
  final List<Book> topBooks;
  final List<Book> recommendedBooks;
  BookFetchingSuccessState(this.newBooks, this.topBooks, this.recommendedBooks);
}

class NavigatedToDetailState extends HomeActionState {
  final Book book;
  NavigatedToDetailState(this.book);
}
