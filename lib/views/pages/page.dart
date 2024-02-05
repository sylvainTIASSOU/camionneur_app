import'package:flutter/material.dart';
import'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sebco_camioniste/viewModel/apiServices/apiservices.dart';
import 'package:sebco_camioniste/views/pages/dashbord.dart';
import 'package:sebco_camioniste/views/pages/notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../services/local_notification.dart';
import '../components/widgets.dart';
class Pages extends StatefulWidget {
  @override
  PageState createState() => PageState();
}
class PageState extends State<Pages> {

  late IO.Socket socket;
  int _selectedIndex = 0;
  late PageController _pageController;
  late final LocalNotification service;

  @override
  void initState() {
    super.initState();
    service = LocalNotification();
    service.initialize();
    connect();
    _pageController = PageController();
  }
void connect() {
    socket = IO.io("https://663f-102-64-220-236.ngrok-free.app",
    <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });
    socket.connect();
    socket.onConnect((data) => print("connected"));
    print(socket.connected);
    socket.on("delivery", (data) {
          service.showNotification(id: 0, title:"SeBcO", body:"Vous avez une nouvelle commande");

    });
}
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Widgets.componentColor,
        bottomNavigationBar:
        BottomNavigationBar(
          unselectedItemColor: Colors.white,
          backgroundColor: Widgets.componentColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: 'home'),

            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.handHoldingDollar, size: 30,),
                label: 'home'),
            BottomNavigationBarItem(
                icon:  Icon(
                  Icons.notifications,
                  size: 30,
                ),
                label: 'notification'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Widgets.btnColor,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
                Dashbord(),

                Container(
                  child: Center(child: Text('liste des payements reçu!!', style: TextStyle(color: Colors.white),),),
                ),
              Notifications(),
            ],
          ),
        )
    );
  }

  }