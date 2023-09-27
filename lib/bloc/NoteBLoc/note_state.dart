part of 'note_bloc.dart';

@immutable
abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {
  final List<Note>notes;

  NoteLoadedState(this.notes);
}

class NoteErrorState extends NoteState {
  final String errorMessage;

  NoteErrorState(this.errorMessage);
}
class NoteOperationSuccessState extends NoteState {
  final String successMessage;

  NoteOperationSuccessState(this.successMessage);
}