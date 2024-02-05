import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/pages/orderDone.dart';
import 'package:sebco_camioniste/views/pages/page.dart';

import '../components/widgets.dart';

class MapsView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _mapState();
}

class _mapState extends State<MapsView>
{
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Widgets.bgColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Widgets.btnColor,
          onPressed: (){
            //action
            GlobalViewModel.transitonPage(context, OrderDone());

          },
          child: Column(
            children: [
              Icon(Icons.done_all, size: 25, color: Colors.white,),
              Text('Terminé', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),)
            ],
          )

      ),
      appBar: AppBar(
        leading: Widgets.backbutton(context, Pages()),
        backgroundColor: Widgets.componentColor,
        title: Text('Les commandes effectuées',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
      );

  }

}