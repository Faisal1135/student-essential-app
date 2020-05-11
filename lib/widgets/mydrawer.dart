import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hive/hive.dart';
import '../constant.dart';
import '../screen/ocr/homepage.dart';
import '../screen/routine_app/home_page.dart';
import '../models/routine_model.dart';
import '../screen/result_app/home_page.dart';
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
            title: Text('Result App'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, ResultAppHomepage.routeName);
            },
          ),
          ListTile(
            title: Text('SkechPad'),
            onTap: () async {
              await Hive.openBox<ColoredPath>(sketchBox);
              Navigator.pushReplacementNamed(context, DrawApp.routeName);
            },
          ),
          ListTile(
            title: Text('Routine'),
            onTap: () async {
              await Hive.openBox<RoutineItem>(kHiveRoutineBox);
              Navigator.pushReplacementNamed(context, RoutinePage.routeName);
            },
          ),
          ListTile(
            title: Text('Text Recognizer'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OcrPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
