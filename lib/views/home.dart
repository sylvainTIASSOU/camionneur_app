import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sebco_camioniste/services/local_notification.dart';
import 'package:sebco_camioniste/views/pages/splash.dart';

import 'components/widgets.dart';

class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeBCo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Widgets.bgColor),
        //useMaterial3: true,
      ),
      home: Splash(),
      //MapsView(),

      // initialRoute: '/splashPage',
      // routes:{
      //   '/splashPage': (context) => SplashPage(),
      //  '/dashbord': (context) => Dashbord(),
      //   '/page': (context) => Pages(),
      //   'notification': (context) => Notifications(),
      //   '/orderdetail': (context) => OrderDetail(),
      //   '/inscription1': (context) => Inscription1(),
      //   '/inscription2': (context) => Inscription2(),
      // },
    );
  }
}