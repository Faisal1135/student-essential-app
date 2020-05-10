import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../widgets/mydrawer.dart';
import '../../models/result_model.dart';
import '../../screen/result_app/user_input_form.dart';
import '../../widgets/new_result_form.dart';

class ResultAppHomepage extends StatefulWidget {
  static const routeName = '/result-homepage';
  static const resultbox = "resultbox";
  static const resultsbox = "resultsbox";

  @override
  _ResultAppHomepageState createState() => _ResultAppHomepageState();
}

class _ResultAppHomepageState extends State<ResultAppHomepage> {
  Future<void> inithive() async {
    await Hive.initFlutter();
    try {
      Hive.registerAdapter<ResultModel>(ResultModelAdapter());
      Hive.registerAdapter<Results>(ResultsAdapter());
    } catch (e) {
      print(e);
    }
    await Hive.openBox<ResultModel>(ResultAppHomepage.resultbox);
    await Hive.openBox<Results>(ResultAppHomepage.resultsbox);
  }

  double finalresult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Calculator'),
        actions: <Widget>[
          IconButton(
              disabledColor: Colors.black26,
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(UserFormScreen.routeName,
                    arguments: finalresult);
              })
        ],
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showModalBottomSheet(
              context: context, builder: (_) => NewResultInput());
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: inithive(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: buildListtile(context),
                  )
                ],
              ),
            );
          }
          return Text("Something went wrong bro");
        },
      ),
    );
  }

  Widget buildListtile(context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<ResultModel>(ResultAppHomepage.resultbox).listenable(),
      builder: (BuildContext context, Box<ResultModel> value, Widget child) {
        return Column(
          children: <Widget>[
            Card(
              elevation: 5.0,
              color: Colors.pink,
              margin: const EdgeInsets.all(10),
              child: getResult(value),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final resultcard = value.values.toList();
                  return ListTile(
                    title: Text(resultcard[index].courseName),
                    subtitle: Text(resultcard[index].credit.toString()),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await value.deleteAt(index);
                      },
                    ),
                    leading: CircleAvatar(
                      child: Text(resultcard[index].grade.toString()),
                      radius: 30,
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget getResult(Box<ResultModel> box) {
    final totalscore = box.values
        .map((res) => res.credit * res.grade)
        .toList()
        .fold(0.0, (double pre, next) => pre + next);
    final totalcredit = box.values
        .map((res) => res.credit)
        .toList()
        .fold(0.0, (double prev, ele) => prev + ele);
    final result = totalscore / totalcredit;
    finalresult = result;

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(
            result.isNaN
                ? 'No result'
                : "Your CGPA - ${result.toStringAsFixed(2)}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            result.isNaN
                ? 'No result'
                : "Total credit - ${totalcredit.toStringAsFixed(2)}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
