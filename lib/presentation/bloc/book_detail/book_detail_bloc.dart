import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/data/model/genre.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:meta/meta.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc() : super(BookDetailInitial()) {
    on<BookDetailEvent>((event, emit) {});
    on<BookDetailInitialEvent>(bookDetailInitialEvent);
    on<ToggleChapterViewEvent>(toggleChapterViewEvent);
    on<ChapterSelectedEvent>(chapterSelectedEvent);
    on<GetBookByGenreEvent>(getBookByGenreEvent);
    on<GetPopularBookEvent>(getPopularBookEvent);
  }

  void getPopularBookEvent(
      GetPopularBookEvent event, Emitter<BookDetailState> emit) async {
    emit(GetPopularBookLoadingState());
    try {
      final recommendedBooks = await BookRepo.fetchBooks(3);
      emit(GetPopularBookSuccessState(recommendedBooks));
    } catch (e) {
      emit(GetPopularBookFailureState());
    }
  }

  Future<void> getBookByGenreEvent(
      GetBookByGenreEvent event, Emitter<BookDetailState> emit) async {
    emit(GetBookByGenreLoadingState());
    try {
      final books = await BookRepo.fetchBooksByGenre(event.genre.id);
      emit(GetBookByGenreSuccessState(books));
    } catch (e) {
      emit(GetBookByGenreFailureState());
    }
  }

  Future<void> bookDetailInitialEvent(
      BookDetailInitialEvent event, Emitter<BookDetailState> emit) async {
    emit(ChapterFetchingLoadingState());
    try {
      final chapters = await BookRepo.fetchBookChapters(event.bookId);
      final genres = await BookRepo.fetchBookGenre(event.bookId);
      const bool showAllChapters = false;
      emit(ChapterFetchingSuccessState(chapters, genres, showAllChapters));
    } catch (e) {
      emit(ChapterFetchingFailureState());
    }
  }

  void toggleChapterViewEvent(
      ToggleChapterViewEvent event, Emitter<BookDetailState> emit) {
    if (state is ChapterFetchingSuccessState) {
      final currentState = state as ChapterFetchingSuccessState;
      emit(ChapterFetchingSuccessState(currentState.chapters,
          currentState.genres, !currentState.showAllChapters));
    }
  }

  Future<void> chapterSelectedEvent(
      ChapterSelectedEvent event, Emitter<BookDetailState> emit) async {
    emit(NavigateToChapterReadState(event.chapter));
  }
}
