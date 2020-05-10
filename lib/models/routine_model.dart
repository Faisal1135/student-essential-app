import '../constant.dart';
import '../data/day_of_week.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'routine_model.g.dart';

@HiveType(typeId: 0)
class RoutineItem {
  @HiveField(0)
  final id;

  @HiveField(1)
  final String routineText;

  @HiveField(2)
  final String routineTime;

  @HiveField(3)
  final int weekDay;

  RoutineItem(
      {@required this.id,
      @required this.routineText,
      @required this.routineTime,
      @required this.weekDay});
}

class RoutineProvider extends ChangeNotifier {
  List<RoutineItem> _allroutine = [];

  List<RoutineItem> get getallroutineItem => [..._allroutine];

  void addManyRoutine(List<RoutineItem> items) {
    _allroutine.addAll(items);
    notifyListeners();
  }

  Future<void> addRoutine(RoutineItem item) async {
    await Hive.box<RoutineItem>(kHiveRoutineBox).add(item);
    notifyListeners();
  }

  List<RoutineItem> findRoutineByDay(int dayindex) {
    return _allroutine.where((rou) => rou.weekDay == dayindex).toList();
  }

  Map<int, List<RoutineItem>> findByDayMap() {
    var newMapOfDay = Map<int, List<RoutineItem>>();

    daysOfWeek.keys.toList().forEach((index) {
      newMapOfDay[index] = findRoutineByDay(index);
    });
    return newMapOfDay;
  }

  int getMaxSize() {
    Map<int, List<RoutineItem>> rotmap = findByDayMap();
    List<int> lenOfList = [];
    rotmap.forEach((k, v) {
      lenOfList.add(v.length);
    });

    lenOfList.sort();
    return lenOfList.last;
  }
}
