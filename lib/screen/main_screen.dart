import 'package:flutter/material.dart';
import '../widgets/mydrawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool run = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Student Essential'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          Center(child: Text("ItS Student Essential")),
        ],
      ),
    );
  }
}
