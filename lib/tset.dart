import 'package:flutter/material.dart';
import 'package:flutter_app/photo.dart';
import 'package:rating_bar/rating_bar.dart';

class MovieDetailsPage extends StatelessWidget {
  //const newApp({Key key}) : super(key: key);
   Results result;
   MovieDetailsPage({this.result,Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    print("data     " +result.title.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  padding: new EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child:Hero(tag:'https://image.tmdb.org/t/p/w500' + result.posterPath,
                    child: Image.network('https://image.tmdb.org/t/p/w500' + result.posterPath,),
                  ),
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
              child: Text(result.title,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white) ),
            ),
            RatingBar.readOnly(
              initialRating: (result.voteAverage.toDouble()/2).toDouble(),
              isHalfAllowed: true,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              size: 15,
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
                  child: Text( result.popularity.toString(),
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
                  child: Text( result.releaseDate,
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
              child: Text(result.overview,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  color: Colors.white, ),
              ),
            )
          ],
        ),
      )
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
