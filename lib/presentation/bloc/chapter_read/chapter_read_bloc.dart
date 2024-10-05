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
    on<ChapterReadEvent>((event, emit) {});
    on<ChapterReadInitialEvent>(chapterReadInitialEvent);
  }

  Future<void> chapterReadInitialEvent(
      ChapterReadInitialEvent event, Emitter<ChapterReadState> emit) async {
    emit(ChapterReadLoadingState());
    try {
      final chapter = await ChapterRepo.fetchChapter(event.chapterId);
      emit(ChapterReadSuccessState(chapter!));
    } catch (e) {
      emit(ChapterReadFailureState());
    }
  }
}
