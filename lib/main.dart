import 'package:flutter/material.dart';
import 'package:food_buzz/UIs/Entrypage.dart';
import 'package:food_buzz/UIs/Feedpage.dart';
import 'package:food_buzz/UIs/Loginpage.dart';
import 'package:food_buzz/UIs/Personitem.dart';
import 'package:food_buzz/UIs/Postitem.dart';
import 'package:food_buzz/UIs/Restaurantitem.dart';
import 'package:food_buzz/UIs/Restaurantprofile.dart';
import 'package:food_buzz/UIs/StaggeredImageView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: Colors.grey,
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: RestaurantProfile())),
    );
  }
}
// #d22030
