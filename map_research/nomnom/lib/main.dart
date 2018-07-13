// api key : AIzaSyBY2u47g_M0ijRI-yFFaGuJdr7xh0NMPbE
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/map_options.dart';
import 'composite_subscribtion.dart';
import 'favorite.dart';
import 'favorite_list_widget.dart';
//import 'favorite_list_widget2.dart';
import 'favorite_manager.dart';
import 'package:map_view/map_view.dart';
import 'package:google_maps_webservice/places.dart' as places;

var apiKey = 'AIzaSyBY2u47g_M0ijRI-yFFaGuJdr7xh0NMPbE';

void main() {
  var manager = FavoriteManager();
  MapView.setApiKey(apiKey);
  runApp(NomNomApp(manager));
}

class NomNomApp extends StatelessWidget {
  final FavoriteManager manager;

  NomNomApp(this.manager);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'NomNom',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: new HomePage(
          manager: manager
        ),
      );
    }
}

class HomePage extends StatefulWidget {
  final FavoriteManager manager;

  HomePage({
    Key key,
    this.manager
  }) : assert(manager != null),
        super(key: key);

  @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapView mapview = new MapView();
  var compositeSubscription = CompositeSubscription();

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          title: Text('Nom Nom'),
        ),
        body: new FavoriteListWidget(
          manager: this.widget.manager,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addFavorite,
          tooltip: 'Add Favorite',
          child: Icon(Icons.add),
        ),
      );
    }

  // -7.752077, 110.394831

  Future _addFavorite() async {
    mapview.show(
      new MapOptions(
        showUserLocation: true,
        title: 'Choose a favorite',
        initialCameraPosition: new CameraPosition(
          new Location(-7.752077, 110.394831), 18.0)
      ),
      toolbarActions: <ToolbarAction>[new ToolbarAction('Close', 1)]
    );

    var sub = mapview.onMapReady.listen((_) => _updateRestaurantsAroundUser());
    compositeSubscription.add(sub);

    sub = mapview.onCameraChanged.listen((cam) => _updateRestaurantsAroundUser());
    compositeSubscription.add(sub);

    sub = mapview.onToolbarAction.listen((id) {
      if (id == 1) {
        mapview.dismiss();
      }
    });
    compositeSubscription.add(sub);
  }

  Future _updateRestaurantsAroundUser() async {
    var mapCenter = await mapview.centerLocation;
    var placeApi = new places.GoogleMapsPlaces(apiKey);
    var placeResponse = await placeApi.searchNearbyWithRadius(
      new places.Location(mapCenter.latitude, mapCenter.latitude), 
      200, type: "restaurant");
    
    if (placeResponse.hasNoResults) {
      print("No results");
      return;
    }

    var results = placeResponse.results;

    _updateMarkersFromResults(results);

    var sub = mapview.onInfoWindowTapped.listen((m) {
      var selectedResult = results.firstWhere((r) => r.id == m.id);
      if (selectedResult != null) {
        _addPlaceToFavorites(selectedResult);
      }
    });
    compositeSubscription.add(sub);
  }

  void _updateMarkersFromResults(List<places.PlacesSearchResult> results) {
    var markers = results.map((r) => Marker(
      r.id, 
      r.name, 
      r.geometry.location.lat, 
      r.geometry.location.lng)).toList();
    var currentMarkers = mapview.markers;
    var markersToRemove = currentMarkers.where((m) => !markers.contains(m));
    var markersToAdd = markers.where((m) => !currentMarkers.contains(m));

    markersToRemove.forEach((m) => mapview.removeMarker(m));
    markersToAdd.forEach((m) => mapview.addMarker(m));
  }

  _addPlaceToFavorites(places.PlacesSearchResult result) {
    var staticMapProvider = StaticMapProvider(apiKey);
    var markers = Marker(result.id, result.name, result.geometry.location.lat, result.geometry.location.lng);
    var url = staticMapProvider.getStaticUriWithMarkers([markers], width: 340, height: 120);
    var favorite = Favorite(
      result.name, 
      result.geometry.location.lat, 
      result.geometry.location.lng, 
      result.vicinity, 
      url.toString());
    widget.manager.addFavorite(favorite);
    mapview.dismiss();
    compositeSubscription.cancel();
  }
}