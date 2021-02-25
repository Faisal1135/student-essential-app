import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student/constant.dart';
import 'package:student/models/note_model.dart';
import 'package:uuid/uuid.dart';

class EditNotePage extends StatefulWidget {
  static const routeName = "/edit-note-route";
  const EditNotePage({Key key}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  NoteModel currentNote;
  bool isDirty = false;
  bool isNoteNew = true;
  FocusNode titleFocus = FocusNode();
  FocusNode contentFocus = FocusNode();
  NoteTag selectedTag = NoteTag.Home;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentNote = ModalRoute.of(context).settings.arguments as NoteModel;
    if (currentNote == null) {
      currentNote = NoteModel(
          id: Uuid().v4(), title: "", content: "", datetime: DateTime.now());
      isNoteNew = true;
    } else {
      isNoteNew = false;
    }
    titleController.text = currentNote.title;
    contentController.text = currentNote.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: titleFocus,
                  autofocus: isNoteNew,
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSubmitted: (text) {
                    titleFocus.unfocus();
                    FocusScope.of(context).requestFocus(contentFocus);
                  },
                  onChanged: (val) {
                    setState(() {
                      isDirty = true;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter a title',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 32,
                        // fontFamily: 'ZillaSlab',
                        fontWeight: FontWeight.w700),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: contentFocus,
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      isDirty = true;
                    });
                  },
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Start typing...',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
              // ImageFilter.blur()
            ],
          ),
          ClipRRect(
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.amber,
              child: SafeArea(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: handleBack,
                    ),
                    Spacer(),
                    DropdownButton(
                      value: selectedTag,
                      items: [
                        ...noteTagString.entries
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text('${e.value}'),
                                  value: e.key,
                                ))
                            .toList()
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedTag = value;
                        });
                      },
                    ),
                    Spacer(),
                    IconButton(
                      tooltip: 'Mark note as important',
                      icon: Icon(currentNote.isImportent
                          ? Icons.flag
                          : Icons.outlined_flag),
                      onPressed: titleController.text.trim().isNotEmpty &&
                              contentController.text.trim().isNotEmpty
                          ? markImportantAsDirty
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () async {
                        await handleDelete();
                      },
                    ),
                    AnimatedContainer(
                        margin: EdgeInsets.only(left: 5),
                        duration: Duration(milliseconds: 200),
                        width: isDirty ? 80 : 0,
                        height: 42,
                        curve: Curves.decelerate,
                        child: FlatButton(
                          child: Text('SAVE'),
                          onPressed: handleSave,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> handleSave() async {
    if (contentController.text.isEmpty) {
      return;
    }
    setState(() {
      currentNote.title = titleController.text;
      currentNote.content = contentController.text;
      currentNote.noteTag = selectedTag;
      print('Hey there ${currentNote.content}');
    });
    if (isNoteNew) {
      await Hive.box<NoteModel>(kHiveNoteBox).put(currentNote.id, currentNote);
    } else {
      await Hive.box<NoteModel>(kHiveNoteBox).put(currentNote.id, currentNote);
    }
    setState(() {
      isNoteNew = false;
      isDirty = false;
      selectedTag = NoteTag.Home;
    });
    titleFocus.unfocus();
    contentFocus.unfocus();
  }

  void markImportantAsDirty() {
    setState(() {
      currentNote.isImportent = !currentNote.isImportent;
    });
    handleSave();
  }

  Future<void> handleDelete() async {
    if (isNoteNew) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('Delete Note'),
              content: Text('This note will be deleted permanently'),
              actions: <Widget>[
                FlatButton(
                  child: Text('DELETE',
                      style: TextStyle(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                  onPressed: () async {
                    await Hive.box<NoteModel>(kHiveNoteBox)
                        .delete(currentNote.id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('CANCEL',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  void handleBack() {
    Navigator.pop(context);
  }
}

// RaisedButton.icon(
//                         color: Theme.of(context).accentColor,
//                         textColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(80),
//                             bottomLeft: Radius.circular(80),
//                           ),
//                         ),
//                         icon: Icon(Icons.done),
//                         label: Text(
//                           'SAVE',
//                           style: TextStyle(letterSpacing: 1),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         onPressed: handleSave,
//                       ),
