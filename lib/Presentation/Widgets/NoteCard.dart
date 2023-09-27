// // import 'package:flutter/material.dart';
// // import 'package:noteeapp/Data/repository/Model/NoteModel.dart';
// // import 'package:noteeapp/Presentation/Pages/HomePage.dart';
// // import 'package:noteeapp/Presentation/Pages/NoteDetailPage.dart';

// // // // class NoteCard extends StatelessWidget {
// // // //   final Note note;

// // // //   const NoteCard({required this.note});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Card(
// // // //       elevation: 4.0,
// // // //       shape: RoundedRectangleBorder(
// // // //         borderRadius: BorderRadius.circular(12.0),
// // // //       ),
// // // //       child: InkWell(
// // // //         onTap: () {
// // // //           Navigator.of(context).push(
// // // //             MaterialPageRoute(
// // // //               builder: (context) => NoteDetailPage(initialNote: note),
// // // //             ),
// // // //           );
// // // //         },
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Text(
// // // //                 note.title ?? "",
// // // //                 style: TextStyle(
// // // //                   fontWeight: FontWeight.bold,
// // // //                   fontSize: 16.0,
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: 8.0),
// // // //               Text(
// // // //                 note.content ?? "",
// // // //                 maxLines: 3,
// // // //                 overflow: TextOverflow.ellipsis,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteeapp/Data/repository/Model/NoteModel.dart';
import 'package:noteeapp/Presentation/Pages/NoteDetailPage.dart';
import 'package:noteeapp/bloc/NoteBLoc/note_bloc.dart';

import '../../Data/repository/NoteService.dart';

class NoteCard extends StatefulWidget {
  final Note note;

  const NoteCard({required this.note});

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool isLongPressed = false;
  //int? selectedColorIndex; // Track selected color index
  OverlayEntry? overlayEntry;

  List<Color> colorOptions = [
    Colors.white,
    Colors.purple,
    Colors.green,
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
       color: colorOptions[widget.note.colorIndex!], 
      child: Builder(
        builder: (BuildContext context) {
          return InkResponse(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetailPage(initialNote: widget.note),
                ),
              );
            },
            onLongPress: () {
              setState(() {
                isLongPressed = true;
              });
              showColorSelectorOverlay(context);
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.note.title ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.note.content ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  
  Widget _buildColorSelector() {
  return Positioned(
    top: 0,
    right: 0,
    left: 0,
    bottom: 0,
    child: GestureDetector(
      onTap: () {
        setState(() {
          isLongPressed = false;
        });
        overlayEntry?.remove();
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: colorOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final color = entry.value;
              return GestureDetector(
                onTap: () {
                  onColorSelected(index); // Handle color selection
                  overlayEntry?.remove(); // Remove the overlay after color selection
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  margin: EdgeInsets.all(4),
                  // Add a checkmark icon for the selected color
                  child: widget.note.colorIndex == index
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}


  void showColorSelectorOverlay(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return _buildColorSelector();
      },
    );

    Overlay.of(context)?.insert(overlayEntry!);
  }

  void onColorSelected(int index) {
    setState(() {
      widget.note.colorIndex = index;
    });

    // Update the color index in the Note model
    widget.note.colorIndex = index;

    // Update the color index in Firebase
     context.read<NoteBloc>().add(UpdateNoteEvent(widget.note));
  }
}