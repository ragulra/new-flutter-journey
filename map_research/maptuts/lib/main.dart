import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';

var apiKey = 'AIzaSyBY2u47g_M0ijRI-yFFaGuJdr7xh0NMPbE';

void main() {
  MapView.setApiKey(apiKey);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    )
  );
}

class MapPage extends StatefulWidget {
  @override
    _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapView mapView = MapView();
  CameraPosition cameraPosition;
  var staticMapProvider = StaticMapProvider(apiKey);
  Uri staticMapUri;

  List<Marker> markers = <Marker>[
    Marker('1', 'My office', -7.752077, 110.394831, color: Colors.green),
    Marker('2', 'Iprit office', -7.742200, 110.390517, color: Colors.orange),
  ];

  showMap() {
    mapView.show(
      MapOptions(
        mapViewType: MapViewType.normal,
        initialCameraPosition: CameraPosition(Location(-7.752077, 110.394831), 6.0),
        showUserLocation: true,
        title: 'The Location'
      )
    );
    mapView.setMarkers(markers);
    mapView.zoomToFit(padding: 100);

    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
      mapView.zoomToFit(padding: 100);
    });

  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      cameraPosition = CameraPosition(Location(-7.752077, 110.394831), 12.0);
      staticMapUri = staticMapProvider.getStaticUri(
        Location(-7.752077, 110.394831), 
        12, 
        height: 400, 
        width: 600, 
        mapType: StaticMapViewType.roadmap
      );
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Google Maps'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300.0,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Map should show here',
                        textAlign: TextAlign.center,
                      ),  
                    )
                  ),
                  InkWell(
                    child: Center(
                      child: Image.network(staticMapUri.toString()),
                    ),
                    onTap: showMap,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Tap the map to interact',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng: ${cameraPosition.center.longitude}\n\nZoomLevel: ${cameraPosition.zoom}"
              ),
            )
          ],
        ),
      );
    }
}