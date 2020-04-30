import 'package:flutter/material.dart';
import './screen/home_page.dart';
import './screen/user_input_form.dart';
import './screen/user_result_screen.dart';
import './screen/userallresult_screen.dart';

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
        '/': (context) => Homepage(),
        UserFormScreen.routeName: (context) => UserFormScreen(),
        UserResultScreen.routeName: (context) => UserResultScreen(),
        ResultofUserScreen.routeName: (context) => ResultofUserScreen(),
      },
    );
  }
}
