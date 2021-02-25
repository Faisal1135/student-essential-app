import 'package:flutter/material.dart';
import 'package:student/models/result_model.dart';

class ResultofUserScreen extends StatelessWidget {
  static const routeName = '/result-of-user';

  const ResultofUserScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final results = ModalRoute.of(context).settings.arguments as Results;

    final result = results.results;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Result'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.builder(
          itemCount: result.length,
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
      ),
    );
  }
}
