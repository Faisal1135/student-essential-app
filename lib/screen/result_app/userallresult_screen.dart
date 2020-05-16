import 'package:flutter/material.dart';
import 'package:student/models/result_model.dart';
import 'package:student/widgets/piechart.dart';

class ResultofUserScreen extends StatelessWidget {
  static const routeName = '/result-of-user';

  const ResultofUserScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final results = ModalRoute.of(context).settings.arguments as Results;
    final result = results.allresult;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Result'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.amber,
              child: Text(results.cgpa),
            ),
            title: Text(results.username),
            subtitle: Text(results.id),
          ),
          SizedBox(
            height: 20,
          ),
          PieChartResult(
            pieData: result,
          ),
          SizedBox(height: 40),
          ListView.builder(
            shrinkWrap: true,
            itemCount: result.length,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(result[index].grade.toString()),
                  radius: 20,
                ),
                title: Text(result[index].courseName),
                subtitle: Text(result[index].credit.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
