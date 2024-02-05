
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/pages/orderGoing.dart';

import '../views/pages/orderDone.dart';
import '../views/pages/orderHistory.dart';
import '../views/pages/orderWaiting.dart';

class DashbordViewModel
 {
   static moveToOrderHistory(BuildContext context)
   {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
       return OrderHistory();
     }));
   }

   static moveToOrderGoing(BuildContext context)
   {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
       return OrderGoing();
     }));
   }

   static moveToOrderWaiting(BuildContext context)
   {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
       return OrderWaiting();
     }));
   }

   static moveToOrderDone(BuildContext context)
   {
     GlobalViewModel.transitonPageSlide(context, OrderDone());
   }
 }