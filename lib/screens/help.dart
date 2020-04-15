import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jaytextile/util/const.dart';
import 'package:jaytextile/widgets/whatsapp.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    // final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId('Jay Textile'),
        position: LatLng(
          21.215551,
          72.8456,
        ),
        infoWindow: InfoWindow(
          title: 'Jay Textile',
          snippet:
              '53-54, ajanta diamond industries, a.k.road, near umiyadham temple, Varachha, Surat - 395006',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      _markers['Jay Textile'] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Whatsapp(),
      appBar: AppBar(
        title: Text(
          'FIND US',
          style: TextStyle(
            color: Constants.darkBG,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(
              21.215551,
              72.8456,
            ),
            zoom: 18.0,
          ),
          mapType: MapType.normal,
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
