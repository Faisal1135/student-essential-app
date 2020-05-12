import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './screen/notes/note_edit.dart';
import './screen/ocr/homepage.dart';
import './models/result_model.dart';
import './models/routine_model.dart';
import './screen/main_screen.dart';
import './screen/result_app/home_page.dart';
import './screen/result_app/user_input_form.dart';
import './screen/result_app/user_result_screen.dart';
import './screen/result_app/userallresult_screen.dart';
import './screen/routine_app/home_page.dart';
import 'models/note_model.dart';
import 'screen/notes/note_main_page.dart';
import 'screen/skechpad/skechpad.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ColoredPathAdapter());
  Hive.registerAdapter<ResultModel>(ResultModelAdapter());
  Hive.registerAdapter<Results>(ResultsAdapter());
  Hive.registerAdapter<RoutineItem>(RoutineItemAdapter());
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Hive.registerAdapter<NoteTag>(NoteTagAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student essential',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => MainScreen(),
        //Skechpad
        DrawApp.routeName: (context) => DrawApp(),
        //Result App Screens
        ResultAppHomepage.routeName: (context) => ResultAppHomepage(),
        UserFormScreen.routeName: (context) => UserFormScreen(),
        UserResultScreen.routeName: (context) => UserResultScreen(),
        ResultofUserScreen.routeName: (context) => ResultofUserScreen(),

        //Routine App
        RoutinePage.routeName: (context) => RoutinePage(),
        //Ocr APP
        OcrPage.routeName: (context) => OcrPage(),
        //NoteApp
        NotesScreen.routeName: (context) => NotesScreen(),
        EditNotePage.routeName: (context) => EditNotePage()
      },
    );
  }
}
