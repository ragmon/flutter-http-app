import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Parsing Json")),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data[0]['title']);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future getData() async {
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();
//    data.then((value) {
//      print(value[0]['title']);
//    });

    return data;
  }
}

class Network {
  final String url;

  Network(this.url);

  Future fetchData() async {
    print("$url");
    Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
