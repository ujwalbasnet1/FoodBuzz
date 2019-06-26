import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.9),
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(width: 5),
            Flexible(
                child: TextField(
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
