import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:talabat/src/colors.dart';
import 'package:talabat/src/getxcot.dart';

class MyGPS extends StatefulWidget {
  const MyGPS({Key? key}) : super(key: key);

  @override
  State<MyGPS> createState() => _MyGPSState();
}

class _MyGPSState extends State<MyGPS> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(36.35, 43.15),
    zoom: 14.4746,
  );
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    getGps();
  }

  Future<void> getGps() async {
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Ccolors().globel,
        title: const Text("GPS"),
        actions: [
          GetBuilder<GetxCot>(
              init: GetxCot(),
              builder: (vidue) {
                return IconButton(
                    onPressed: () {
                      if (marker.isNotEmpty) {
                        vidue.addgps(marker[0].position);
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.done));
              })
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.dispose();
        },
        markers: marker.toSet(),
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text(''),
        icon: const Icon(Icons.gps_fixed),
      ),
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    Marker markera = Marker(
        markerId: const MarkerId("i am heir"),
        position: LatLng(_locationData.latitude!, _locationData.longitude!));
    setState(() {
      marker.add(markera);
      _kGooglePlex = CameraPosition(
        target: LatLng(_locationData.latitude!, _locationData.longitude!),
        zoom: 18,
      );
    });
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    _controller.complete();
  }
}
