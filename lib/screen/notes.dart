import 'package:flutter/material.dart';
import 'package:notes/screen/updatedNote.dart';
import '../screen/newnote.dart';
import '../control/service.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Service httpService = Service();

  String date(DateTime dateTime) {
    return ('${dateTime.day}/${dateTime.month}/${dateTime.year}');
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(),                                                                      
                Center(
                  child: Text(
                    'All Notes',
                    style: TextStyle(
                        color: Color(0xfff2af29),
                        fontSize: 50.0,
                        fontFamily: 'CormorantGaramond',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {});
                    })
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            notesUI(context),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewNote(),
              ),
            );
          },
          backgroundColor: Color(0xfff2af29),
          child: Icon(
            Icons.add,
            color: Color(0x0ff000000),
          ),
        ),
      ),
    );
  }

  Widget notesUI(context) {
    return FutureBuilder(
      future: httpService.loadData(),
      builder: (context, snapshot) {
        print("Hello");
        if (snapshot.hasData) {
          return Flexible(
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].note,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdatedNote(snapshot.data[index]),
                                        ),
                                      );
                                    },
                                    child: Text('Edit'),
                                    textColor: Colors.black,
                                    color: Color(0xfff2af29),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        await httpService.deletePost(
                                            snapshot.data[index].id);
                                        setState(() {});
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
