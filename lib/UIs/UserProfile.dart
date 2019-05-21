import 'package:flutter/material.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Personitem.dart';
import 'package:food_buzz/UIs/Postitem.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget circularimg = Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: NetworkImage('img'))));

    return Scaffold(
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Stack(
                children: <Widget>[
                  Container(
                    color: Color(0XFFd22030),
                    height: 300,
                  )
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PostItem(
                  name: 'Samjhana Pokharel',
                  img: TestData.getImageList()[index],
                  ago: '2hrs ago'),
            );
          }),
    );
  }
}
