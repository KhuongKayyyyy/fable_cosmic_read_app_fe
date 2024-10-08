part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class BookSelectedEvent extends HomeEvent {
  final Book book;
  BookSelectedEvent(this.book);
}

class BookListSelectedEvent extends HomeEvent {
  final List<Book> books;
  final String bookListName;
  BookListSelectedEvent(this.books, this.bookListName);
}
