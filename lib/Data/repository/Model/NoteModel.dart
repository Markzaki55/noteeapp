import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
   String? id;
   String? title;
   String?content;
   String?Uid;
  int? colorIndex; 

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.Uid,
    this.colorIndex = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Title': title,
      'Content': content,
      'Uid': Uid,
      'ColorIndex': colorIndex,
    };
  }

   Note.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    title = documentSnapshot.get('Title') as String;
    content = documentSnapshot.get('Content') as String;
    Uid = documentSnapshot.get('Uid') as String;
    colorIndex = documentSnapshot.get('ColorIndex') as int;
  }

}
