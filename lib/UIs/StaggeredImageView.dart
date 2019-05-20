import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../TestData/TestData.dart';

class StaggeredImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
