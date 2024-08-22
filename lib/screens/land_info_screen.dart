import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lands_app/models/models.dart';
import 'package:intl/intl.dart';
import 'package:lands_app/screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class LandInfoScreen extends StatefulWidget {
  final Land land;

  LandInfoScreen({Key? key, required this.land}) : super(key: key);

  @override
  State<LandInfoScreen> createState() => _LandInfoScreenState();
}

class _LandInfoScreenState extends State<LandInfoScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        title: Text(widget.land.name!.common.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: 300,
                  child: widget.land.flags!.png != null
                      ? FadeInImage(
                          placeholder: const AssetImage('assets/loading.gif'),
                          image:
                              NetworkImage(widget.land.flags!.png.toString()),
                        )
                      : const Image(
                          image: const AssetImage('assets/noimage.png')),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(color: Colors.black, height: 3),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Región: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(widget.land.region!,
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Subregión: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(widget.land.subregion!,
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Población: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(
                      NumberFormat.decimalPattern()
                          .format(widget.land.population)
                          .replaceAll(",", "."),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Capital: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: widget.land.capital != null
                        ? Text(widget.land.capital![0].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))
                        : const Text(""),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Huso hor.: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: Text(widget.land.timezones![0],
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Escudo: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    width: 200,
                    child: widget.land.coatOfArms!.png != null
                        ? FadeInImage(
                            placeholder: const AssetImage('assets/loading.gif'),
                            image: NetworkImage(
                                widget.land.coatOfArms!.png.toString()),
                          )
                        : const Image(image: AssetImage('assets/noimage.png')),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Latitud: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: widget.land.capitalInfo!.latlng != null
                        ? Text(widget.land.capitalInfo!.latlng![0].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ))
                        : const Text(""),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text("Longitud: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF781f1e),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Expanded(
                    child: widget.land.capitalInfo!.latlng != null
                        ? Text(widget.land.capitalInfo!.latlng![1].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ))
                        : const Text(""),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.web),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Google Maps'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF7e04cc),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () =>
                            _launchURL(widget.land.maps!.googleMaps.toString()),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.map),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Mapa'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFc41c9c),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: (() async {
                          _markers.clear();
                          if (widget.land.capitalInfo!.latlng != null) {
                            _markers.add(
                              Marker(
                                markerId: MarkerId(
                                    widget.land.name!.common.toString()),
                                position: LatLng(
                                    widget.land.capitalInfo!.latlng![0]
                                        .toDouble(),
                                    widget.land.capitalInfo!.latlng![1]
                                        .toDouble()),
                                icon: (widget.land.region == "Americas")
                                    ? BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueBlue)
                                    : (widget.land.region == "Asia")
                                        ? BitmapDescriptor.defaultMarkerWithHue(
                                            BitmapDescriptor.hueGreen)
                                        : (widget.land.region == "Europe")
                                            ? BitmapDescriptor
                                                .defaultMarkerWithHue(
                                                    BitmapDescriptor.hueRed)
                                            : (widget.land.region == "Africa")
                                                ? BitmapDescriptor
                                                    .defaultMarkerWithHue(
                                                        BitmapDescriptor
                                                            .hueViolet)
                                                : BitmapDescriptor
                                                    .defaultMarkerWithHue(
                                                        BitmapDescriptor
                                                            .hueBlue),
                              ),
                            );
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandMapScreen(
                                  land: widget.land,
                                  markers: _markers,
                                  customInfoWindowController:
                                      _customInfoWindowController,
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------
//---------------------------- _launchURL -------------------------------
//-----------------------------------------------------------------------
  void _launchURL(String url) async {
    if (!await launch(url)) {
      throw 'No se puede conectar';
    }
  }
}
