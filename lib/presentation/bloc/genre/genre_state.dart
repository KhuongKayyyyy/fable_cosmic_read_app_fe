part of 'genre_bloc.dart';

@immutable
sealed class GenreState {}

final class GenreInitial extends GenreState {}

class GetAllGenresSuccess extends GenreState {
  final List<Genre> genres;
  final bool hasReachedMax;

  GetAllGenresSuccess({required this.genres, required this.hasReachedMax});
}

class GenreErrorState extends GenreState {
  final String message;

  GenreErrorState({required this.message});
}

class GenreLoadingState extends GenreState {}
