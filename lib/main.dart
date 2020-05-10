import 'package:flutter/material.dart';
import './screen/main_screen.dart';
import './screen/result_app/home_page.dart';
import './screen/result_app/user_input_form.dart';
import './screen/result_app/user_result_screen.dart';
import './screen/result_app/userallresult_screen.dart';
import 'screen/skechpad/skechpad.dart';

void main() => runApp(MyApp());

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
        //
      },
    );
  }
}
