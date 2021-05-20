import 'package:flutter/material.dart';

class newApp extends StatelessWidget {
  const newApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      body: Column(
// Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //FF022F52
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                padding: new EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image.network("https://consequence.net/wp-content/uploads/2017/11/coco-2-e1511388106972.jpg?quality=80"),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(10, 50, 10, 0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Container(
            alignment: Alignment.topLeft,
            padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text("Coco",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.white) ),
          ),
          Row(
            children: [

              Container(
                padding: new EdgeInsets.fromLTRB(10, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Icon(
                  Icons.star,
                  color: Colors.blueGrey,
                ),
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text( "5M review",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 20,
                  )
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text( "2h 25m",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 20,
                  )
              ),
              Container(
                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text( "2019/12/31",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text("good film good film good film good film good film good film good film good film good film\n",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: Colors.white, ),
            ),
          )
        ],
      ),
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}