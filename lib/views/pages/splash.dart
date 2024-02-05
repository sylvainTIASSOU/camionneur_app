import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sebco_camioniste/viewModel/globalViewModel.dart';
import 'package:sebco_camioniste/views/pages/page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/widgets.dart';
import 'inscription.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _contanerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });
    _controller.forward();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _contanerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      GlobalViewModel.readCounter().then((value) {
        setState(() {
          if(value == 'null')
          {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder:
                    (context, animation, secondaryAnimation) => Inscription(),
                transitionsBuilder: (context, animation, secondaryAnimation, child)
                {
                  animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                  return FadeTransition(opacity: animation, child: child,);
                }
            )
            );
          }
          if(value != 'null')
          {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: Duration(seconds: 4),
                pageBuilder:
                    (context, animation, secondaryAnimation) => Pages(),
                transitionsBuilder: (context, animation, secondaryAnimation, child)
                {
                  animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                  return FadeTransition(opacity: animation, child: child,);
                }
            ));
          }
        });
      });

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
   return Scaffold(
     backgroundColor: Widgets.bgColor,
     body: Stack(
       children: [
         Column(
           children: [
             AnimatedContainer(
                 duration:  const Duration(milliseconds: 2000),
                 curve: Curves.fastLinearToSlowEaseIn,
                 height: _height / _fontSize
             ),
             AnimatedOpacity(
               duration: const Duration(milliseconds: 1000),
               opacity: _textOpacity,
               child: DefaultTextStyle(
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 50,
                   fontWeight: FontWeight.bold,
                 ),
                 child: AnimatedTextKit(
                   isRepeatingAnimation: false,
                   repeatForever: false,
                   displayFullTextOnTap: false,
                   animatedTexts: [
                     TyperAnimatedText('SeBcO',
                         textAlign: TextAlign.center,
                         speed: Duration(milliseconds: 150)),
                   ],
                 ),
               ),
             ),
           ],
         ),
         Center(
           child: AnimatedOpacity(
             duration: const Duration(milliseconds: 2000),
             curve: Curves.fastLinearToSlowEaseIn,
             opacity: _containerOpacity,
             child: AnimatedContainer(
               duration: const Duration(milliseconds: 2000),
               curve: Curves.fastLinearToSlowEaseIn,
               alignment: Alignment.center,
               decoration: const BoxDecoration(
               ),
               child: Image.asset('assets/logofav.png', width: 550, height: 550)

             ),
           ),
         ),
       ],
     ),
   );
  }
}
class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: 0,
          child: page,
        ),
      );
    },
  );
}
