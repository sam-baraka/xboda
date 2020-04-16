import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Cab extends StatefulWidget {
  @override
  _CabState createState() => _CabState();
}

class _CabState extends State<Cab> {
  Position position;
  getCurrentPosition() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position geoposition) {
      setState(() {
        position = geoposition;
      });
    });
  }

  showDriverDetails({String documentId}) {
    Firestore.instance
        .collection('drivers')
        .document(documentId)
        .get()
        .then((DocumentSnapshot ds) {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
                title: Text("Driver Details"),
                message: Column(children: [Text("Driver Name:" + ds['name'])]),
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () {}, child: Text("Request for a ride")),
                  CupertinoActionSheetAction(
                      onPressed: () {}, child: Text("Call Driver"))
                ],
                cancelButton: CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: Text("Dismiss"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ));
    });
  }

  LoadMapAndMarkers({Position position}) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('driverMarkers').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude)),
                onLongPress: (location) {
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                            title: Text("Location"),
                            message: Text(
                                "This place is located on position ${location.latitude} latitude and ${location.longitude} longitude"),
                            cancelButton: CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Dismiss")),
                          ));
                },
                markers:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new Marker(
                      onTap: () {
                        showDriverDetails(documentId: document.documentID);
                      },
                      markerId: MarkerId(document.documentID),
                      position:
                          LatLng(document['latitude'], document['longitude']));
                }).toSet());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: LoadMapAndMarkers(position: position),
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
