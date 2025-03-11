import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/data/model/library.dart';
import 'package:fable_cosmic_read_app_fe/data/res/library_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryBlocEvent, LibraryBlocState> {
  final storage = const FlutterSecureStorage();
  LibraryBloc() : super(LibraryBlocInitial()) {
    on<LibraryBlocEvent>((event, emit) {});
    on<GetLibraryRequested>(_onGetLibraryEvent);
  }
  Future<void> _onGetLibraryEvent(
    GetLibraryRequested event,
    Emitter<LibraryBlocState> emit,
  ) async {
    emit(GetLibraryLoading());
    try {
      final id = await storage.read(key: AppSettings.currentUser);
      final token = await storage.read(key: AppSettings.token);

      if (id == null || token == null) {
        emit(GetLibraryFailed(message: 'Unauthorized'));
        return;
      }

      final library =
          await LibraryRepo().getLibraryByUserId(token: token, userId: id);
      emit(GetLibrarySuccess(library: library));
    } catch (e) {
      emit(GetLibraryFailed(message: e.toString()));
    }
  }
}
