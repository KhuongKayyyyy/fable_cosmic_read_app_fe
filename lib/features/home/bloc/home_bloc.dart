import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/features/home/model/book_model.dart';
import 'package:fable_cosmic_read_app_fe/features/home/res/BookRepo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomeInitialEvent>(homeInitialEvent);
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
}
