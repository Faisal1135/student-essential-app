import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:student/constant.dart';
import 'package:student/screen/notes/note_catagory.dart';
import 'package:student/screen/notes/note_edit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../widgets/mydrawer.dart';
import '../../models/note_model.dart';

class NotesScreen extends StatefulWidget {
  static const routeName = "/note-main-screen";
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  final DateFormat _dateFormatter = DateFormat('dd MMM');
  final DateFormat _timeFormatter = DateFormat('h:mm');
  List<NoteModel> showNotes;

  @override
  void initState() {
    super.initState();
  }

  final nonModWid = Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user.jpg'),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(width: 20.0),
            Text(
              'Bear Galib',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
    ],
  );

  Widget _buildCategoryCard(
      int index, NoteTag tag, int count, List<NoteModel> argList) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      onDoubleTap: () {
        Navigator.of(context)
            .pushNamed(NoteCatagoryScreen.routeName, arguments: tag);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 240.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xFF417BFB)
              : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                noteTagString[tag],
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xFFAFB4C6),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildNotesList(List<NoteModel> notes) {
    return Column(
      children: notes
          .map(
            (note) => InkWell(
              onTap: () => Navigator.pushNamed(context, EditNotePage.routeName,
                  arguments: note),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F7FB),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          note.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _timeFormatter.format(note.datetime),
                          style: TextStyle(
                            color: Color(0xFFAFB4C6),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      note.content,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _dateFormatter.format(note.datetime),
                      style: TextStyle(
                        color: Color(0xFFAFB4C6),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EditNotePage.routeName),
          child: Icon(Icons.add)),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<NoteModel>(kHiveNoteBox).listenable(),
        builder: (BuildContext context, Box<NoteModel> value, Widget ch) {
          final Map<NoteTag, int> categories = {
            NoteTag.Important:
                value.values.where((note) => note.isImportent == true).length,
            NoteTag.Work: value.values
                .where((note) => note.noteTag == NoteTag.Work)
                .length,
            NoteTag.Home: value.values
                .where((note) => note.noteTag == NoteTag.Home)
                .length,
            NoteTag.Complete: value.values
                .where((note) => note.noteTag == NoteTag.Complete)
                .length,
          };
          List<NoteModel> allNoteSortDate = value.values.toList()
            ..sort((a, b) => a.datetime.compareTo(b.datetime));

          allNoteSortDate = allNoteSortDate.reversed.toList();

          return ListView(
            children: <Widget>[
              nonModWid,
              Container(
                height: 280.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SizedBox(width: 20.0);
                    }
                    return _buildCategoryCard(
                      index - 1,
                      categories.keys.toList()[index - 1],
                      categories.values.toList()[index - 1],
                      value.values.toList(),
                    );
                  },
                ),
              ),
              _buildNotesList(allNoteSortDate)
            ],
          );
        },
      ),
    );
  }
}

// Padding(
//                 padding: EdgeInsets.only(left: 15.0),
//                 child: TabBar(
//                   controller: _tabController,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Color(0xFFAFB4C6),
//                   indicatorColor: Color(0xFF417BFB),
//                   indicatorSize: TabBarIndicatorSize.label,
//                   indicatorWeight: 4.0,
//                   isScrollable: true,
//                   tabs: <Widget>[
//                     Tab(
//                       child: Text(
//                         'Notes',
//                         style: TextStyle(
//                           fontSize: 22.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Tab(
//                       child: Text(
//                         'Important',
//                         style: TextStyle(
//                           fontSize: 22.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
