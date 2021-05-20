import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/photo.dart';
import 'package:flutter_app/tset.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF051665),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Results> allDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF051665),
        title: Title(
          color: Colors.white,
          child: Text(
            "Now Playing",
          ),
        ),
        leading: Icon(Icons.arrow_back),
      ),
      body:Center(
        child:  FutureBuilder<List<Results>>(
            future: getData(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                    MediaQuery.of(context).size.width / 150, // to specify height
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => newApp()));
                        },
                        child: Card(
                          color: const Color(0xFF051665),
                          child: Row(
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500' + allDataList[index].posterPath,
                                height: 100,
                                width: 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 230,
                                    padding: new EdgeInsets.fromLTRB(10, 0, 1, 0),
                                    child: Text(
                                      allDataList[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(10, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(0, 0, 1, 0),
                                        child: Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      Container(
                                        padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                                        child: Text(
                                          allDataList[index].voteCount.toString() +" View",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          padding:
                                          new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                          child: Icon(
                                            Icons.alarm,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding:
                                        new EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Text(
                                          allDataList[index].popularity.toString(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding:
                                          new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                      Container(
                                        padding:
                                        new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Text(
                                          allDataList[index].releaseDate.toString(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  });
              ;}),
      )

    );
  }

  Future<List<Results>> getData() async {
    var dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1');
    // print(response.data);
    Photo photo = Photo.fromJson(response.data);
    print(photo..totalResults);

    if (response.statusCode == 200) {
      photo.results.forEach((data) {
        allDataList.add(data);
      });
      return allDataList;
    } else {
      return allDataList;
    }
  }
}
