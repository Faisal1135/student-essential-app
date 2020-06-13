import 'package:flutter/material.dart';
import 'package:student/models/result_model.dart';
import 'package:student/widgets/piechart.dart';

class ResultofUserScreen extends StatelessWidget {
  static const routeName = '/result-of-user';

  const ResultofUserScreen({
    Key key,
  }) : super(key: key);

  String buildGrade(String grade) {
    grade = grade.trim();
    switch (grade) {
      case "4.0":
        return 'A+';
        break;
      case "3.75":
        return 'A';
        break;
      case "3.50":
        return 'A-';
        break;
      case "3.5":
        return 'A-';
        break;
      case "3.25":
        return 'B+';
        break;
      case "3.00":
        return 'B';
        break;
      case "2.75":
        return 'B-';
        break;
      case "2.50":
        return 'C';
        break;
      case "2.25":
        return 'D';
        break;
      default:
        return "$grade";
    }
  }

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
                  child: Text(buildGrade(result[index].grade.toString())),
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
