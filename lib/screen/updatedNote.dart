import 'package:flutter/material.dart';
import 'package:notes/screen/notes.dart';
import '../control/service.dart';
import '../model/album.dart';

class UpdatedNote extends StatefulWidget {
  final Note note;
  UpdatedNote(this.note);
  @override
  _UpdatedNoteState createState() => _UpdatedNoteState();
}

class _UpdatedNoteState extends State<UpdatedNote> {
  String title;
  String note;
  Service httpService = Service();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleChange =
        TextEditingController(text: widget.note.title);
    TextEditingController noteChange =
        TextEditingController(text: widget.note.note);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Note',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: Color(0xfff2af29),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: titleChange,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xfff2af29)),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: noteChange,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Note',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.save,
          color: Colors.black,
        ),
        onPressed: () async {
          final String title = titleChange.text;
          final String description = noteChange.text;
          var addnote =
              await httpService.updateData(widget.note.id, title, description);
          print(addnote);

          Navigator.pop(context);
        },
        label: Text(
          'Update',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfff2af29),
      ),
    );
  }
}
