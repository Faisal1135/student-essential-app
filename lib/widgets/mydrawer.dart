import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hive/hive.dart';
import 'package:student/screen/main_screen.dart';
import '../models/note_model.dart';
import '../models/result_model.dart';
import '../screen/notes/note_main_page.dart';
import '../constant.dart';
import '../screen/ocr/homepage.dart';
import '../screen/routine_app/home_page.dart';
import '../models/routine_model.dart';
import '../screen/result_app/user_result_screen.dart';
import '../screen/skechpad/skechpad.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GFDrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: Text(
                  "Student Essential",
                  style: TextStyle(fontSize: 30, color: Colors.deepPurple),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('HomePage'),
            onTap: () async {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          ListTile(
            leading: Icon(Icons.pending),
            title: Text('Result App'),
            onTap: () async {
              await Hive.openBox<Results>(kresultsBox);
              Navigator.pushReplacementNamed(
                  context, UserResultScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('SkechPad'),
            onTap: () async {
              await Hive.openBox<ColoredPath>(sketchBox);
              Navigator.pushNamed(context, DrawApp.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.watch),
            title: Text('Routine'),
            onTap: () async {
              await Hive.openBox<RoutineItem>(kHiveRoutineBox);
              Navigator.pushReplacementNamed(context, RoutinePage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.text_format),
            title: Text('Text Recognizer'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OcrPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text('Notes'),
            onTap: () async {
              try {
                await Hive.openBox<NoteModel>(kHiveNoteBox);
              } catch (e) {}
              Navigator.pushReplacementNamed(context, NotesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
