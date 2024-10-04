part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class BookSelectedEvent extends HomeEvent {
  final BookModel book;
  BookSelectedEvent(this.book);
}
