import 'package:flutter/material.dart';
import '../widgets/mydrawer.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Essential'),
      ),
      drawer: MyDrawer(),
      body: Center(child: Text("ITS student essential")),
    );
  }
}
