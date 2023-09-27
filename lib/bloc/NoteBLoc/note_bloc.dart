import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';
import 'package:noteeapp/Data/repository/Model/Usermodel.dart';

import '../../Data/repository/Model/NoteModel.dart';
import '../../Data/repository/NoteService.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;
  final UserRepository userrepo;

  NoteBloc(this.noteRepository,this.userrepo) : super(NoteInitialState()) {
    on<NoteEvent>(_handleNoteLogic);
    
  }

Future<void> _handleNoteLogic(NoteEvent event, Emitter<NoteState> emit) async {
  if (event is FetchNotesEvent) {
    emit(NoteLoadingState());
    try {
      List<Note> notes = await noteRepository.fetchNotes(userrepo.getUserId().toString());
      emit(NoteLoadedState(notes));
    } catch (error) {
      emit(NoteErrorState("Error fetching notes: $error"));
    }
  } else if (event is AddNoteEvent) {
    try {
      await noteRepository.addNote(event.note);
      emit(NoteOperationSuccessState("Note added successfully"));
      add(FetchNotesEvent()); 
    } catch (error) {
      emit(NoteErrorState("Error adding note: $error"));
    }
  } else if (event is UpdateNoteEvent) {
    try {
      await noteRepository.updateNote(event.note);
      emit(NoteOperationSuccessState("Note updated successfully"));
      add(FetchNotesEvent()); 
    } catch (error) {
      emit(NoteErrorState("Error updating note: $error"));
    }
  }else if (event is DeleteNoteEvent) {
    try {
      await noteRepository.deleteNote(event.noteid);
      emit(NoteOperationSuccessState("Note added successfully"));
      add(FetchNotesEvent()); 
    } catch (error) {
      emit(NoteErrorState("Error adding note: $error"));
    }
}
}













    // } else if (event is AddNoteEvent) {
    //   try {
    //     await noteRepository.addNote(event.note);
    //     emit(state);
    //   } catch (e) {
    //     emit(NoteErrorState('Error adding note'));
    //   }
    // } else if (event is UpdateNoteEvent) {
    //   try {
    //     await noteRepository.updateNote(event.note);
    //     emit(state);
    //   } catch (e) {
    //     emit(NoteErrorState('Error updating note'));
    //   }
    // } else if (event is DeleteNoteEvent) {
    //   try {
    //     await noteRepository.deleteNote(event.noteId);
    //     emit(state);
    //   } catch (e) {
    //     emit(NoteErrorState('Error deleting note'));
    //   }
     }
//  }
////}
