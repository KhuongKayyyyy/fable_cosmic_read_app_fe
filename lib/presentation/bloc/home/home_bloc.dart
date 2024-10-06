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
    on<BookListSelectedEvent>(bookListSelectedEvent);
  }

  Future<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(BookFetchingLoadingState());
    try {
      final newBooks = await BookRepo.fetchBooks(1);
      final topBooks = await BookRepo.fetchBooks(2);
      final recommendedBooks = await BookRepo.fetchBooks(3);
      emit(BookFetchingSuccessState(newBooks, topBooks, recommendedBooks));
    } catch (e) {
      emit(BookFetchingFailureState());
    }
  }

  Future<void> bookSelectedEvent(
      BookSelectedEvent event, Emitter<HomeState> emit) async {
    emit(NavigatedToDetailState(event.book));
  }

  Future<void> bookListSelectedEvent(
      BookListSelectedEvent event, Emitter<HomeState> emit) async {
    emit(NavigateToViewAllBookState(event.books, event.bookListName));
  }
}
