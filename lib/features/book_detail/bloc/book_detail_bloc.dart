import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/features/book_detail/model/chapter_model.dart';
import 'package:fable_cosmic_read_app_fe/features/book_detail/res/book_detail_repo.dart';
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
      final chapters = await BookDetailRepo.fetchChapter(event.bookId);
      emit(ChapterFetchingSuccessState(chapters));
    } catch (e) {
      emit(ChapterFetchingFailureState());
    }
  }
}
