import 'package:custom_info_window/custom_info_window.dart';
import 'package:lands_app/components/loader_component.dart';
import 'package:lands_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LandMapScreen extends StatefulWidget {
  final Land land;
  final Set<Marker> markers;
  final CustomInfoWindowController customInfoWindowController;

  const LandMapScreen(
      {Key? key,
      required this.land,
      required this.markers,
      required this.customInfoWindowController})
      : super(key: key);

  @override
  _LandMapScreenState createState() => _LandMapScreenState();
}

class _LandMapScreenState extends State<LandMapScreen> {
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
      const CameraPosition(target: LatLng(31, 64), zoom: 3.0);
  //static const LatLng _center = const LatLng(-31.4332373, -64.226344);

  @override
  void dispose() {
    widget.customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialPosition = (widget.markers.length == 1)
        ? CameraPosition(
            target: LatLng(widget.land.capitalInfo!.latlng![0].toDouble(),
                widget.land.capitalInfo!.latlng![1].toDouble()),
            zoom: 3.0)
        : CameraPosition(
            target: LatLng(widget.land.capitalInfo!.latlng![0].toDouble(),
                widget.land.capitalInfo!.latlng![1].toDouble()),
            zoom: 3.0);
    ubicOk = true;
    _markers = widget.markers;

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
        title: (widget.markers.length == 1)
            ? Text(('País: ${widget.land.name!.common.toString()}'))
            : Text(('Capital: ${widget.land.capital!.toString()}')),
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
                  CustomInfoWindow(
                    controller: widget.customInfoWindowController,
                    height: 140,
                    width: 300,
                    offset: 100,
                  ),
                ])
              : Container(),
          _showLoader
              ? const LoaderComponent(
                  text: 'Por favor espere...',
                )
              : Container(),
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
