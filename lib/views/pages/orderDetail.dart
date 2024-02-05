import 'package:flutter/material.dart';
import 'package:sebco_camioniste/model/orderModel.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/pages/mapView.dart';
import 'package:sebco_camioniste/views/pages/orderHistory.dart';
import 'package:sebco_camioniste/views/pages/orderWaiting.dart';
import 'package:sebco_camioniste/views/pages/page.dart';

import '../../viewModel/apiServices/apiservices.dart';
import '../components/widgets.dart';
import 'orderGoing.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({required this.idOrder});
  int idOrder;
  @override
  State<StatefulWidget> createState() => _detailState(idOrder: this.idOrder);
}

class _detailState extends State<OrderDetail> {
  int idOrder;
  _detailState({required this.idOrder});
  @override
  Widget build(BuildContext context) {
    // ApiService.fetchData('order/single/1').then((val) => {
    //   print(val)
    // });

    // ApiService.fetchData('order-item/getByOrder/1').then((val) => {
    //   print(val)
    // });
    return Scaffold(
        backgroundColor: Widgets.bgColor,
        appBar: AppBar(
            backgroundColor: Widgets.componentColor,
            title: Text('Detail du commande'),
            centerTitle: true,
            leading: Widgets.backbutton(context, Pages())),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: Widgets.getScreenHeight(context) / 2,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Widgets.componentColor,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/2.png'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'sable lavé',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Quantité',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("Montant",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  ': 10m3',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("Montant",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )
                          ],
                        )
                      ],
                    ));
              },
            ),
          ),

          //order sum
          Container(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<OrderModel>(
                future: ApiService.fetchOrder('order-item/getByOrder/1'),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data?.indiqueName}',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Numéro de l\'indique',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Date de la livraison',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Heure de la livraison',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),

                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Non de l\'indique',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Numéro de l\'indique',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Date de la livraison',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Heure de la livraison',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
            )

          ),
          //button

          Widgets.costumButton(
              context, 'Accepter la livraison', null, MapsView()),
          Widgets.costumButton(
              context, 'Mettre en attente', null, OrderWaiting()),
          Widgets.costumButton(
              context, 'Rejeter la livraison', null, OrderHistory()),
        ])));


  }

}
