import '../model/album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

class Service {
  Future<List<Note>> loadData() async {
    Response response =
        await http.get('https://simply-note.herokuapp.com/notes/');

    List<Note> notes = [];
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);

    for (int i = 0; i < data.length; i++) {
      notes.add(
        Note(
            note: data[i]["note"], title: data[i]["title"], id: data[i]["_id"]),
      );
    }
    print(response.body);

    return notes;
  }

  Future<List<Note>> postData(String title, String description) async {
    final String apiUrl = "https://simply-note.herokuapp.com/notes/";
    var body = {
      "title": title,
      "note": description,
    };

    var encodedbody = json.encode(body);

    try {
      var response = await http.post(apiUrl, body: encodedbody, headers: {
        "Accept": "application/json", // Must
        "Content-Type": "application/json" // Must
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Writen");
        final String responseString = response.body;
        var temp = noteFromJson(responseString);

        return temp;
      }
    } catch (err) {
      print(err);
    }
  }

  Future<List<Note>> deletePost(String id) async {
    Response delres =
        await http.delete('https://simply-note.herokuapp.com/notes/?id=$id');
    print(delres.statusCode);
    if (delres.statusCode == 200) {
      print("Deleted");
    } else {
      print("Not Possible");
    }
  }

  Future<List<Note>> updateData(String id, String title, String note) async {
    final String apiUrl = "https://simply-note.herokuapp.com/notes/?id=$id";
    var body = {
      "title": title,
      "note": note,
    };

    var encodedbody = json.encode(body);

    try {
      var response = await http.patch(apiUrl, body: encodedbody, headers: {
        "Accept": "application/json", // Must
        "Content-Type": "application/json" // Must
      });
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("Writen");
        final String responseString = response.body;
        var temp = noteFromJson(responseString);

        return temp;
      }
    } catch (err) {
      print(err);
    }
  }
}
