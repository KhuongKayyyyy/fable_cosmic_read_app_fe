part of 'book_detail_bloc.dart';

@immutable
sealed class BookDetailEvent {}

class BookDetailInitialEvent extends BookDetailEvent {
  final String bookId;
  BookDetailInitialEvent(this.bookId);
}

final class ToggleChapterViewEvent extends BookDetailEvent {}
