import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/data/model/book.dart';
import 'package:fable_cosmic_read_app_fe/data/res/book_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomeInitialEvent>(homeInitialEvent);
    on<BookSelectedEvent>(bookSelectedEvent);
  }

  Future<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(BookFetchingLoadingState());
    try {
      final books = await BookRepo.fetchBooks();
      emit(BookFetchingSuccessState(books));
    } catch (e) {
      emit(BookFetchingFailureState());
    }
  }

  Future<void> bookSelectedEvent(
      BookSelectedEvent event, Emitter<HomeState> emit) async {
    emit(NavigatedToDetailState(event.book));
  }
}
