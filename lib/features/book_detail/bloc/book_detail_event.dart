part of 'book_detail_bloc.dart';

@immutable
sealed class BookDetailEvent {}

class BookDetailInitialEvent extends BookDetailEvent {
  String bookId;
  BookDetailInitialEvent(this.bookId);
}
