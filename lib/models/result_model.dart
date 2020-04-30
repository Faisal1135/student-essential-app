import 'package:hive/hive.dart';

part 'result_model.g.dart';

@HiveType(typeId: 0)
class ResultModel {
  @HiveField(0)
  String id;
  // Hive fields go here

  @HiveField(1)
  String courseName;

  @HiveField(2)
  double credit;

  @HiveField(3)
  double grade;

  ResultModel({this.id, this.courseName, this.credit, this.grade});
}

@HiveType(typeId: 1)
class Results {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  List<ResultModel> results = [];

  @HiveField(3)
  String cgpa;

  Results({this.id, this.results, this.username, this.cgpa});

  get allresult => [...results];

  // Hive fields go here
}
