import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_buzz/Models/DishCategories.dart';
import 'package:food_buzz/Models/Restaurant.dart';
import 'package:food_buzz/Models/FoodItem.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/RestaurantRepositories/RestaurantProfileRepo.dart';
import 'package:food_buzz/UIs/AddDish.dart';
import 'package:food_buzz/UIs/restaurantitem.dart';

import 'package:sticky_headers/sticky_headers.dart';

import '../const.dart';

class RestaurantProfile extends StatefulWidget {
  @override
  _RestaurantProfileState createState() => _RestaurantProfileState();
}

class _RestaurantProfileState extends State<RestaurantProfile> {
  final RestaurantProfileRepo _restaurantProfileRepo =
      RestaurantProfileRepo(authenticationRepo: AuthenticationRepo());

  List<FoodItem> foodList = [];
  DishCategories _dishCategories = DishCategories();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _count = 2;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _count,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _topSection(context);
            } else if (index == 1) {
              return StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    height: 48,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.black12, width: 1),
                            bottom:
                                BorderSide(color: Colors.black12, width: 1))),
                    child: FutureBuilder(
                      future: _restaurantProfileRepo.getCategoriesDishes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<DishCategories>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(width: 15);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                    child: InkWell(
                                  onTap: () async {
                                    // show list of items of the category
                                    setState(() {
                                      _dishCategories = snapshot.data[index];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0XFFD22030),
                                        borderRadius: BorderRadius.circular(32),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 2,
                                          ),
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0, horizontal: 16),
                                      child: Text(snapshot.data[index].category,
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ));
                              });
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Container(
                              color: Colors.red, width: 200, height: 200);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  content: ListView.builder(
                      itemCount: _dishCategories.dishes.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return _foodItemBuilder(_FoodItem(
                            name: _dishCategories.dishes[index].name,
                            picURL: _dishCategories.dishes[index].picture
                                    .contains('http')
                                ? _dishCategories.dishes[index].picture
                                : Constant.baseURL +
                                    _dishCategories.dishes[index].picture,
                            price: 'Rs. ' + _dishCategories.dishes[index].price,
                            tagName:
                                'Chicken, Spicy, Lorem, Ipsum, Hello, World, Blab Blah, Haa haha , HEe , Tung Tung'));
                      }));
            }
          },
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              _restaurantProfileRepo.getCategoriesDishes();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddDish()));
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Color(0XFFD22030),
          ),
        )
      ],
    ));
  }

  Widget _foodItemBuilder(_FoodItem foodItem) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(foodItem.picURL,
              fit: BoxFit.cover, width: 64, height: 64),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(foodItem.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.loyalty, size: 12),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(foodItem.tagName,
                          overflow: TextOverflow.clip, maxLines: 2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment,
              children: <Widget>[
                Text(foodItem.price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF333333))),
                SizedBox(height: 10),
                Icon(Icons.add_shopping_cart, size: 24),
              ]),
        ],
      ),
    );
  }

  Widget _topSection(BuildContext context) {
    return FutureBuilder(
      future: _restaurantProfileRepo.getProfile(),
      builder: (BuildContext context, AsyncSnapshot<Restaurant> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              Container(
                height: 300,
              ),
              Stack(
                children: <Widget>[
                  Image.network(
                    snapshot.data.coverImg,
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
                  img: snapshot.data.picture,
                  location: snapshot.data.address,
                  name: snapshot.data.name,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(color: Colors.red, width: 200, height: 200);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _FoodItem {
  String picURL;
  String name;
  String price;
  String tagName;

  _FoodItem({this.picURL, this.name, this.price, this.tagName});
}
