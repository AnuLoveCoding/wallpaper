import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GoogleMapDemo extends StatefulWidget {
  const GoogleMapDemo({Key? key}) : super(key: key);

  @override
  State<GoogleMapDemo> createState() => _GoogleMapDemoState();
}

class _GoogleMapDemoState extends State<GoogleMapDemo> {

  late  GoogleMapController mycontroller;
  final LatLng _center = const LatLng(28.615311, 76.982407);
  Location _location = Location();
  final Set<Marker> _markers = {};
  late  final LatLng _currentMapPosition = _center;
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_currentMapPosition.toString()),
        position: _currentMapPosition,
        infoWindow: InfoWindow(
            title: 'New Place',
            snippet: 'Welcome to Najafgarh'
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition!= position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mycontroller = controller;
    _location.onLocationChanged.listen((l) {

      mycontroller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target:LatLng(l.latitude!, l.longitude!),zoom: 30)));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children: [
              GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target:_center,
                    zoom: 20.0,
                  ),
                  markers: _markers,
                  onCameraMove: _onCameraMove
              ),


              Padding(
                  padding: const EdgeInsets.only(right: 14.0,top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(

                        onPressed: _onAddMarkerButtonPressed,

                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: Colors.greenAccent,
                        child: const Icon(Icons.directions, size: 30.0),
                      ))),
              Column(
                children: [
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration:InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blueAccent,width: 2)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent,width: 2),

                          ),
                          filled: true,
                          fillColor: Colors.white,

                          prefixIcon: Icon(Icons.location_on,color: Colors.red,),
                          suffixIcon: Icon(Icons.mic,color: Colors.grey,),
                          hintText: 'Search Here'

                      ),
                    ),
                  ),

                ],
              ),
            ])  );




  }
}
