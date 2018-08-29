import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:random_wallpaper/data/mock.dart';
import 'package:random_wallpaper/data/prod.dart';
import 'package:random_wallpaper/data/wallpaper.dart';
import 'package:random_wallpaper/dependencies_injection.dart';
import 'package:random_wallpaper/image_network.dart';
import 'package:random_wallpaper/presenter.dart';
import 'package:random_wallpaper/place_holder_page.dart';
import 'package:random_wallpaper/full_page.dart';

final Injector injector = Injector();
const int FIRST_PAGE_WALLPAPER = 1;
var function = (String msg) => '!!!${msg.toUpperCase()}!!!';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Injector.configure(Flavor.PROD);
  }

  _tryAgainButton(bool _) => setState(() {});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<Wallpapers>(
      future:
          injector.wallpaperRepository.fetchWallpapers(FIRST_PAGE_WALLPAPER),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return PlaceHolderPage(
            title: 'Something wrong occured',
            message: 'Internet not connected. Please Try Again',
            tryAgainButton: _tryAgainButton,
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return WallpaperTile(
              wallpapers: snapshot.data,
            );

          default:
        }
      },
    ));
  }
}

class WallpaperTile extends StatefulWidget {
  final Wallpapers wallpapers;

  WallpaperTile({Key key, this.wallpapers}) : super(key: key);

  @override
  _WallpaperTileState createState() => _WallpaperTileState();
}

class _WallpaperTileState extends State<WallpaperTile> {
  WallpaperLoadMoreStatus loadMoreStatus = WallpaperLoadMoreStatus.STABLE;
  List<Wallpaper> wallpapers;
  int currentPageNumber;
  PageController pageController;

  var meg = function("hello");

  @override
  void initState() {
    // TODO: implement initState
    wallpapers = widget.wallpapers.wallpapers;
    currentPageNumber = widget.wallpapers.page;
    pageController = PageController(viewportFraction: 0.85);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  bool onNotification(ScrollNotification notification) {
    print('runnin\'');
    if (notification is ScrollEndNotification) {
      if (pageController.position.maxScrollExtent > pageController.offset &&
          pageController.position.maxScrollExtent - pageController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == WallpaperLoadMoreStatus.STABLE) {
          print(loadMoreStatus);
          setState(() {
            loadMoreStatus = WallpaperLoadMoreStatus.LOADING;
          });
          injector.wallpaperRepository
              .fetchWallpapers(currentPageNumber + 1)
              .then(
            (wallpaperObject) {
              currentPageNumber = wallpaperObject.page;
              setState(
                () {
                  loadMoreStatus = WallpaperLoadMoreStatus.STABLE;
                  wallpapers.addAll(wallpaperObject.wallpapers);
                },
              );
            },
          );
        }
      }
    }

    return true;
  }

  Widget loadingWidget() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black.withOpacity(0.7),
        ),
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 10.0,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NotificationListener(
        onNotification: onNotification,
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox.fromSize(
                size: Size.fromHeight(MediaQuery.of(context).size.height * 0.9),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: wallpapers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => FullPage(imageUrl: wallpapers[index].imageURL)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                wallpapers[index].imageURL,
                                fit: BoxFit.cover,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.bottomCenter,
                                        end: FractionalOffset.topCenter,
                                        colors: [
                                      Color(0x00000000).withOpacity(0.9),
                                      Color(0xff000000).withOpacity(0.01)
                                    ])),
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Wallpaper ID : ' +
                                            wallpapers[index].id.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Mukta',
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Text(
                                        'Photographer : ' +
                                            wallpapers[index].takenBy,
                                        style: TextStyle(
                                          fontFamily: 'Mukta',
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Text(
                                        'Original Resolution : ' +
                                            wallpapers[index].width.toString() +
                                            ' x ' +
                                            wallpapers[index].height.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Mukta',
                                          fontSize: 10.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                            fit: StackFit.expand,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            loadMoreStatus == WallpaperLoadMoreStatus.LOADING
                ? loadingWidget()
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageController.animateTo(
            0.0,
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 300),
          );
        },
        child: Icon(Icons.first_page),
      ),
    );
  }
}
