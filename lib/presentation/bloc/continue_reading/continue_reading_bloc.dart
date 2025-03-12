import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/data/model/continue_reading.dart';
import 'package:fable_cosmic_read_app_fe/data/res/continue_reading_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'continue_reading_event.dart';
part 'continue_reading_state.dart';

class ContinueReadingBloc
    extends Bloc<ContinueReadingEvent, ContinueReadingState> {
  ContinueReadingBloc() : super(ContinueReadingInitial()) {
    on<ContinueReadingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ContinueReadingRequestedEvent>(_onContinueReadingRequested);
  }

  Future<void> _onContinueReadingRequested(ContinueReadingRequestedEvent event,
      Emitter<ContinueReadingState> emit) async {
    emit(ContinueReadingLoading());
    try {
      final id =
          await const FlutterSecureStorage().read(key: AppSettings.currentUser);
      final token =
          await const FlutterSecureStorage().read(key: AppSettings.token);
      if (id != null && token != null) {
        final continueReading = await ContinueReadingRepo()
            .getContinueReadingByUserId(userId: id, token: token);
        emit(ContinueReadingSuccess(continueReading));
      } else {
        emit(ContinueReadingFailure('User ID not found'));
      }
    } catch (e) {
      emit(ContinueReadingFailure(e.toString()));
    }
  }
}
