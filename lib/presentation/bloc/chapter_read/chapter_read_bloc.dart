import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/model/chapter.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:fable_cosmic_read_app_fe/data/res/chapter_repo.dart';
import 'package:meta/meta.dart';

part 'chapter_read_event.dart';
part 'chapter_read_state.dart';

class ChapterReadBloc extends Bloc<ChapterReadEvent, ChapterReadState> {
  ChapterReadBloc() : super(ChapterReadInitial()) {
    on<ChapterReadInitialEvent>(_onChapterReadInitialEvent);
    on<ChapterReadNextEvent>(_onChapterReadNextEvent);
    on<ChapterReadPreviousEvent>(_onChapterReadPreviousEvent);
  }

  Future<void> _onChapterReadInitialEvent(
      ChapterReadInitialEvent event, Emitter<ChapterReadState> emit) async {
    emit(ChapterReadLoadingState());
    try {
      final chapter = await ChapterRepo.fetchChapter(event.chapterId);
      final book = await BookRepo.fetchBookById(event.bookId);
      emit(ChapterReadSuccessState(chapter!, book!));
    } catch (e) {
      emit(ChapterReadFailureState());
    }
  }

  Future<void> _onChapterReadNextEvent(
      ChapterReadNextEvent event, Emitter<ChapterReadState> emit) async {
    await _loadChapter(event.chapterId, event.bookId, emit);
  }

  Future<void> _onChapterReadPreviousEvent(
      ChapterReadPreviousEvent event, Emitter<ChapterReadState> emit) async {
    await _loadChapter(event.chapterId, event.bookId, emit);
  }

  Future<void> _loadChapter(
      String chapterId, String bookId, Emitter<ChapterReadState> emit) async {
    emit(ChapterReadLoadingState());
    try {
      final chapter = await ChapterRepo.fetchChapter(chapterId);
      final book = await BookRepo.fetchBookById(bookId);
      emit(ChapterReadSuccessState(chapter!, book!));
    } catch (e) {
      emit(ChapterReadFailureState());
    }
  }
}
