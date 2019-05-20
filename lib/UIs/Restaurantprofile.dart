import 'package:flutter/material.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Postitem.dart';
import 'package:food_buzz/UIs/restaurantitem.dart';

class RestaurantProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                  ),
                  Stack(
                    children: <Widget>[
                      Image.network(
                        'https://blonholiday.files.wordpress.com/2017/02/dhulikhel-lodge-resort.jpg?w=863&h=0&crop=1',
                        height: 244,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 244,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 200,
                    right: 10,
                    left: 10,
                    child: RestaurantItem(
                      img:
                          'https://s-ec.bstatic.com/images/hotel/max1024x768/197/19720210.jpg',
                      location: 'Dhulikhel',
                      name: 'Dhulikhel Restaurant & Bar',
                    ),
                  ),
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
