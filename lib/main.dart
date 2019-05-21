import 'package:flutter/material.dart';
import 'package:food_buzz/ImageUpload.dart';
import 'package:food_buzz/UIs/Entrypage.dart';
import 'package:food_buzz/UIs/TabViewsPage.dart';

import 'UIs/UserProfile.dart';

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
          backgroundColor: Colors.white, body: SafeArea(child: UserProfile())),
    );
  }
}
// #d22030
