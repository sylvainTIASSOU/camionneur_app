import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/pages/page.dart';

import '../components/widgets.dart';
import 'orderDetail.dart';

class OrderDone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _orderDoneState();
}

class _orderDoneState extends State<OrderDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Widgets.bgColor,
      appBar: AppBar(
        leading: Widgets.backbutton(context, Pages()),
        backgroundColor: Widgets.componentColor,
        title: Text(
          'Les commandes effectuées',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  GlobalViewModel.transitonPageSlide(
                      context,
                      OrderDetail(
                        idOrder: index,
                      ));
                },
                child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    //height: Widgets.getScreenHeight(context),
                    decoration: BoxDecoration(
                      color: Widgets.componentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/notif.svg',
                          height: 47,
                          width: 47,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Nom du client',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Nom du client',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'effectué',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )));
          }),
    );
  }
}
