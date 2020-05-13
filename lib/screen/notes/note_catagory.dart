import 'package:flutter/material.dart';
import 'package:student/models/note_model.dart';

class NoteCatagoryScreen extends StatelessWidget {
  static const routeName = "/note-catagory";
  const NoteCatagoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTag =
        ModalRoute.of(context).settings.arguments as List<NoteModel>;
    print(selectedTag);
    return Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: ListView.builder(
          itemCount: selectedTag.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(selectedTag[index].title);
          },
        ));
  }
}
