

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import 'package:sebco_camioniste/views/pages/page.dart';

import '../../model/driverModel.dart';
import '../../model/truckModel.dart';
import '../../viewModel/databaseManager/databaseManager.dart';
import 'editProfil.dart';

class AddTruck extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTruckState();
}

class _AddTruckState extends State<AddTruck> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        //GlobalViewModel.writeImage(data: _imageFile);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Future<Uint8List> fileToUint8List(File file) async
    {
      //ouvrir le fichier en lecture
      final Uint8List uint8list = await file.readAsBytes();
      return uint8list;
    }
    ImageProvider<Object> image() {
      if (_imageFile != null) {
        return FileImage(_imageFile as File);
      }
      return AssetImage('assets/logofav.png');
    }
    String matricule ='';
    String plaque = '';
    String marque = '';
    String dimention = '';
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Widgets.bgColor,
      appBar: AppBar(
          backgroundColor: Widgets.componentColor,
          title: const Text(
            'CAMION',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          centerTitle: true,
          leading: Widgets.backbutton(context, EditProfil())),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Ajouter un camion',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox( height: 20,),
            //add profil
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image:
                      DecorationImage(fit: BoxFit.cover, image: image()),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _pickImage(ImageSource.gallery);
                                        },
                                        icon: Icon(
                                          Icons.photo,
                                          size: 50,
                                          color: Widgets.bgColor,
                                        )),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _pickImage(ImageSource.camera);
                                        },
                                        icon: Icon(
                                          Icons.photo_camera,
                                          size: 50,
                                          color: Widgets.bgColor,
                                        )),
                                  ],
                                ),
                                actions: [],
                              );
                            },
                          );
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.party_mode,
                            )),
                      ))
                ],
              ),
            ),
            SizedBox( height: 20,),
            Center(
              child: Text('Cliqué sur la photo pour selectionner la photo du camion',
              style: TextStyle(
                color: Widgets.btnColor,
              ),),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Widgets.componentColor,
                  borderRadius: BorderRadius.circular(35)),
    //form widget
              child: Form(
                key: _formKey,
                  child: Column(children: [
                    const Text('Informations du camion', style: TextStyle(color: Colors.white, fontSize: 25),),
                    Container(
                      height: 60,
                      margin: EdgeInsets.all(10) ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(BorderSide(
                            width: 3,
                            color: Widgets.btnColor,
                          ))),
                      child: TextFormField(
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'la marque est obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            marque  = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Marque du camion',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.train_outlined),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none)),
                    ),

                    Container(
                      height: 60,
                      margin: EdgeInsets.all(10) ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(BorderSide(
                            width: 3,
                            color: Widgets.btnColor,
                          ))),
                      child: TextFormField(
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'la matricule est obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            matricule  = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Matricule',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.map_outlined),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none)),
                    ),

                    Container(
                      height: 60,
                      margin: EdgeInsets.all(10) ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(BorderSide(
                            width: 3,
                            color: Widgets.btnColor,
                          ))),
                      child: TextFormField(
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'la plaque est obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            plaque  = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Plaque',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.padding),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none)),
                    ),

                    Container(
                      height: 60,
                      margin: EdgeInsets.all(10) ,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.fromBorderSide(BorderSide(
                            width: 3,
                            color: Widgets.btnColor,
                          ))),
                      child: TextFormField(
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'la dimention est obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            dimention  = val;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Dimension  eg: 20m3',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.directions_bus_filled_outlined),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none)),
                    ),


                    SizedBox(height: 20,),
//Bouton
//button accepte
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Widgets.btnColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate())
                                {
                                //insert chart into database
                                  fileToUint8List(_imageFile as File).then((value) {
                                    setState(() {
                                      GlobalViewModel.saveImageToFile(value, marque).then((values){
                                        DatabaseManager.insertTruck(TruckModel(id: null, dimention: dimention, marque: marque, matricule: matricule, plaque: plaque, photo:values)).then((val) {
                                         setState(() {
                                           if(val == 1) {
                                             Widgets.toast('Camion ajouté');
                                            // Navigate to dashbord
                                             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                                               return EditProfil();
                                             }));
                                           }
                                           else{
                                             Widgets.toast("le camion n'a pas puis etre enregistrer");
                                           }
                                         });


                                        });
                                      });
                                    });
                                  });

                          //show toast


                                }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent)
                            ),
                            child: const Text('Valider', style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),),
                          ),
                        ),
                      ),


                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
