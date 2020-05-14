import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:student/models/note_model.dart';
import 'package:student/widgets/notegriditem.dart';

class NoteCatagoryScreen extends StatelessWidget {
  static const routeName = "/note-catagory";
  const NoteCatagoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes = ModalRoute.of(context).settings.arguments as List<NoteModel>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int i) => NoteGriditem(
          note: notes[i],
        ),
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
      ),
    );
  }
}
