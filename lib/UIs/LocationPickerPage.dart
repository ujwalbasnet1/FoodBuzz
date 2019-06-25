import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class LocationPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mapController = MapController();

    var flutterMap = new FlutterMap(
        mapController: mapController,
        options: new MapOptions(
            center: new LatLng(27.6195514, 85.5386499), minZoom: 5.0),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/rajayogan/cjl1bndoi2na42sp2pfh2483p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidWp3YWxiYXNuZXQxIiwiYSI6ImNqbWFsdmFhdDQ5dGEzb210eW52MzZnenoifQ.-zqkb8_sXKm-7psVD4yFAg",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoidWp3YWxiYXNuZXQxIiwiYSI6ImNqbWFsdmFhdDQ5dGEzb210eW52MzZnenoifQ.-zqkb8_sXKm-7psVD4yFAg',
                'id': 'mapbox.mapbox-streets-v7'
              }),
          // new MarkerLayerOptions(markers: _markers)
        ]);

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            MyHomePage(map: flutterMap),
            Positioned(
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.location_on),
                color: Colors.red,
                iconSize: 45.0,
                onPressed: () {
                  print('Marker tapped');
                },
              ),
              top: (MediaQuery.of(context).size.height - kToolbarHeight - 45) *
                      0.5 -
                  12,
              right: MediaQuery.of(context).size.width * 0.5 - 45 * 0.5,
            ),
            Positioned(
                child: FloatingActionButton(
                  child: Icon(
                    Icons.location_on,
                  ),
                  onPressed: () {
                    print(mapController.center.toString());
                    Navigator.pop(context, mapController.center);
                  },
                ),
                bottom: 15,
                right: 15)
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var map;

  MyHomePage({this.map});

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _markers = [
    // new Marker(
    //     width: 45.0,
    //     height: 45.0,
    //     point: new LatLng(27.6195514, 85.5386499),
    //     builder: (context) => IconButton(
    //           padding: EdgeInsets.all(0),
    //           icon: Icon(Icons.location_on),
    //           color: Colors.blue,
    //           iconSize: 45.0,
    //           onPressed: () {
    //             print('Marker tapped');
    //           },
    //         ))
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: widget.map);
  }
}
