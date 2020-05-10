import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:student/meta_data.dart';
import 'package:student/models/result_model.dart';
import 'package:uuid/uuid.dart';

class NewResultInput extends StatefulWidget {
  @override
  _NewResultInputState createState() => _NewResultInputState();
}

class _NewResultInputState extends State<NewResultInput> {
  TextEditingController courseInputController;
  TextEditingController creditInputController;
  @override
  void initState() {
    super.initState();
    courseInputController = TextEditingController();
    creditInputController = TextEditingController();
  }

  double selectedCGPA = 4.0;

  List<DropdownMenuItem<double>> getDropdownmenuGPA() {
    List<DropdownMenuItem<double>> dropdownitems = [];
    cgpaFinder.forEach((k, v) {
      DropdownMenuItem<double> dropdown = DropdownMenuItem(
        child: Text(k),
        value: v.toDouble(),
      );
      dropdownitems.add(dropdown);
    });
    return dropdownitems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Course Title'),
            controller: courseInputController,
            keyboardType: TextInputType.text,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Credit'),
            controller: creditInputController,
            keyboardType: TextInputType.number,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'CHOOSE GRADE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.pink),
                ),
                DropdownButton(
                  value: selectedCGPA,
                  items: getDropdownmenuGPA(),
                  onChanged: (double grade) {
                    setState(() {
                      selectedCGPA = grade;
                    });
                  },
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 20.0),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              FlatButton(
                onPressed: () async {
                  ResultModel resultcard = ResultModel(
                      id: Uuid().v4(),
                      courseName: courseInputController.text,
                      credit: double.parse(creditInputController.text),
                      grade: selectedCGPA);
                  await Hive.box<ResultModel>('resultbox').add(resultcard);
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add result to the Card",
                        style: TextStyle(color: Colors.green))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class NewResultInput extends StatelessWidget {
//   const NewResultInput({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
//     return Container(
//       padding: const EdgeInsets.all(10),
//       height: MediaQuery.of(context).size.height * 0.9,
//       child: Column(
//         children: <Widget>[
//           FormBuilder(
//               key: _fbKey,
//               initialValue: {'grade': 4.0},
//               autovalidate: true,
//               child: Column(
//                 children: <Widget>[
//                   FormBuilderTextField(
//                     attribute: "coarseName",
//                     decoration: InputDecoration(labelText: "Course Name"),
//                     keyboardType: TextInputType.text,
//                     validators: [
//                       FormBuilderValidators.required(),
//                       FormBuilderValidators.max(70),
//                     ],
//                   ),
//                   FormBuilderTextField(
//                     attribute: 'credit',
//                     decoration: InputDecoration(labelText: "Enter your credit"),
//                     validators: [
//                       FormBuilderValidators.required(),
//                       FormBuilderValidators.numeric(),
//                     ],
//                   ),
//                   FormBuilderDropdown(
//                     attribute: 'grade',
//                     decoration: InputDecoration(labelText: "Choose Grade"),
//                     items: cgpaFinder.keys.map((k) {
//                       return DropdownMenuItem(
//                         value: cgpaFinder[k],
//                         child: Text(k),
//                       );
//                     }).toList(),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
