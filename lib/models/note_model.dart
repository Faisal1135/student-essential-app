import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 5)
class NoteModel {
  @HiveField(0)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime datetime;

  @HiveField(4)
  NoteTag noteTag;

  @HiveField(5)
  bool isImportent;

  NoteModel(
      {this.title,
      this.content,
      this.datetime,
      this.noteTag,
      this.isImportent = false});
}

@HiveType(typeId: 6)
enum NoteTag {
  @HiveField(0)
  Home,
  @HiveField(1)
  Work,
  @HiveField(2)
  Notes,
  @HiveField(3)
  Complete,
}

const noteTagString = <NoteTag, String>{
  NoteTag.Home: "Home",
  NoteTag.Notes: "Notes",
  NoteTag.Work: "Work",
  NoteTag.Complete: "Complete"
};

// class Note {
//   String title;
//   String content;
//   DateTime date;

//   Note({this.title, this.content, this.date});
// }

//  Map<String, int> categories = {
//   'Notes': 112,
//   'Work': 58,
//   'Home': 23,
//   'Complete': 31,
// };

// final List<Note> notes = [
//   Note(
//     title: 'Buy ticket',
//     content: 'Buy airplane ticket through Kayak for \$318.38',
//     date: DateTime(2019, 10, 10, 8, 30),
//   ),
//   Note(
//     title: 'Walk with dog',
//     content: 'Walk on the street with my favorite dog.',
//     date: DateTime(2019, 10, 10, 8, 30),
//   ),
// ];
