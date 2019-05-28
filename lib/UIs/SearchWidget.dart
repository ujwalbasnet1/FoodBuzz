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
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(width: 5),
            Expanded(
                child: TextField(
              style: TextStyle(fontSize: 18),
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
