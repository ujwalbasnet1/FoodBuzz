import 'package:flutter/material.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/UserRepositories/SearchRepo.dart';
import 'package:food_buzz/Repo/UserRepositories/User_RestaurantProfileRepo.dart';

import '../const.dart';
import 'Personitem.dart';
import 'Restaurantitem.dart';
import 'Restaurantprofile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<_User> userList = [];
  List<_Restaurant> restaurantList = [];
  List<_Dish> dishList = [];

  void extractDataFromRaw(var rawData) {
    var rawDishes = rawData['dishes'];

    List<_Dish> _dishList = [];
    List<_User> _userList = [];
    List<_Restaurant> _restaurantList = [];

    rawDishes.forEach((rawDish) {
      _dishList.add(_Dish(
        id: rawDish['id'],
        name: rawDish['name'],
        picture: rawDish['picture'],
        price: rawDish['price'],
      ));
    });

    // users
    var rawUsers = rawData['users'];

    rawUsers.forEach((rawUser) {
      _userList.add(_User(
        id: rawUser['id'],
        name: rawUser['name'],
        picture: rawUser['picture'],
      ));
    });

    // restaurants
    var rawRestaurants = rawData['restaurants'];

    rawRestaurants.forEach((rawRestaurant) {
      _restaurantList.add(_Restaurant(
          id: rawRestaurant['id'],
          name: rawRestaurant['name'],
          picture: rawRestaurant['picture'],
          address: rawRestaurant['address']));
    });

    setState(() {
      this.dishList = _dishList;
      this.restaurantList = _restaurantList;
      this.userList = _userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0.25),
          elevation: 0,
          title: Container(
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: TextField(
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onSubmitted: (String text) async {
                  print('\n\n\nSubmitted $text');
                  dynamic rawData = await SearchRepo().search(searchText: text);
                  extractDataFromRaw(rawData);
                },
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Color(0XFFD22030),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.fastfood)),
              Tab(icon: Icon(Icons.restaurant, color: Colors.white)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(child: _dishList()),
            Container(child: _restaurantList()),
            Container(child: _userList()),
          ],
        ),
      ),
    );
  }

  Widget _userList() {
    return ListView.builder(
      itemCount: this.userList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print(
                '\n\n\n\nUser Clicked: ' + this.userList[index].id.toString());
          },
          child: PersonItem(
            name: this.userList[index].name,
            img: this.userList[index].picture,
            isFollowing: false,
          ),
        );
      },
    );
  }

  Widget _restaurantList() {
    return ListView.builder(
      itemCount: this.restaurantList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print('\n\n\n\nUser Clicked: ' +
                this.restaurantList[index].id.toString());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantProfile(
                      repo: User_RestaurantProfileRepo(
                        authenticationRepo: AuthenticationRepo(),
                        id: this.restaurantList[index].id.toString(),
                      ),
                    ),
              ),
            );
          },
          child: RestaurantItem(
            name: this.restaurantList[index].name,
            img: this.restaurantList[index].picture,
            location: this.restaurantList[index].address,
          ),
        );
      },
    );
  }

  Widget _dishList() {
    return ListView.builder(
      itemCount: this.dishList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print(
                '\n\n\n\nUser Clicked: ' + this.dishList[index].id.toString());
          },
          child: _DishItemWidget(
            dish: _Dish(
              name: this.dishList[index].name,
              picture: this.dishList[index].picture,
              price: this.dishList[index].price,
            ),
          ),
        );
      },
    );
  }
}

class _User {
  int id;
  String name;
  String picture;

  _User({this.id, this.name, this.picture});

  @override
  String toString() {
    return '{name: $name, picture: $picture}';
  }
}

class _Restaurant {
  int id;
  String name;
  String picture;
  String address;

  _Restaurant({this.id, this.name, this.picture, this.address});

  @override
  String toString() {
    return '{name: $name, picture: $picture, address: $address}';
  }
}

class _Dish {
  int id;
  String name;
  String picture;
  int price;

  _Dish({this.id, this.name, this.picture, this.price});

  @override
  String toString() {
    return '{name: $name, picture: $picture, price: $price}';
  }
}

class _DishItemWidget extends StatelessWidget {
  _Dish dish;

  _DishItemWidget({this.dish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Image(
                  height: 72,
                  width: 86,
                  image: NetworkImage(dish.picture.contains('http')
                      ? dish.picture
                      : Constant.baseURLB + dish.picture),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          dish.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Rs.' + dish.price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black38),
                        ),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}
