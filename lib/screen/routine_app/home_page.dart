import '../../widgets/mydrawer.dart';
import '../../widgets/notification.dart';
import '../../constant.dart';
import '../../data/day_of_week.dart';
import '../../models/routine_model.dart';
import './new_routing_form.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RoutinePage extends StatefulWidget {
  static const routeName = '/routine-page';
  const RoutinePage({Key key}) : super(key: key);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  void dispose() {
    Hive.box(kHiveRoutineBox).close();
    super.dispose();
  }

  int getRowHeight(List<RoutineItem> allRoutineFromDb) {
    Map<int, List<RoutineItem>> rotmap = findByDayMap(allRoutineFromDb);
    List<int> lenOfList = [];
    rotmap.forEach((k, v) {
      lenOfList.add(v.length);
    });

    lenOfList.sort();
    return lenOfList.last;
  }

  List<RoutineItem> findRoutineByDay(
      int index, List<RoutineItem> allRoutineFromDb) {
    return allRoutineFromDb
        .where((routine) => routine.weekDay == index)
        .toList();
  }

  Map<int, List<RoutineItem>> findByDayMap(List<RoutineItem> allRoutineFromDb) {
    final newMapOfDay = Map<int, List<RoutineItem>>();
    daysOfWeek.keys.toList().forEach((index) {
      newMapOfDay[index] = findRoutineByDay(index, allRoutineFromDb);
    });
    return newMapOfDay;
  }

  List<DataRow> buildDropDownRows(
      BuildContext context, List<RoutineItem> allRoutineFromDb) {
    var allRoutineMap = findByDayMap(allRoutineFromDb);
    var dataRow = List<DataRow>();

    daysOfWeek.forEach((k, v) {
      DataRow newDataRow = DataRow(cells: [
        DataCell(Text(daysOfWeek[k])),
        DataCell(
          Container(
            child: Column(
              children: allRoutineMap[k]
                  .map(
                    (routine) => Container(
                      margin: EdgeInsets.symmetric(vertical: 2.0),
                      height: 25.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: FittedBox(
                              child: Text("${routine.routineTime}"),
                            ),
                          ),
                          // SizedBox(height: 3.0),
                          // Divider()
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        DataCell(
          Container(
            child: Column(
              children: allRoutineMap[k]
                  .map(
                    (routine) => Container(
                      margin: EdgeInsets.symmetric(vertical: 2.0),
                      height: 25.0,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child:
                                  FittedBox(child: Text(routine.routineText))),
                          // Divider()
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ]);

      dataRow.add(newDataRow);
    });
    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    final routineBox = Hive.box<RoutineItem>(kHiveRoutineBox);
    // int rowHeight ;//need a rowheight
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine App'),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => NewInputRoutine(),
            );
          },
          child: Icon(Icons.add)),
      body: ValueListenableBuilder(
        valueListenable: routineBox.listenable(),
        builder: (BuildContext context, Box<RoutineItem> value, Widget child) {
          final allRoutineFromDb = value.values.toList();
          final payload = value.values
              .where((rou) => rou.weekDay == DateTime.now().weekday)
              .map((rout) => "  ${rout.routineTime} -${rout.routineText} \n")
              .fold(" Today Routine ", (String pre, rou) => pre + rou);
          return ListView(
            children: <Widget>[
              LocalNotification(
                notifyPayload: payload,
              ),
              DataTable(
                  dataRowHeight: getRowHeight(allRoutineFromDb) * 28.0 + 50.0,
                  columns: [
                    DataColumn(label: Text("Day")),
                    DataColumn(label: Text("Time")),
                    DataColumn(label: Text("Routine \nStudent")),
                  ],
                  rows: buildDropDownRows(context, allRoutineFromDb)),
            ],
          );
        },
      ),
    );
  }
}
// Operator Mono, Menlo, Monaco, 'Courier New', monospace
// {1:[Routineitem,Routineitem,Routineitem,]}

// ListView(
//         children: <Widget>[
//           DataTable(
//               dataRowHeight: rowHeight * 27.0 + 50.0,
//               columns: [
//                 DataColumn(label: Text("Day")),
//                 DataColumn(label: Text("Time")),
//                 DataColumn(label: Text("Routine \nStudent")),
//               ],
//               rows: buildDropDownRows(context)),
//         ],
//       ),
