part of 'library_bloc.dart';

@immutable
sealed class LibraryBlocEvent {}

class GetLibraryRequested extends LibraryBlocEvent {}
