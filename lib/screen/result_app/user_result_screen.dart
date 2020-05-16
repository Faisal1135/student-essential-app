import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../widgets/mydrawer.dart';
import '../../screen/result_app/home_page.dart';
import '../../screen/result_app/userallresult_screen.dart';
import '../../models/result_model.dart';
import '../../constant.dart';

class UserResultScreen extends StatelessWidget {
  static const routeName = "/user-results-screen";
  @override
  Widget build(BuildContext context) {
    final resultsbox = Hive.box<Results>(kresultsBox);
    return Scaffold(
        appBar: AppBar(
          title: Text('User list'),
        ),
        drawer: MyDrawer(),
        body: ListView(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ResultAppHomepage.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.amber, width: 6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                      ),
                      SizedBox(width: 10),
                      Text("Add Result"),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ),
            buildResultList(resultsbox),
          ],
        ));
  }

  buildResultList(Box<Results> resultsbox) {
    return ValueListenableBuilder(
      valueListenable: resultsbox.listenable(),
      builder: (BuildContext context, Box<Results> value, Widget child) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
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
                Navigator.of(context)
                    .pushNamed(ResultofUserScreen.routeName, arguments: result);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await resultsbox.deleteAt(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
