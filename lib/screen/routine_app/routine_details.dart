import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student/models/routine_model.dart';

class RoutineDetails extends StatefulWidget {
  static const routeName = "/routine-details";

  final List<RoutineItem> routineItem;
  final Box<RoutineItem> routineBox;

  const RoutineDetails({Key key, this.routineItem, this.routineBox})
      : super(key: key);

  @override
  _RoutineDetailsState createState() => _RoutineDetailsState();
}

class _RoutineDetailsState extends State<RoutineDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.routineItem);
    return Scaffold(
        appBar: AppBar(
          title: Text('Routine Details '),
        ),
        body: ListView(
          children: <Widget>[
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: widget.routineItem.length,
              itemBuilder: (BuildContext context, int index) {
                final rou = widget.routineItem[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: FittedBox(child: Text('${rou.routineTime}')),
                    radius: 20,
                  ),
                  title: Text("${rou.routineText}"),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.pink,
                      ),
                      onPressed: () async {
                        await widget.routineBox.delete(rou.id);
                        setState(() {
                          widget.routineItem
                              .removeWhere((element) => element.id == rou.id);
                        });
                      }),
                );
              },
            ),
          ],
        ));
  }
}
