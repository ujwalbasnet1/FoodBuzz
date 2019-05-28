import 'package:flutter/material.dart';
import 'package:food_buzz/ImageUpload.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantRepo.dart';
import 'package:food_buzz/UIs/Entrypage.dart';
import 'package:food_buzz/UIs/TabViewsPage.dart';

import 'UIs/SearchWidget.dart';
import 'UIs/UserProfile.dart';

import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0XFFD22030),
      ),
      home: Scaffold(
          backgroundColor: Colors.white, body: SafeArea(child: EntryPage())),
    );
  }
}
// 0XFFD22030
