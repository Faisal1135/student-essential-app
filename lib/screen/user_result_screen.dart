import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student/screen/userallresult_screen.dart';
import '../models/result_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant.dart';

class UserResultScreen extends StatelessWidget {
  static const routeName = "/user-results-screen";
  @override
  Widget build(BuildContext context) {
    final resultsbox = Hive.box<Results>(kresultsBox);
    return Scaffold(
        appBar: AppBar(
          title: Text('User list'),
        ),
        body: Column(
          children: <Widget>[Expanded(child: buildResultList(resultsbox))],
        ));
  }

  buildResultList(Box<Results> resultsbox) {
    return ValueListenableBuilder(
      valueListenable: resultsbox.listenable(),
      builder: (BuildContext context, Box<Results> value, Widget child) {
        return Container(
          height: 500,
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              final result = value.getAt(index);
              return ListTile(
                leading: CircleAvatar(
                  child: result.cgpa == null
                      ? FittedBox(child: Text('No CGPA'))
                      : FittedBox(child: Text(result.cgpa)),
                  radius: 30,
                ),
                title: Text(result.username),
                subtitle: Text(result.id),
                onTap: () {
                  Navigator.of(context).pushNamed(ResultofUserScreen.routeName,
                      arguments: result.results);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await resultsbox.deleteAt(index);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
