import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festivia/providers/geofire_provider.dart';
import 'package:festivia/utils/DateParsed.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:festivia/utils/snackbar.dart' as utils;
import 'package:location/location.dart' as location;

import '../../models/Event.dart';
import '../../providers/event_provider.dart';
import '../detailEvent/detail_event_page.dart';

class SearchController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  Completer<GoogleMapController> _mapController = Completer();
  GeofireProvider _geofireProvider;
  Position _position = Position(
    longitude: 32.8833303,
    latitude: -68.8935386,
  );
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor markerDriver;
  Event event;
  EventProvider _eventProvider = new EventProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    markerDriver = await createMarkerImageFromAsset('assets/ubicacion.png');
    checkGPS();
    _geofireProvider = await GeofireProvider();
    _position = await Geolocator.getLastKnownPosition();
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
      }
    }
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      _position = await Geolocator.getLastKnownPosition(); // UNA VEZ
      centerPosition();
      await getNearbyDrivers();
    } catch (error) {
      utils.Snackbar.showSnackbar(
          context, key, 'Error en la localizacion: $error');
    }
  }

  void centerPosition() {
    if (_position != null) {
      animateCameraToPosition(_position.latitude, _position.longitude);
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Activa el GPS para obtener la posicion');
    }
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0, target: LatLng(latitude, longitude), zoom: 12.2)));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  CameraPosition initialPosition =
      CameraPosition(target: LatLng(-33.5879532, -69.0135705), zoom: 14.0);

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    _mapController.complete(controller);
  }

  Future<void> getNearbyDrivers() async {
    Stream<List<DocumentSnapshot>> stream = await _geofireProvider
        .getNearbyDrivers(_position.latitude, _position.longitude, 50);

    stream.listen((List<DocumentSnapshot> documentList) {
      for (MarkerId m in markers.keys) {
        bool remove = true;

        for (DocumentSnapshot d in documentList) {
          if (m.value == d.id) {
            remove = false;
          }
        }

        if (remove) {
          markers.remove(m);
          refresh();
        }
      }

      for (DocumentSnapshot d in documentList) {
        GeoPoint point = d.get("position")["geopoint"];

        String available = d.get("expired");

        if (DateParse().CompareDate(available) == "available") {
          addMarker(d.id, point.latitude, point.longitude, 'Fiesta disponible',
              d.id, markerDriver);
        }
      }

      refresh();
    });
  }

  void addMarker(String markerId, double lat, double lng, String title,
      String content, BitmapDescriptor iconMarker) {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        rotation: _position.heading,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return FutureBuilder(
                    future: getEventInfo(markerId),
                    builder:
                        (BuildContext context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData) {
                        return _buildBottonNavigationMethod(snapshot.data.id);
                      } else {
                        return Container(
                          height: 150,
                        );
                      }
                    });
              });
        });

    markers[id] = marker;
  }

  Future<Event> getEventInfo(String id) async {
    event = await _eventProvider.getById(id);
    return event;
  }

  SafeArea _buildBottonNavigationMethod(idEvent) {
    getEventInfo(idEvent);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            tag: "eventHighlight$idEvent",
            child: Container(
              height: 150,
              width: 450,
              child: CachedNetworkImage(
                imageUrl: event.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          event.tittle,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          event.dateStartParsed,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Ubuntu",
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              width: 190,
                              child: Text(
                                event.location,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontFamily: "Ubuntu",
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [_buttonReserve(event.id)],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonReserve(String id) {
    return Align(
      child: Container(
        height: 50,
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: InkWell(
          onTap: () => {navigateToDetail(context, id)},
          child: button(),
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      child: Text("Detalles".toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Ubuntu",
          )),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)))),
    );
  }

  Future<BitmapDescriptor> createMarkerImageFromAsset(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  navigateToDetail(BuildContext context, String id) {
    //Navigator.pushNamed(context, 'detail_event', arguments: id);

    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailEvent(
          tag: "eventHighlight$id", url: event.image, event: event);
    }));
  }
}
