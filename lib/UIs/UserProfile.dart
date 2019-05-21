import 'package:flutter/material.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Personitem.dart';
import 'package:food_buzz/UIs/Postitem.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget circularimg = Container(
        width: 112.0,
        height: 112.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(TestData.getImageList()[0]))));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: false,
              title: Text('Food Buzz'),
            ),
          ];
        },
        body: ListView.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Stack(
                  children: <Widget>[
                    Container(height: 150),
                    Container(
                      color: Color(0XFFd22030),
                      height: 94,
                    ),
                    Positioned(
                      bottom: 0,
                      right: (MediaQuery.of(context).size.width * 0.5) - 56,
                      child: circularimg,
                    )
                  ],
                );
              } else if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Samjhana Pokharel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato'),
                      ),
                      Container(
                        color: Color(0XFFD22030),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                        child: Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
