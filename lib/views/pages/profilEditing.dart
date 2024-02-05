
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import 'package:sebco_camioniste/views/pages/editProfil.dart';
import 'package:sebco_camioniste/views/pages/page.dart';
import '../../model/driverModel.dart';
import '../../viewModel/databaseManager/databaseManager.dart';
import '../../viewModel/globalViewModel.dart';

class ProfilEditing extends StatefulWidget {
  const ProfilEditing({super.key});


  @override
  State<StatefulWidget> createState() => _ProfilEditingState();
}

class _ProfilEditingState extends State<ProfilEditing> {
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
  String lastName = '';
  String firstName = '';
  String number = '';
  String location = "";
  var  photo = null ;
  @override
  void initState() {
    super.initState();

    DatabaseManager.getAllDriver().then((value) {
      setState(() {
       lastName = value[0].lastName;
       firstName = value[0].firstName;
       location = value[0].location;
       number = value[0].number!;
       if(value[0].photo != null){
         GlobalViewModel.loadImage(value[0].photo!).then((values) {
           photo =  values;
         });
       }
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    //convert file to uint8List
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
      if(photo != null) {
        return MemoryImage(photo);
      }
      return AssetImage('assets/logofav.png');
    }


    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Widgets.bgColor,
      appBar: AppBar(
          backgroundColor: Widgets.componentColor,
          title: const Text(
            'PROFIL',
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Widgets.componentColor,
                  borderRadius: BorderRadius.circular(35)),
    //form widget
              child: Form(
                key: formKey,
                  child: Column(children: [
                    const Text('Informations Personnelles', style: TextStyle(color: Colors.white, fontSize: 25),),
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
                        initialValue: lastName,
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'champs obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            lastName  = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Nom',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.person),
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
                          initialValue: firstName,
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'champs obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            firstName = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Prénom',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.person),
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
                        initialValue: number,
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'champs obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            number = val;
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Numéro de téléphone',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.phone),
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
                        initialValue: location,
                          validator: (val) {
                            if(val!.isEmpty)
                            {
                              return'champs obligatoir';
                            }
                            else
                              return null;
                          },

                          onChanged: (val)
                          {
                            location  = val;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              labelText: 'Localité',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.location_on_outlined),
                              prefixIconColor: Colors.white,
                              border: InputBorder.none)),
                    ),

                    const SizedBox(height: 20,),
//Bouton
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
                        if(formKey.currentState!.validate())
                        {


                        fileToUint8List(_imageFile! as File).then((value) {
                          setState(() {
                            GlobalViewModel.saveImageToFile(value, 'monimage').then((values) {


                              DriverModel driverModel = DriverModel(
                                  id: 2,
                                  firstName: firstName,
                                  lastName: lastName,
                                  number: number,
                                  location: location,
                                  photo: values);

                              DatabaseManager.updateDriver(1, driverModel);

                            });

                          });
                        });

                          //get User id

                         // write user name in file
                           GlobalViewModel.writeCounter(data: '$lastName $firstName ');
                          //show toast
                           Widgets.toast('mise a jour effectué');
                         // Navigate to dashbord
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
                            return Pages();
                          }));
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent)
                      ),
                      child: const Text('VALIDER', style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),),
                    ),
                  )
                  )

                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
