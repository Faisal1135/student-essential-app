import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:student/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student/widgets/notegriditem.dart';

import '../../constant.dart';

class NoteCatagoryScreen extends StatelessWidget {
  static const routeName = "/note-catagory";
  const NoteCatagoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = ModalRoute.of(context).settings.arguments as NoteTag;

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<NoteModel>(kHiveNoteBox).listenable(),
          builder: (BuildContext context, Box<NoteModel> noteBox, Widget ch) {
            List<NoteModel> notelist = noteBox.values.toList();
            List<NoteModel> notes = tag == NoteTag.Important
                ? notelist.where((note) => note.isImportent == true).toList()
                : notelist.where((note) => note.noteTag == tag).toList();
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int i) => NoteGriditem(
                note: notes[i],
              ),
              staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
            );
          }),
    );
  }
}
// StaggeredGridView.countBuilder(
//         crossAxisCount: 4,
//         itemCount: notes.length,
//         itemBuilder: (BuildContext context, int i) => NoteGriditem(
//           note: notes[i],
//         ),
//         staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
//       ),
