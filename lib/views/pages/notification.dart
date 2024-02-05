import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sebco_camioniste/viewModel/apiServices/apiservices.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/viewModel/notificationViewModel.dart';
import 'package:sebco_camioniste/views/components/widgets.dart';
import 'package:sebco_camioniste/views/pages/editProfil.dart';
import 'package:sebco_camioniste/views/pages/addTruck.dart';
import 'package:sebco_camioniste/views/pages/page.dart';
import '../../model/notificationModel.dart';
import 'orderDetail.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _notificationState();
}

class _notificationState extends State<Notifications> {
  late int id;
  late bool isConnect = true;
  late Future<List<NotificationModel>> futureNotification;
  @override
  initState() {
    super.initState();
    setState(() {
      futureNotification = ApiService.fetchNotification();
      GlobalViewModel.readId().then((value) => {
        //id = value as int,
        print(value)
      });
      ApiService.checkInertnetConnectivity().then((value) => {
        isConnect = value
      });
    });
  }
  @override
  Widget build(BuildContext context) {//delivery/findByDriver/1?status=pass



    return Scaffold(
      backgroundColor: Widgets.bgColor,
      appBar: AppBar(
        backgroundColor: Widgets.componentColor,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: !isConnect ? Center(
        child: Column(children: [
          SvgPicture.asset('assets/Warning-rafiki.svg'),
          const SizedBox(height: 10,),
          const Text('Erreur de connexion!!!', style: TextStyle(fontSize: 20, color: Colors.white),),
        ],),
      ) :
      Container(
        height: Widgets.getScreenHeight(context),
        child: FutureBuilder<List<NotificationModel>>(
            future: ApiService.fetchNotification(),
            builder: (context, snapshut) {
              if (snapshut.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshut.hasError) {
                print(snapshut.error);
                return  Center(child: Column(children: [
                  SvgPicture.asset('assets/Warning-rafiki.svg'),
                  const SizedBox(height: 10,),
                  const Text('Une erreur est survenu!!!', style: TextStyle(fontSize: 20, color: Colors.white),),
                ],),);
              }
              else if(!snapshut.hasData) {
                return  Center(child: Column(children: [
                  SvgPicture.asset('assets/Questions-cuate.svg'),
                  const SizedBox(height: 10,),
                  const Text('pas de notification!!!', style: TextStyle(fontSize: 20, color: Colors.white),),
                ],)
                );
              }
              final  data = snapshut.data!;
              print(snapshut.data);
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    GestureDetector(
                    onTap: () {
                      GlobalViewModel.transitonPageSlide(
                          context, OrderDetail(idOrder: data[index].id!));
                    },

                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(8),
                      //height: Widgets.getScreenHeight(context),
                      decoration: BoxDecoration(
                        color: Widgets.componentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications_active,
                            weight: 60,
                            size: 60,
                            color: Colors.white,
                          ),

                          SizedBox(width: 15,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  ' Nouvelle commande',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                ' Date de la commande',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ' Date de livraison',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ' Nombre de commande ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                ' ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' : ${data[index].orderDate} ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ' : ${data[index].deliveryDate} ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                ' : ${data[index].deliveryHours} ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),

      ),
    );
  }
}
