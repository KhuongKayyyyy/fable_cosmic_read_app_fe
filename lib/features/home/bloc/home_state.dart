part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class BookFetchingLoadingState extends HomeState {}

class BookFetchingFailureState extends HomeState {}

class BookFetchingSuccessState extends HomeState {
  final List<BookModel> books;
  BookFetchingSuccessState(this.books);
}
