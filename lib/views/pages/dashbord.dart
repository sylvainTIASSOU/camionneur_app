
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sebco_camioniste/viewModel/dashbordViewModel.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import '../../viewModel/databaseManager/databaseManager.dart';
import '../../viewModel/globalViewModel.dart';
import 'editProfil.dart';

class Dashbord extends StatefulWidget
{
  const Dashbord({super.key});

  @override
  State<StatefulWidget> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord>
{
  String userName ='';
  var photo = null;

  @override
  void initState() {
    super.initState();
    GlobalViewModel.readCounter().then((value){
      setState(() {
        userName = value;
      });
    });
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
  }

  @override
  Widget build(BuildContext context) {

    ImageProvider<Object> image() {
      if (photo != null) {
        return MemoryImage(photo);
      }
      return AssetImage('assets/logofav.png');
    }

    return Scaffold(
      backgroundColor: Widgets.bgColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            color: Widgets.bgColor,
          ),
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Center(
                  child: Widgets.profil(context,EditProfil(), image())
              ),
              const SizedBox(height: 10,),
              // user name
              Center(child: Text(userName,
                style: TextStyle(
                  color: Widgets.btnColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),),
              const SizedBox(height: 35,),
              const Text('Tableau de bord',style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
                textAlign: TextAlign.start,
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      //methode to execute
                      DashbordViewModel.moveToOrderDone(context);
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Widgets.color1,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.cartShopping, size: 100, color: Colors.white,),
                            SizedBox(height: 10,),
                            Text('Livraisons effectuées', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                          ],),
                      ),
                    ),
                  ),
                  const SizedBox(width: 35,),

                  GestureDetector(
                    onTap: (){
                      //methode to execute
                      DashbordViewModel.moveToOrderGoing(context);
                    },
                    child: Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Widgets.color2,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.biking, size: 100, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text('Livraison en cours', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                        ],),
                    ),
                  ),


                ],
              ),


              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      //methode to execute
                      DashbordViewModel.moveToOrderHistory(context);
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Widgets.color3,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, size: 100, color: Colors.white,),
                            SizedBox(height: 10,),
                            Text('Historique des Livraisons', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                          ],),
                      ),
                    ),
                  ),
                  const SizedBox(width: 35,),

                  GestureDetector(
                    onTap: (){
                      //methode to execute
                      DashbordViewModel.moveToOrderWaiting(context);
                    },
                    child: Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Widgets.color4,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.accessible, size: 100, color: Colors.white,),
                          SizedBox(height: 10,),
                          Text('Livraisons en attentes', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                        ],),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5,),

            ],
          ),
        ),
      ),
    );
  }
}