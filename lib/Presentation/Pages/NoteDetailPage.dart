

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeapp/Data/repository/Authrepository.dart';
import 'package:noteeapp/Data/repository/Model/NoteModel.dart';
import 'package:noteeapp/bloc/NoteBLoc/note_bloc.dart';

class NoteDetailPage extends StatefulWidget {
  final Note? initialNote;

  NoteDetailPage({this.initialNote});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int Colorindex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialNote != null) {
      _titleController.text = widget.initialNote!.title ?? "";
      _contentController.text = widget.initialNote!.content ?? "";
       if (widget.initialNote!.colorIndex != null) {
      Colorindex = widget.initialNote!.colorIndex!;
    }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  List<Color> colorOptions = [
    Colors.white,
    Colors.purple.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.red.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  appBar: null, // Remove the original AppBar
      body: Container(
        color: colorOptions[Colorindex],
        child: Stack(
          
          children: [
            Positioned(
              top: 33,
              left: 0,
              right: 0,
              child: Container(
                color: colorOptions[Colorindex],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        widget.initialNote != null ? 'Edit Note' : 'New Note',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.save),
                            onPressed: () {
                              final updatedNote = Note(
                                id: widget.initialNote?.id,
                                title: _titleController.text,
                                content: _contentController.text,
                                Uid: UserRepository().getUserId(),
                                colorIndex: widget.initialNote?.colorIndex ?? 0,
                              );
                              if (widget.initialNote != null) {
                                context.read<NoteBloc>().add(UpdateNoteEvent(updatedNote));
                              } else {
                                context.read<NoteBloc>().add(AddNoteEvent(updatedNote));
                              }
                              Navigator.pop(context);
                            },
                          ),
                          if (widget.initialNote != null)
                            IconButton(
                              icon: Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                if (widget.initialNote != null) {
                                  context
                                      .read<NoteBloc>()
                                      .add(DeleteNoteEvent(widget.initialNote!.id.toString()));
                                  Navigator.pop(context);
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 65), // Adjust the margin to match the AppBar's height
              color: colorOptions[Colorindex],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 2.0,
                  color: Colors.yellow.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                       
                        children: [
                          TextField(
                            controller: _titleController,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Title',
                             border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _contentController,
                            style: TextStyle(fontSize: 18 ,color: Colors.black),
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Add your note...',
                              border: UnderlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
