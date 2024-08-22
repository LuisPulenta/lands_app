import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lands_app/components/loader_component.dart';
import 'package:lands_app/helpers/api_helper.dart';
import 'package:lands_app/models/models.dart';
import 'package:lands_app/screens/screens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class LandsHomeScreen extends StatefulWidget {
  const LandsHomeScreen({Key? key}) : super(key: key);

  @override
  State<LandsHomeScreen> createState() => _LandsHomeScreenState();
}

class _LandsHomeScreenState extends State<LandsHomeScreen> {
  //*****************************************************************************
//************************** DEFINICION DE VARIABLES **************************
//*****************************************************************************

  List<Land> _lands = [];
  List<Land> _landsFiltered = [];

  final List<String> _countries = [];
  bool _showLoader = false;
  Land landSelected = Land();

  String _filter = '';
  final String _filterError = '';
  final bool _filterShowError = false;
  final TextEditingController _filterController = TextEditingController();

  final Set<Marker> _markers = {};

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

//*****************************************************************************
//************************** INIT STATE ***************************************
//*****************************************************************************

  @override
  void initState() {
    super.initState();
    _getLands();
  }

//*****************************************************************************
//************************** PANTALLA *****************************************
//*****************************************************************************

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lands App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lands'),
          centerTitle: true,
          actions: <Widget>[
            _landsFiltered.isEmpty
                ? Container()
                : IconButton(onPressed: _showMap, icon: const Icon(Icons.map)),
          ],
        ),
        body: Center(
          child: _showLoader
              ? const LoaderComponent(text: 'Por favor espere...')
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(flex: 3, child: _showFilter()),
                        Expanded(flex: 1, child: _showEraseButton()),
                        Expanded(flex: 1, child: _showSearchButton()),
                      ],
                    ),
                    Expanded(child: _getContent()),
                  ],
                ),
        ),
      ),
    );
  }
//-----------------------------------------------------------------------------
//------------------------------ METODO GETCONTENT --------------------------
//-----------------------------------------------------------------------------

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showLandsCount(),
        Expanded(
          child: _countries.isEmpty ? _noContent() : _getListView(),
        )
      ],
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO SHOWLANDSCOUNT ------------------------
//-----------------------------------------------------------------------------

  Widget _showLandsCount() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      child: Row(
        children: [
          const Text("Cantidad de Países: ",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(_landsFiltered.length.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO NOCONTENT -----------------------------
//-----------------------------------------------------------------------------

  Widget _noContent() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          'No hay Países con ese criterio de búsqueda',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------
//------------------------------ METODO GETLISTVIEW ---------------------------
//-----------------------------------------------------------------------------

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getLands,
      child: ListView(
        children: _landsFiltered.map((e) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Card(
              color: const Color(0xFFC7C7C8),
              shadowColor: Colors.white,
              elevation: 10,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: InkWell(
                onTap: () {
                  landSelected = e;
                  _goInfoLand(e);
                },
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                                'assets/loading.gif'),
                                            image: NetworkImage(
                                                e.flags!.png.toString()),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(e.name!.common.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(e.region.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  )),
                                              Text(e.subregion.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

//*****************************************************************************
//************************** _getLands ****************************************
//*****************************************************************************

  Future<void> _getLands() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estés conectado a Internet',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    Response response = Response(isSuccess: false);
    response = await ApiHelper.getLands();

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    _lands = response.result;

    for (var _land in _lands) {
      _countries.add(
        _land.name!.common.toString(),
      );
    }

    for (var _land in _lands) {
      _land.region ??= "";
      _land.subregion ??= "";
      if (_land.capital == []) {
        _land.capital!.add("");
      }
    }

    _lands.sort((a, b) {
      return a.name!.common
          .toString()
          .toLowerCase()
          .compareTo(b.name!.common.toString().toLowerCase());
    });

    _countries.sort();

    _landsFiltered = _lands;
  }

//-----------------------------------------------------------------
//--------------------- _goInfoLand -------------------------------
//-----------------------------------------------------------------

  void _goInfoLand(Land land) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LandInfoScreen(
                  land: land,
                )));
  }

//-----------------------------------------------------------------
//--------------------- METODO SHOWFILTER -------------------------
//-----------------------------------------------------------------

  Widget _showFilter() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _filterController,
        decoration: InputDecoration(
          iconColor: const Color(0xFF781f1e),
          prefixIconColor: const Color(0xFF781f1e),
          hoverColor: const Color(0xFF781f1e),
          focusColor: const Color(0xFF781f1e),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Buscar...',
          labelText: 'Buscar:',
          errorText: _filterShowError ? _filterError : null,
          prefixIcon: const Icon(Icons.badge),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF781f1e)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          _filter = value;
        },
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- METODO SHOWERASEBUTTON --------------------
//-----------------------------------------------------------------

  Widget _showEraseButton() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                _filterController.text = '';
                _landsFiltered = _lands;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- METODO SHOWSEARCHBUTTON -------------------
//-----------------------------------------------------------------

  Widget _showSearchButton() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(166, 5, 68, 7),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _search(),
            ),
          ),
        ],
      ),
    );
  }

//-----------------------------------------------------------------
//--------------------- METODO SEARCH -----------------------------
//-----------------------------------------------------------------

  _search() async {
    FocusScope.of(context).unfocus();
    if (_filter.isEmpty) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Ingrese un texto a buscar',
          actions: <AlertDialogAction>[
            const AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }
    _landsFiltered = [];
    for (var _land in _lands) {
      if (_land.region!.toLowerCase().contains(_filter.toLowerCase()) ||
          _land.subregion!.toLowerCase().contains(_filter.toLowerCase()) ||
          _land.name!.common!.toLowerCase().contains(_filter.toLowerCase())) {
        _landsFiltered.add(_land);
      }
    }

    _landsFiltered.sort((a, b) {
      return a.name!.common
          .toString()
          .toLowerCase()
          .compareTo(b.name!.common.toString().toLowerCase());
    });

    var a = 1;

    setState(() {});
  }

//*****************************************************************************
//************************** METODO SHOWMAP ***********************************
//*****************************************************************************

  void _showMap() {
    if (_landsFiltered.isEmpty) {
      return;
    }

    _markers.clear();

    double latmin = 180.0;
    double latmax = -180.0;
    double longmin = 180.0;
    double longmax = -180.0;
    double latcenter = 0.0;
    double longcenter = 0.0;

    for (Land land in _landsFiltered) {
      if (land.capitalInfo!.latlng != null) {
        var lat = double.tryParse(land.capitalInfo!.latlng![0].toString()) ?? 0;
        var long =
            double.tryParse(land.capitalInfo!.latlng![1].toString()) ?? 0;

        if (lat.toString().length > 3 && long.toString().length > 3) {
          if (lat < latmin) {
            latmin = lat;
          }
          if (lat > latmax) {
            latmax = lat;
          }
          if (long < longmin) {
            longmin = long;
          }
          if (long > longmax) {
            longmax = long;
          }

          _markers.add(Marker(
            markerId: MarkerId(land.name!.common.toString()),
            position: LatLng(lat, long),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${land.name!.common.toString()}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${land.region.toString()} - ${land.subregion.toString()}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Capital: ${land.capital![0].toString()}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LatLng(lat, long));
            },
            icon: BitmapDescriptor.defaultMarker,
          ));
        }
      }
    }
    latcenter = (latmin + latmax) / 2;
    longcenter = (longmin + longmax) / 2;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandsMapScreen(
          markers: _markers,
          customInfoWindowController: _customInfoWindowController,
          posicion: LatLng(latcenter, longcenter),
        ),
      ),
    );
  }
}
