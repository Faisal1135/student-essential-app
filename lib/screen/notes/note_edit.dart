import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student/constant.dart';
import 'package:student/models/note_model.dart';

class EditNotePage extends StatefulWidget {
  static const routeName = "/edit-note-route";
  const EditNotePage({Key key}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  bool isDirty = false;
  bool isNoteNew = true;
  FocusNode titleFocus = FocusNode();
  FocusNode contentFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentNote = ModalRoute.of(context).settings.arguments;
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
                  autofocus: true,
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
                    IconButton(
                      tooltip: 'Mark note as important',
                      icon: Icon(Icons.flag),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        handleDelete();
                      },
                    ),
                    AnimatedContainer(
                      margin: EdgeInsets.only(left: 10),
                      duration: Duration(milliseconds: 200),
                      width: isDirty ? 120 : 0,
                      height: 42,
                      curve: Curves.decelerate,
                      child: RaisedButton.icon(
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomLeft: Radius.circular(80),
                          ),
                        ),
                        icon: Icon(Icons.done),
                        label: Text(
                          'SAVE',
                          style: TextStyle(letterSpacing: 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: handleSave,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleSave() {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      return;
    }
    final NoteModel newNote = NoteModel(
        title: titleController.text,
        content: contentController.text,
        datetime: DateTime.now(),
        isImportent: false,
        noteTag: NoteTag.Notes);
    Hive.box<NoteModel>(kHiveNoteBox).add(newNote);

    setState(() {
      titleController.text = newNote.title;
      contentController.text = newNote.content;
      titleFocus.unfocus();
      contentFocus.unfocus();
    });
  }

  void handleDelete() {}

  void handleBack() {
    Navigator.pop(context);
  }
}
