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
    on<ToggleChapterViewEvent>(toggleChapterViewEvent);
    on<ChapterSelectedEvent>(chapterSelectedEvent);
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
