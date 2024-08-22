import 'package:custom_info_window/custom_info_window.dart';
import 'package:lands_app/components/loader_component.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LandsMapScreen extends StatefulWidget {
  final LatLng posicion;
  final Set<Marker> markers;
  final CustomInfoWindowController customInfoWindowController;

  const LandsMapScreen(
      {Key? key,
      required this.posicion,
      required this.markers,
      required this.customInfoWindowController})
      : super(key: key);

  @override
  _LandsMapScreenState createState() => _LandsMapScreenState();
}

class _LandsMapScreenState extends State<LandsMapScreen> {
  bool ubicOk = false;
  double latitud = 0;
  double longitud = 0;
  final bool _showLoader = false;
  Set<Marker> _markers = {};
  MapType _defaultMapType = MapType.normal;
  String direccion = '';
  Position position = const Position(
      longitude: 0,
      latitude: 0,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0);
  CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(31, 64), zoom: 16.0);
  //static const LatLng _center = const LatLng(-31.4332373, -64.226344);

  @override
  void dispose() {
    widget.customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _markers = widget.markers;

    _initialPosition = CameraPosition(target: widget.posicion, zoom: 3.0);

    ubicOk = true;

    // _markers.add(Marker(
    //   markerId: MarkerId(widget.paradaenvio.secuencia.toString()),
    //   position: _center,
    //   infoWindow: InfoWindow(
    //     title: widget.paradaenvio.titular.toString(),
    //     snippet: widget.paradaenvio.domicilio.toString(),
    //   ),
    //   icon: BitmapDescriptor.defaultMarker,
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(('Mapa')),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ubicOk == true
              ? Stack(children: <Widget>[
                  GoogleMap(
                    onTap: (position) {
                      widget.customInfoWindowController.hideInfoWindow!();
                    },
                    myLocationEnabled: true,
                    initialCameraPosition: _initialPosition,
                    onCameraMove: _onCameraMove,
                    markers: _markers,
                    mapType: _defaultMapType,
                    onMapCreated: (GoogleMapController controller) async {
                      widget.customInfoWindowController.googleMapController =
                          controller;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 80, right: 10),
                    alignment: Alignment.topRight,
                    child: Column(children: <Widget>[
                      FloatingActionButton(
                          child: const Icon(Icons.layers),
                          elevation: 5,
                          backgroundColor: const Color(0xfff4ab04),
                          onPressed: () {
                            _changeMapType();
                          }),
                    ]),
                  ),
                  // Center(
                  //   child: Icon(
                  //     Icons.location_on,
                  //     color: Colors.red,
                  //     size: 50,
                  //   ),
                  // ),
                ])
              : Container(),
          _showLoader
              ? const LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
          CustomInfoWindow(
            controller: widget.customInfoWindowController,
            height: 80,
            width: 260,
            offset: 100,
          ),
        ],
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {}

  void _changeMapType() {
    _defaultMapType = _defaultMapType == MapType.normal
        ? MapType.satellite
        : _defaultMapType == MapType.satellite
            ? MapType.hybrid
            : MapType.normal;
    setState(() {});
  }
}
