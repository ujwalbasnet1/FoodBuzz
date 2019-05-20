import 'package:flutter/material.dart';

class PersonItem extends StatelessWidget {
  final String img;
  final String name;
  final bool isFollowing;

  PersonItem({this.img, @required this.name, this.isFollowing = false});
  @override
  Widget build(BuildContext context) {
    Widget circularimg = Container(
        width: 64.0,
        height: 64.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(img))));

    String following = isFollowing ? 'Following' : '';

    return Card(
        child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          circularimg,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  following,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
