import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../screen/result_app/user_result_screen.dart';
import '../../constant.dart';
import '../../models/result_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserFormScreen extends HookWidget {
  static const routeName = '/user-form-page';
  const UserFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finalcpga = ModalRoute.of(context).settings.arguments as double;
    final usrTextEcontrol = useTextEditingController();
    final studentId = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('User input form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Student Id'),
                  controller: studentId,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Enter Your userName"),
                  controller: usrTextEcontrol,
                  keyboardType: TextInputType.text,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              onPressed: () async {
                final resultsbox = Hive.box<Results>(kresultsBox);
                final newResults = Results(
                    id: studentId.text,
                    results: Hive.box<ResultModel>(kresultBox).values.toList(),
                    username: usrTextEcontrol.text,
                    cgpa: finalcpga.toStringAsFixed(2));
                await resultsbox.add(newResults);
                await Hive.box<ResultModel>(kresultBox).clear();
                Navigator.of(context).pushNamed(UserResultScreen.routeName);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

//  final finalcpga = ModalRoute.of(context).settings.arguments as double;
//     final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User input form'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: <Widget>[
//             FormBuilder(
//               key: _fbkey,
//               child: Column(
//                 children: <Widget>[
//                   FormBuilderTextField(
//                     attribute: 'username',
//                     decoration:
//                         InputDecoration(labelText: "Enter your username"),
//                     validators: [FormBuilderValidators.required()],
//                     keyboardType: TextInputType.text,
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   FormBuilderTextField(
//                     attribute: 'student_id',
//                     decoration:
//                         InputDecoration(labelText: "Enter your student id"),
//                     validators: [
//                       FormBuilderValidators.required(),
//                     ],
//                     keyboardType: TextInputType.number,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             RaisedButton(
//               onPressed: () async {
//                 if (_fbkey.currentState.validate()) {
//                   _fbkey.currentState.save();
//                   final formData = _fbkey.currentState.value;
//                   print(formData);
//                   final resultsbox = Hive.box<Results>(kresultsBox);
//                   final newResults = Results(
//                       id: formData["student_id"],
//                       results:
//                           Hive.box<ResultModel>(kresultBox).values.toList(),
//                       username: formData["username"],
//                       cgpa: finalcpga.toStringAsFixed(2));
//                   await resultsbox.add(newResults);
//                   await Hive.box<ResultModel>(kresultBox).clear();
//                   Navigator.of(context).pushNamed(UserResultScreen.routeName);
//                 }
//               },
//               child: Text("Submit"),
//             )
//           ],
//         ),
//       ),
//     );
