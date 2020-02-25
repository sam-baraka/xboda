import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cab extends StatefulWidget {
  @override
  _CabState createState() => _CabState();
}

class _CabState extends State<Cab> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(-0.7161, 37.1461),
              zoom: 10,
            ),
            markers: {
              Marker(
                  markerId: MarkerId("marker1"),
                  position: LatLng(-0.7161, 37.1461),
                  infoWindow: InfoWindow(
                      title: "Samuel Baraka",
                      snippet: "Tap here to see his details")),
            },
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: CupertinoButton(
                  child: Icon(
                    CupertinoIcons.add_circled,
                    size: 50,
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoPopupSurface(
                          isSurfacePainted: false,
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  radius: 50,
                                ),
                                Text(
                                  "Samuel Baraka",
                                  style: TextStyle(
                                      color: CupertinoTheme.of(context)
                                          .primaryColor),
                                ),
                                StarRating(
                                  size: 20,
                                  color:
                                      CupertinoTheme.of(context).primaryColor,
                                  starCount: 5,
                                  rating: 3.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CupertinoButton(
                                    color:
                                        CupertinoTheme.of(context).primaryColor,
                                    onPressed: () {},
                                    child: Text("See reviews"),
                                  ),
                                ),
                                Text(
                                  "This trip from your location to this location will cost you...",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CupertinoTheme.of(context)
                                          .primaryColor),
                                ),
                                Text(
                                  "Ksh. 200",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: CupertinoColors.activeGreen),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CupertinoButton(
                                    color:
                                        CupertinoTheme.of(context).primaryColor,
                                    onPressed: () {
                                      RequestDemo(context);
                                    },
                                    child: Text("Request"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  })),
              // Positioned(
              //   top: 50,
              //   child: CupertinoTextField() 
              //   )
        ],
      ),
    );
  }
}

void RequestDemo(BuildContext context) async {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("Please wait..."),
            content: CupertinoActivityIndicator(),
          ));
  await Future.delayed(Duration(seconds: 3));
  Navigator.pop(context);
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Icon(
              Icons.check,
              color: Colors.green,
            ),
            content: Text("Ride coming in approximately 10 minutes"),
            actions: <Widget>[
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Dismiss"),
              )
            ],
          ));
}
