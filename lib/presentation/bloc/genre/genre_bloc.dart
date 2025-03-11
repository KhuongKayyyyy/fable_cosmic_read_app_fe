import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/data/res/genre_repo.dart';
import 'package:meta/meta.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreInitial()) {
    on<GenreEvent>((event, emit) {});

    on<GetAllGenresEvent>(_onGetAllGenres);
  }

  Future<void> _onGetAllGenres(
      GetAllGenresEvent event, Emitter<GenreState> emit) async {
    emit(GenreLoadingState());

    try {
      List<Genre> genres = await GenreRepo.fetchGenres(
          event.page, event.size, event.searchString);

      emit(GetAllGenresSuccess(
          genres: genres, hasReachedMax: genres.isEmpty || genres.length < 10));
    } catch (e) {
      emit(GenreErrorState(message: e.toString()));
    }
  }
}
