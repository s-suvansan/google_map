import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    ));

const double CAMERA_ZOOM = 8;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 0;
// const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);

const LatLng SOURCE_LOCATION = LatLng(6.922412430397618, 79.86935388933027);
const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "GOOGLE_MAP_API_KEY";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  List<Color> _pathColors = [Colors.red, Colors.blue, Colors.green, Colors.orange];
  List<LatLng> _destinations = [
    LatLng(6.922412430397618, 79.86935388933027),
    LatLng(8.750797849273924, 80.50656095363263),

    LatLng(9.694241727302067, 80.03964198410073),
    LatLng(8.320223407960233, 80.39329453158143), //kili
    LatLng(9.694241727302067, 80.03964198410073),
  ];

  //
  double southWestLatitude;
  double southWestLongitude;
  double northEastLatitude;
  double northEastLongitude;
  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    // sourceIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/destination_map_marker.png');
    sourceIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    // sourceIcon = BitmapDescriptor.hueBlue
    double startLatitude = _destinations[0].latitude;
    double startLongitude = _destinations[0].longitude;
    double destinationLatitude = _destinations[_destinations.length - 1].latitude;
    double destinationLongitude = _destinations[_destinations.length - 1].longitude;

    double miny = (startLatitude <= destinationLatitude) ? startLatitude : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude) ? startLongitude : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude) ? destinationLatitude : startLatitude;
    double maxx = (startLongitude <= destinationLongitude) ? destinationLongitude : startLongitude;

    southWestLatitude = miny;
    southWestLongitude = minx;

    northEastLatitude = maxy;
    northEastLongitude = maxx;

// Accommodate the two locations within the
// camera view of the map
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation =
        CameraPosition(zoom: CAMERA_ZOOM, bearing: CAMERA_BEARING, tilt: CAMERA_TILT, target: SOURCE_LOCATION);
    return GoogleMap(
        myLocationEnabled: true,
        compassEnabled: true,
        tiltGesturesEnabled: false,
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        onMapCreated: onMapCreated);
  }

  void onMapCreated(GoogleMapController controller) {
    // controller.setMapStyle(Utils.mapStyles);
    // _controller.complete(controller);
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      for (var i = 0; i < _destinations.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId('sourcePin$i'),
            position: _destinations[i],
            icon: sourceIcon,
            onTap: () => print("clicked"),
          ),
        );
      }
      // source pin
      // _markers.add(Marker(markerId: MarkerId('sourcePin'), position: SOURCE_LOCATION, icon: sourceIcon));
      // destination pin
      // _markers.add(Marker(markerId: MarkerId('destPin'), position: DEST_LOCATION, icon: destinationIcon));
    });
  }

  setPolylines() async {
    for (var i = 0; i < _destinations.length - 1; i++) {
/*           List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey, SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude, DEST_LOCATION.latitude, DEST_LOCATION.longitude); */
      List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        _destinations[i].latitude,
        _destinations[i].longitude,
        _destinations[i + 1].latitude,
        _destinations[i + 1].longitude,
      );
      if (result.isNotEmpty) {
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      setState(() {
        // create a Polyline instance
        // with an id, an RGB color and the list of LatLng pairs
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly$i"),
            width: 2,
            color: _pathColors[0] /* Color.fromARGB(255, 40, 122, 198) */,
            points: polylineCoordinates);

        // add the constructed polyline as a set of points
        // to the polyline set, which will eventually
        // end up showing up on the map
        _polylines.add(polyline);
      });
    }
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
