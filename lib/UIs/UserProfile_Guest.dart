import 'package:flutter/material.dart';
import 'package:food_buzz/Models/User.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';
import 'package:food_buzz/TestData/TestData.dart';
import 'package:food_buzz/UIs/Postitem.dart';

import '../const.dart';

class UserProfileGuest extends StatefulWidget {
  String userID;

  UserProfileGuest({@required this.userID});

  @override
  _UserProfileGuestState createState() => _UserProfileGuestState();
}

class _UserProfileGuestState extends State<UserProfileGuest> {
  bool _isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0),
        body: FutureBuilder<User>(
          future: UserRepos().getProfileByID(widget.userID),
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
                            right:
                                (MediaQuery.of(context).size.width * 0.5) - 56,
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
                      child: _FeedList(widget.userID),
                    );
                  });
            }

            return CircularProgressIndicator();
          },
        ));
  }
}

class _FeedList extends StatefulWidget {
  String friendID;

  _FeedList(this.friendID);

  @override
  __FeedListState createState() => __FeedListState();
}

class __FeedListState extends State<_FeedList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserRepos().friendFeeds(widget.friendID.toString()),
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
