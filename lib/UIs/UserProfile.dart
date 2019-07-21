import 'package:flutter/material.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Postitem.dart';
import 'package:food_buzz/UIs/StaggeredImageView.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_buzz/Blocs/bloc.dart';

import 'CartItem.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var childrenWidget = [
    _profile(),
    StaggeredImageView(),
    StaggeredImageView(),
    StaggeredImageView(),
    _profile()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0XFFD22030),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              title: Container(height: 0, width: 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Container(height: 0, width: 0)),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container(height: 0, width: 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Container(height: 0, width: 0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container(height: 0, width: 0),
          ),
        ],
      ),
      body: childrenWidget[_currentIndex],
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Ujwal Basnet'),
              accountEmail: Text('ujwalbasnet1@gmail.com',
                  style: TextStyle(color: Color(0XFFEEEEEE))),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  'https://pbs.twimg.com/profile_images/919630473411772417/D181509D_400x400.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartItem()));
              },
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.shopping_cart, size: 28),
                    SizedBox(width: 16),
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .dispatch(LoggedOut());
              },
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.lock_open, size: 28),
                    SizedBox(width: 16),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _profile() {
  Widget circularimg = Container(
      width: 112.0,
      height: 112.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(TestData.getImageList()[0]))));

  return NestedScrollView(
    physics: ClampingScrollPhysics(),
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
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
  );
}
