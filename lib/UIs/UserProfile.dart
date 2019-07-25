import 'package:flutter/material.dart';
import 'package:food_buzz/Models/User.dart';
import 'package:food_buzz/Repo/AuthenticationRepo.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';
import 'package:food_buzz/Repo/UserRepositories/User_RestaurantProfileRepo.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Postitem.dart';
import 'package:food_buzz/UIs/StaggeredImageView.dart';
import 'package:location/location.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_buzz/Blocs/bloc.dart';

import '../const.dart';
import 'CartItem.dart';
import 'Personitem.dart';
import 'Restaurantitem.dart';
import 'Restaurantprofile.dart';
import 'UserProfile_Guest.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData>(
      future: Location().getLocation(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
        if (snapshot.hasData) {
          print('Latitude: ' +
              snapshot.data.latitude.toString() +
              '\nLongitude: ' +
              snapshot.data.longitude.toString());

          UserRepos().updateLocation(location: snapshot.data);
        }
        return getBody();
      },
    );
  }

  Widget getBody() {
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
      body: [
        _Feeds(),
        StaggeredImageView(),
        _NearByUser(),
        _NearByRestaurant(),
        _Profile()
      ][_currentIndex],
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

class _Feeds extends StatefulWidget {
  @override
  __FeedsState createState() => __FeedsState();
}

class __FeedsState extends State<_Feeds> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedItemModel>>(
      future: UserRepos().feeds(),
      builder:
          (BuildContext context, AsyncSnapshot<List<FeedItemModel>> snapshot) {
        if (snapshot.hasData) {
          return NestedScrollView(
            physics: ClampingScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  title: Text('Food Buzz'),
                ),
              ];
            },
            body: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
//                  return Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Column(
//                      children: <Widget>[
//                        snapshot.hasData
//                            ? Text(
//                                snapshot.data[index].name,
//                                style: TextStyle(
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.bold,
//                                    fontFamily: 'Lato'),
//                              )
//                            : Container(
//                                width: 200,
//                                height: 18,
//                                color: Colors.grey.withOpacity(0.85)),
//                      ],
//                    ),
//                  );

                  return PostItem(data: snapshot.data[index]);
                }),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _Profile extends StatefulWidget {
  @override
  __ProfileState createState() => __ProfileState();
}

class __ProfileState extends State<_Profile> {
  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: UserRepos().getProfile(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 3,
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
                          child: snapshot.hasData
                              ? Container(
                                  width: 112.0,
                                  height: 112.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot
                                                  .data.picture
                                                  .contains('http')
                                              ? snapshot.data.picture
                                              : Constant.baseURLB +
                                                  snapshot.data.picture))),
                                )
                              : Container(
                                  width: 112.0,
                                  height: 112.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.85),
                                  ),
                                ),
                        )
                      ],
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          snapshot.hasData
                              ? Text(
                                  snapshot.data.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato'),
                                )
                              : Container(
                                  width: 200,
                                  height: 18,
                                  color: Colors.grey.withOpacity(0.85)),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _FeedList(),
                  );
                });
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class _FeedList extends StatefulWidget {
  @override
  __FeedListState createState() => __FeedListState();
}

class __FeedListState extends State<_FeedList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserRepos().myFeeds(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FeedItemModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostItem(data: snapshot.data[index]);
                });
          }
          return Container();
        });
  }
}

class _NearByRestaurant extends StatefulWidget {
  @override
  __NearByRestaurantState createState() => __NearByRestaurantState();
}

class __NearByRestaurantState extends State<_NearByRestaurant> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserRepos().getNearByRestaurant(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<_Restaurant> restaurantList = rawToRestaurantList(snapshot.data);

          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantProfile(
                            repo: User_RestaurantProfileRepo(
                              authenticationRepo: AuthenticationRepo(),
                              id: restaurantList[index].id.toString(),
                            ),
                          ),
                    ),
                  );
                },
                child: RestaurantItem(
                  name: restaurantList[index].name,
                  img: restaurantList[index].picture,
                  location: restaurantList[index].address,
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }

  List<_Restaurant> rawToRestaurantList(dynamic rawData) {
    List<_Restaurant> restaurantList = [];

    for (int i = 0; i < rawData.length; i++) {
      restaurantList.add(_Restaurant(
        id: rawData[i]['id'],
        name: rawData[i]['name'],
        picture: rawData[i]['picture'],
        address: rawData[i]['address'],
      ));
    }

    return restaurantList;
  }
}

class _NearByUser extends StatefulWidget {
  @override
  __NearByUserState createState() => __NearByUserState();
}

class __NearByUserState extends State<_NearByUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserRepos().getNearByUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<_User> userList = rawToUserList(snapshot.data);

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileGuest(
                            userID: userList[index].id.toString(),
                          ),
                    ),
                  );
                },
                child: PersonItem(
                  name: userList[index].name,
                  img: userList[index].picture,
                  isFollowing: userList[index].following,
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }

  List<_User> rawToUserList(dynamic rawData) {
    List<_User> userList = [];

    for (int i = 0; i < rawData.length; i++) {
      userList.add(_User(
          id: rawData[i]['id'],
          name: rawData[i]['name'],
          picture: rawData[i]['picture'],
          following: rawData[i]['following']));
    }

    return userList;
  }
}

class _Restaurant {
  String id;
  String name;
  String picture;
  String address;

  _Restaurant({this.id, this.name, this.picture, this.address});

  @override
  String toString() {
    return '{name: $name, picture: $picture, address: $address}';
  }
}

class _User {
  String id;
  String name;
  String picture;
  bool following;

  _User({this.id, this.name, this.picture, this.following});

  @override
  String toString() {
    return '{name: $name, picture: $picture, following: $following}';
  }
}
