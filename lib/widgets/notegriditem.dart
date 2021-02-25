import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/models/note_model.dart';
import '../screen/notes/note_edit.dart';

class NoteGriditem extends StatelessWidget {
  final NoteModel note;
  final DateFormat _timeFormatter = DateFormat('h:mm');

  NoteGriditem({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, EditNotePage.routeName, arguments: note),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber, //Color(0xFFF5F7FB)
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Text(
              note.title,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _timeFormatter.format(note.datetime),
              style: TextStyle(
                color: Color(0xFFAFB4C6),
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(),
            SizedBox(height: 15.0),
            Text(
              note.content,
              maxLines: 15,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
