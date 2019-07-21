import 'package:flutter/material.dart';

import '../const.dart';

class RestaurantItem extends StatelessWidget {
  String img;
  String name;
  String location;
  String openinghours;

  RestaurantItem(
      {@required this.img,
      @required this.name,
      @required this.location,
      this.openinghours = '6:00 AM - 8:00 PM'});
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
                  image: NetworkImage(
                      img.contains('http') ? img : Constant.baseURLB + img),
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
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.black54,
                              size: 12,
                            ),
                            Text(
                              ' ' + location,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Colors.black54,
                              size: 12,
                            ),
                            Text(' ' + openinghours,
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ]),
                )
              ],
            ),
          )),
    );
  }
}
