part of 'library_bloc.dart';

@immutable
sealed class LibraryBlocState {}

final class LibraryBlocInitial extends LibraryBlocState {}

final class GetLibraryLoading extends LibraryBlocState {}

final class GetLibrarySuccess extends LibraryBlocState {
  final Library library;

  GetLibrarySuccess({
    required this.library,
  });
}

final class GetLibraryFailed extends LibraryBlocState {
  final String message;

  GetLibraryFailed({
    required this.message,
  });
}
