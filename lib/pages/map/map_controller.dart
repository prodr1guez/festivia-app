import 'dart:async';

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

class MapController {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  Completer<GoogleMapController> _mapController = Completer();
  GeofireProvider _geofireProvider;
  Position _position;
  Position position_club =
      Position(longitude: -69.0147801, latitude: -33.5811374);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  BitmapDescriptor markerDriver;
  Event event;
  EventProvider _eventProvider = new EventProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    checkGPS();
    _geofireProvider = new GeofireProvider();
    _position = await Geolocator.getLastKnownPosition();
    markerDriver = await createMarkerImageFromAsset('assets/ubicacion.png');
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

      centerPosition();
      await getNearbyDrivers();
    } catch (error) {
      utils.Snackbar.showSnackbar(
          context, key, 'Error en la localizacion: $error');
    }
  }

  void centerPosition([double lat, double long]) {
    if (lat != null && long != null) {
      animateCameraToPosition(position_club.latitude, position_club.longitude);
    } else {
      utils.Snackbar.showSnackbar(
          context, key, 'Activa el GPS para obtener la posicion');
    }
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0, target: LatLng(latitude, longitude), zoom: 15)));
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
      CameraPosition(target: LatLng(-33.5811374, -69.0147801), zoom: 15);

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
    _mapController.complete(controller);
  }

  Future<void> getNearbyDrivers() async {
    addMarker("d.id", position_club.latitude, position_club.longitude,
        'Fiesta disponible', "d.id", markerDriver);

    refresh();
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
    );

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
          Container(
            height: 150,
            width: 450,
            child: Image.network(
              event.image,
              fit: BoxFit.fill,
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
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          event.dateStartParsed,
                          style: TextStyle(fontSize: 16),
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
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
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
          onTap: () => {navigateToDetail(context)},
          child: button(),
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      child: Text("Detalles".toUpperCase(), style: TextStyle(fontSize: 14)),
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

  navigateToDetail(BuildContext context) {
    Navigator.pushNamed(context, 'map_page');
  }
}
