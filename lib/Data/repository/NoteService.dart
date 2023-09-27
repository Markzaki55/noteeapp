import 'package:cloud_firestore/cloud_firestore.dart';
import 'Model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Model/NoteModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Model/NoteModel.dart';

class NoteRepository {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('Notes');

//thats getting all the notes for all users
  // Future<List<Note>> fetchNotes() async {
  //   try {
  //     final querySnapshot = await _notesCollection.get();
  //     return querySnapshot.docs.map((documentSnapshot) {
  //       return Note.fromDocumentSnapshot(documentSnapshot);
  //     }).toList();
  //   } catch (e) {
  //     throw NoteRepositoryException('Error fetching notes: $e');
  //   }
  // }
Future<List<Note>> fetchNotes(String userUid) async {
  try {
    final querySnapshot = await _notesCollection.where('Uid', isEqualTo: userUid).get();
    return querySnapshot.docs.map((documentSnapshot) {
      return Note.fromDocumentSnapshot(documentSnapshot);
    }).toList();
  } catch (e) {
    throw NoteRepositoryException('Error fetching notes: $e');
  }
}
  Future<void> addNote(Note note) async {
    try {
      await _notesCollection.add(note.toMap());
    } catch (e) {
      throw NoteRepositoryException('Error adding note: $e');
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _notesCollection.doc(note.id).update(note.toMap());

    } catch (e) {
      throw NoteRepositoryException('Error updating note: $e');
    }
  }
  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      throw NoteRepositoryException('Error deleting note: $e');
    }
  }
}

class NoteRepositoryException implements Exception {
  final String message;

  NoteRepositoryException(this.message);

  @override
  String toString() {
    return 'NoteRepositoryException: $message';
  }
}



