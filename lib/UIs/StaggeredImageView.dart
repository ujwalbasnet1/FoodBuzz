import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_buzz/Repo/UserRepositories/UserRepos.dart';
import '../TestData/TestData.dart';
import 'FoodViewComponent.dart';
import 'SearchPage.dart';

class StaggeredImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFAFAFA),
        elevation: 0,
        title: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: Container(
            child: ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: Container(
                child: Text('Search',
                    style: TextStyle(fontSize: 20, color: Colors.black54)),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: UserRepos().myRecommendations(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RecommendationItemModel>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);

            return Container(
              padding: EdgeInsets.only(top: 4),
              child: new StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: FoodViewComponent(
                                data: snapshot.data[index],
                              ),
                            );
                          });
                    },
                    child: Image.network(
                      snapshot.data[index].picture,
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

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
