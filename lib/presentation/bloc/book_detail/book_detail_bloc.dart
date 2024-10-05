import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:meta/meta.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc() : super(BookDetailInitial()) {
    on<BookDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<BookDetailInitialEvent>(bookDetailInitialEvent);
  }

  Future<void> bookDetailInitialEvent(
      BookDetailInitialEvent event, Emitter<BookDetailState> emit) async {
    emit(ChapterFetchingLoadingState());
    try {
      final chapters = await BookRepo.fetchChapter(event.bookId);
      final genres = await BookRepo.fetchGenre(event.bookId);
      emit(ChapterFetchingSuccessState(chapters, genres));
    } catch (e) {
      emit(ChapterFetchingFailureState());
    }
  }
}
