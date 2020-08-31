import 'package:flutter/material.dart';
import 'package:notes/screen/notes.dart';
import '../control/service.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  Service httpService = Service();

  final TextEditingController titleControl = TextEditingController();

  final TextEditingController noteControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: titleControl,
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
              controller: noteControl,
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
          final String title = titleControl.text;
          final String description = noteControl.text;
          var addnote = await httpService.postData(title, description);
          print(addnote);

          Navigator.pop(context);
        },
        label: Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfff2af29),
      ),
    );
  }
}
