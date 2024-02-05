import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sebco_camioniste/model/truckModel.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import 'package:sebco_camioniste/views/pages/addTruck.dart';
import 'package:sebco_camioniste/views/pages/page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sebco_camioniste/views/pages/profilEditing.dart';

import '../../viewModel/databaseManager/databaseManager.dart';
import 'editTruck.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  var photo = null;
  var images = null;
  @override
  void initState() {
    super.initState();
    setState(() {
      DatabaseManager.getAllDriver().then((value) {
        setState(() {
          if(value[0].photo != null){
            GlobalViewModel.loadImage(value[0].photo!).then((values) {
              setState(() {
                photo =  values;
              });
            });
          }

        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imageCam(photo, String name) {
      GlobalViewModel.loadImage(name).then((value) {
         images = value;
      });
      if (photo != null) {
        return MemoryImage(photo);
      }
      return AssetImage('assets/logofav.png');
    }

    ImageProvider<Object> image() {
      if (photo != null) {
        return MemoryImage(photo);
      }
      return AssetImage('assets/logofav.png');
    }

    return Scaffold(
        backgroundColor: Widgets.bgColor,
        appBar: AppBar(
            backgroundColor: Widgets.componentColor,
            title: const Text(
              'PROFIL',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            centerTitle: true,
            leading: Widgets.backbutton(context, Pages())),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              //add picture
              Widgets.profil(context,EditProfil(), image()),
              SizedBox(height: 20,),
              //Add truck button
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AddTruck();
                      }));
                    },
                    style: ButtonStyle(

                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ajouter un camion'),
                        Icon(
                          Icons.add,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //Edit profil
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ProfilEditing();
                      }));

                    },
                    style: ButtonStyle(

                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Modifer vos informations personnelles'),
                        Icon(
                          Icons.person,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              //Listes des camion Ajouter
              Center(
                child: Text('Liste de vos camions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),),),

              Container(
                height: 480,
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  //color: Widgets.componentColor,
                ),
                child: FutureBuilder<List<TruckModel>>(
                  future: DatabaseManager.getAllTruck(),
                  builder: (context, snapshut){
                    if(snapshut.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if(snapshut.hasError) {
                      return  Center(
                        child: SvgPicture.asset('assets/Warning-rafiki.svg')
                      );
                    }
                    else if(!snapshut.hasData || snapshut.data!.isEmpty) {
                      return Center(child: SvgPicture.asset('assets/Warning-rafiki.svg')
                        );
                    }

                    return  ListView.builder(
                      itemCount: snapshut.data!.length,
                        itemBuilder: (BuildContext context, int index) {




                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return EditTruck(id: index);
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 20, left: 5, right: 5),
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.4)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
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
                                          DecorationImage(fit: BoxFit.cover, image: imageCam(images, snapshut.data![index].photo!)),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
                                      Column(
                                        children: [
                                          Text(snapshut.data![index].marque, style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),),
                                          SizedBox(height: 5,),
                                          Text(snapshut.data![index].plaque, style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),),
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 20,)
                                ],
                              ),
                            ),
                          );
                        }
                    );
                }
                )

              )
            ],
          ),
        ));
  }
}
