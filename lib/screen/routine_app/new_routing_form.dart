import '../../constant.dart';
import '../../data/day_of_week.dart';
import '../../models/routine_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class NewInputRoutine extends StatefulWidget {
  @override
  _NewInputRoutineState createState() => _NewInputRoutineState();
}

class _NewInputRoutineState extends State<NewInputRoutine> {
  TextEditingController titleController = TextEditingController();
  TimeOfDay pickedTime = TimeOfDay.now();
  int selectedDay = DateTime.now().weekday;

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay _time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      pickedTime = _time;
    });
  }

  List<DropdownMenuItem<int>> getDropDownDay() {
    List<DropdownMenuItem<int>> dropdownitems = [];
    daysOfWeek.forEach((k, v) {
      DropdownMenuItem<int> dropdown = DropdownMenuItem(
        child: Text(v),
        value: k,
      );
      dropdownitems.add(dropdown);
    });
    return dropdownitems;
  }

  Future<void> _submitData(BuildContext context) async {
    if (titleController.text.isEmpty ||
        pickedTime.hour.isNaN ||
        pickedTime.minute == null ||
        selectedDay.isNaN) {
      return;
    }

    final routineProv = Hive.box<RoutineItem>(kHiveRoutineBox);
    final newRoutineItem = RoutineItem(
        id: Uuid().v4(),
        routineText: titleController.text,
        routineTime: pickedTime.format(context),
        weekDay: selectedDay);
    // final routineProv = Provider.of<RoutineProvider>(context, listen: false);
    await routineProv.put(newRoutineItem.id, newRoutineItem);
    setState(() {
      pickedTime = null;
      titleController.text = "";
      selectedDay = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Input your Routine'),
              controller: titleController,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("Choose a Time ")),
                  IconButton(
                      icon: Icon(Icons.alarm_add),
                      onPressed: () async {
                        await selectTime(context);
                      })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("Choose a WeekDay")),
                  DropdownButton(
                      value: selectedDay,
                      items: getDropDownDay(),
                      onChanged: (int val) {
                        setState(() {
                          selectedDay = val;
                        });
                      })
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add item to Routine'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () async {
                await _submitData(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
