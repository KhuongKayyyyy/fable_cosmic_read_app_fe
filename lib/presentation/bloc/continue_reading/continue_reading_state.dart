part of 'continue_reading_bloc.dart';

@immutable
sealed class ContinueReadingState {}

final class ContinueReadingInitial extends ContinueReadingState {}

final class ContinueReadingLoading extends ContinueReadingState {}

final class ContinueReadingSuccess extends ContinueReadingState {
  final List<ContinueReadChapter> continueReading;

  ContinueReadingSuccess(this.continueReading);
}

final class ContinueReadingFailure extends ContinueReadingState {
  final String message;

  ContinueReadingFailure(this.message);
}
