part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class FetchNotesEvent extends NoteEvent {}

class FetchedNotesEvent extends NoteEvent {
  final List<Note> notes;

  FetchedNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

class AddNoteEvent extends NoteEvent {
  final Note note;

  AddNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String noteid;

  DeleteNoteEvent(this.noteid);

  @override
  List<Object?> get props => [noteid];
}

