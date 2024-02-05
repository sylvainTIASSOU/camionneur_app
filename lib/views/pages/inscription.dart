
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sebco_camioniste/model/modelDriver.dart';
import 'package:sebco_camioniste/model/modelUser.dart';
import 'package:sebco_camioniste/viewModel/apiServices/apiservices.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import 'package:sebco_camioniste/views/pages/page.dart';
import '../../model/driverModel.dart';
import '../../viewModel/databaseManager/databaseManager.dart';
import '../../viewModel/globalViewModel.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});


  @override
  State<StatefulWidget> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
late bool isConnect = false;
  @override
  void initState() async {
    super.initState();
    setState(() async {
      isConnect = await ApiService.checkInertnetConnectivity();
    });

  }
  @override
  Widget build(BuildContext context) {
    String lastName = '';
    String firstName = '';
    String number = '';
    String location = "";
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Widgets.bgColor,
      body: !isConnect ? Center(
        child: Column(children: [
          SvgPicture.asset('assets/Warning-rafiki.svg'),
          const SizedBox(height: 10,),
          const Text('Connectez-vous pour continuer merci!!!', style: TextStyle(fontSize: 20, color: Colors.white),),
        ],)
      ) :
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Inscription',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/undraw_modern_design_re_dlp8.svg',
                width: 210,
                height: 210,
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
                          decoration: InputDecoration(
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
                          ModelDriver modelDriver = ModelDriver(firstName: firstName, lastName: lastName, location: location);

                          ModelUser modelUser;
                          ApiService.addDriver(modelDriver).then((value) => {
                            modelUser = ModelUser(phone: number as int , password: 'sebco', role: "driver", driver_id: value.id!),
                            ApiService.addUser(modelUser).then((values) => {
                              GlobalViewModel.writeId(data: value.id),
                            }),
                          });
                          DriverModel driverModel = DriverModel(firstName: firstName, lastName: lastName,number: number,location: location);
                         var res =  DatabaseManager.insertDriver(driverModel);
                         print(res);
                          //get User id

                         // write user name in file
                           GlobalViewModel.writeCounter(data: '$lastName $firstName ');
                          //show toast
                           Widgets.toast('inscription effectué');
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
