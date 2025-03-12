part of 'continue_reading_bloc.dart';

@immutable
sealed class ContinueReadingEvent {}

class ContinueReadingRequestedEvent extends ContinueReadingEvent {}
