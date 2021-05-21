import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/photo.dart';
import 'package:flutter_app/tset.dart';
import 'package:dio/dio.dart';
import 'package:rating_bar/rating_bar.dart';

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
  List<Results> allDataListPopler = [];
  List<Results> allDataListTopRated = [];
  List<Results> allDataListUpComing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFF051665),
        //   title: Title(
        //     color: Colors.white,
        //     child: Text(
        //       "Movie App",
        //     ),
        //   ),
        //   leading: Icon(Icons.home),
        // ),
         DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
        title:
        Title(
            color: Colors.white,
            child: Text(
              "Movie App",
            ),
          ),
          leading: Icon(Icons.home),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Now Playing",
                  ),
                  Tab(
                    text: "Popper",
                  ),
                  Tab(
                    text: "Top Rated",
                  ),
                  Tab(
                    text: "Up Coming",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: FutureBuilder<List<Results>>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      150, // to specify height
                            ),
                            itemCount: allDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsPage(
                                                    result:
                                                        allDataList[index])));
                                  },
                                  child: Card(
                                    color: const Color(0xFF051665),
                                    child: Row(
                                      children: [

                                        Hero(
                                          tag: 'https://image.tmdb.org/t/p/w500' + allDataList[index].posterPath,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    allDataList[index].posterPath,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 230,
                                              padding: new EdgeInsets.fromLTRB(
                                                  10, 0, 1, 0),
                                              child: Text(
                                                allDataList[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.readOnly(
                                                  initialRating:
                                                      (allDataList[index]
                                                                  .voteAverage
                                                                  .toDouble() /
                                                              2)
                                                          .toDouble(),
                                                  isHalfAllowed: true,
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  size: 15,
                                                ),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          3, 0, 3, 0),
                                                  child: Text(
                                                    allDataList[index]
                                                            .voteCount
                                                            .toString() +
                                                        " View",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.alarm,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          0, 10, 10, 0),
                                                  child: Text(
                                                    allDataList[index]
                                                        .popularity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Text(
                                                    allDataList[index]
                                                        .releaseDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
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
                        ;
                      }),
                ),
                Center(
                  child: FutureBuilder<List<Results>>(
                      future: getDataPopler(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      150, // to specify height
                            ),
                            itemCount: allDataListPopler.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsPage(
                                                    result: allDataListPopler[
                                                        index])));
                                  },
                                  child: Card(
                                    color: const Color(0xFF051665),
                                    child: Row(
                                      children: [
                                        Hero(
                                          tag: 'https://image.tmdb.org/t/p/w500' + allDataListPopler[index].posterPath,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    allDataListPopler[index].posterPath,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 230,
                                              padding: new EdgeInsets.fromLTRB(
                                                  10, 0, 1, 0),
                                              child: Text(
                                                allDataListPopler[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.readOnly(
                                                  initialRating:
                                                      (allDataListPopler[index]
                                                                  .voteAverage
                                                                  .toDouble() /
                                                              2)
                                                          .toDouble(),
                                                  isHalfAllowed: true,
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  size: 15,
                                                ),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          3, 0, 3, 0),
                                                  child: Text(
                                                    allDataListPopler[index]
                                                            .voteCount
                                                            .toString() +
                                                        " View",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.alarm,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          0, 10, 10, 0),
                                                  child: Text(
                                                    allDataListPopler[index]
                                                        .popularity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Text(
                                                    allDataListPopler[index]
                                                        .releaseDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
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
                        ;
                      }),
                ),
                Center(
                  child: FutureBuilder<List<Results>>(
                      future: getDataTopRated(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      150, // to specify height
                            ),
                            itemCount: allDataListTopRated.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsPage(
                                                    result: allDataListTopRated[
                                                        index])));
                                  },
                                  child: Card(
                                    color: const Color(0xFF051665),
                                    child: Row(
                                      children: [
                                        Hero(
                                          tag: 'https://image.tmdb.org/t/p/w500' + allDataListTopRated[index].posterPath,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    allDataListTopRated[index].posterPath,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 230,
                                              padding: new EdgeInsets.fromLTRB(
                                                  10, 0, 1, 0),
                                              child: Text(
                                                allDataListTopRated[index]
                                                    .title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.readOnly(
                                                  initialRating:
                                                      (allDataListTopRated[
                                                                      index]
                                                                  .voteAverage
                                                                  .toDouble() /
                                                              2)
                                                          .toDouble(),
                                                  isHalfAllowed: true,
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  size: 15,
                                                ),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          3, 0, 3, 0),
                                                  child: Text(
                                                    allDataListTopRated[index]
                                                            .voteCount
                                                            .toString() +
                                                        " View",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.alarm,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          0, 10, 10, 0),
                                                  child: Text(
                                                    allDataListTopRated[index]
                                                        .popularity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Text(
                                                    allDataListTopRated[index]
                                                        .releaseDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
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
                        ;
                      }),
                ),
                Center(
                  child: FutureBuilder<List<Results>>(
                      future: getDataUpComming(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      150, // to specify height
                            ),
                            itemCount: allDataListUpComing.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsPage(
                                                    result: allDataListUpComing[
                                                        index])));
                                  },
                                  child: Card(
                                    color: const Color(0xFF051665),
                                    child: Row(
                                      children: [
                                        Hero(
                                          tag: 'https://image.tmdb.org/t/p/w500' + allDataListUpComing[index].posterPath,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w500' +
                                                    allDataListUpComing[index].posterPath,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 230,
                                              padding: new EdgeInsets.fromLTRB(
                                                  10, 0, 1, 0),
                                              child: Text(
                                                allDataList[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.readOnly(
                                                  initialRating:
                                                      (allDataListUpComing[
                                                                      index]
                                                                  .voteAverage
                                                                  .toDouble() /
                                                              2)
                                                          .toDouble(),
                                                  isHalfAllowed: true,
                                                  halfFilledIcon:
                                                      Icons.star_half,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star_border,
                                                  size: 15,
                                                ),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          3, 0, 3, 0),
                                                  child: Text(
                                                    allDataListUpComing[index]
                                                            .voteCount
                                                            .toString() +
                                                        " View",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.alarm,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          0, 10, 10, 0),
                                                  child: Text(
                                                    allDataListUpComing[index]
                                                        .popularity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.fromLTRB(
                                                            10, 10, 10, 0),
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                                Container(
                                                  padding:
                                                      new EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Text(
                                                    allDataListUpComing[index]
                                                        .releaseDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
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
                        ;
                      }),
                )
              ],
            ),
          ),
        );
  }

  Future<List<Results>> getData() async {
    allDataList = [];
    var dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
        queryParameters: {});
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

  Future<List<Results>> getDataPopler() async {
    allDataListPopler = [];
    var dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
        queryParameters: {});
    // print(response.data);
    Photo photo = Photo.fromJson(response.data);
    print(photo..totalResults);

    if (response.statusCode == 200) {
      photo.results.forEach((data) {
        allDataListPopler.add(data);
      });
      return allDataListPopler;
    } else {
      return allDataListPopler;
    }
  }

  Future<List<Results>> getDataTopRated() async {
    allDataListTopRated = [];
    var dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
        queryParameters: {});
    // print(response.data);
    Photo photo = Photo.fromJson(response.data);
    print(photo..totalResults);

    if (response.statusCode == 200) {
      photo.results.forEach((data) {
        allDataListTopRated.add(data);
      });
      return allDataListTopRated;
    } else {
      return allDataListTopRated;
    }
  }

  Future<List<Results>> getDataUpComming() async {
    allDataListUpComing = [];
    var dio = Dio();
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
        queryParameters: {});
    // print(response.data);
    Photo photo = Photo.fromJson(response.data);
    print(photo..totalResults);

    if (response.statusCode == 200) {
      photo.results.forEach((data) {
        allDataListUpComing.add(data);
      });
      return allDataListUpComing;
    } else {
      return allDataListUpComing;
    }
  }
}
