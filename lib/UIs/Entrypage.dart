import 'package:flutter/material.dart';
import 'package:food_buzz/UIs/Restaurantprofile.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Image.asset(
              'assets/images/foodbuzz.jpg',
              width: 200,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Login As',
              style: TextStyle(
                  color: Color(0XFF201e1f),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 38,
                vertical: 8,
              ),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  color: Color(0XFFD22030),
                  child: Text(
                    'RESTAURANT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantProfile()));
                  },
                ),
              ),
            ),
            Text(
              'OR',
              style:
                  TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 38,
                vertical: 8,
              ),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
                  color: Color(0XFFD22030),
                  child: Text(
                    'CUSTOMER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Container()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
