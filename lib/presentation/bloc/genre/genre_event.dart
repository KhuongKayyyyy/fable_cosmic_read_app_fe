part of 'genre_bloc.dart';

@immutable
sealed class GenreEvent {}

class GetAllGenresEvent extends GenreEvent {
  final int? page;
  final int? size;
  final String? searchString;

  GetAllGenresEvent({this.page, this.size, this.searchString});
}
