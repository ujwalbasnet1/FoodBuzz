import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_buzz/UIs/SearchWidget.dart';
import '../TestData/TestData.dart';

class StaggeredImageView extends StatelessWidget {
  Widget _searchBar = Container(
      // decoration:
      //     BoxDecoration(border: Border.(color: Colors.black26, width: 2)),
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
    ),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFAFAFA),
        elevation: 0,
        title: _searchBar,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 4),
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: TestData.getImageList().length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.black.withOpacity(.75),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.network(
                          TestData.getImageList()[index],
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    });
              },
              child: Image.network(
                TestData.getImageList()[index],
                fit: BoxFit.cover,
              ),
            );
          },
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 3),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
