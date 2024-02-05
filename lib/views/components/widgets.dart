import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../viewModel/globalViewModel.dart';

class Widgets {
  static Widget Dialog (BuildContext context,String title, String textContent, String button1, String button2, action)
  {
    return SimpleDialog(
      title: Text('$title', textAlign: TextAlign.center,),
      contentPadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),

          child: Column(
            children: [
              SizedBox(height: 15.0,),
              Text('$textContent', textAlign: TextAlign.center,),

              SizedBox(height: 15.0,),

              Align(
                  alignment: Alignment.center,
                  child: Wrap(
                      children: [
                        SizedBox(
                          width: 120.0,
                          child: ElevatedButton(
                            onPressed:  (){
                              Navigator.of(context).pop();
                            },
                            child: Text(button1, style: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                  200, 196, 191, 191)),

                            ),
                          ),
                        ),
                        SizedBox(width: 10,),

                        SizedBox(
                          width: 120.0,
                          child: ElevatedButton(
                            onPressed:  (){
                              action;
                            },
                            child: Text(button2),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black),

                            ),
                          ),
                        ),


                      ]
                  )
              ),
            ],
          ),
        ),

      ],
    );
  }
  static Color bgColor = Color(0xFF121747);
  static Color btnColor = Color(0xFFDB7C0C);
  static Color componentColor = Color.fromRGBO(48, 60, 173, 0.20);
  static Color color1 = Color.fromRGBO(219, 124, 12, 0.48);
  static Color color2 = Color.fromRGBO(153, 219, 12, 0.48);
  static Color color3 = Color.fromRGBO(219, 12, 37, 0.48);
  static Color color4 = Color.fromRGBO(12, 219, 206, 0.48);

  //toast
  static toast(String message)
  {
    return  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Widgets.btnColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  //get screen size
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Widget profil( BuildContext context, page, image) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return page;
        }));
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: image),
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(
              width: 3,
              color: Widgets.btnColor,
            ))),

      ),
    );
  }

  //back menu button
  static backbutton(BuildContext context, page)
  {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return page;
        }));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Widgets.btnColor, width: 3, style: BorderStyle.solid))
        ),
        child: Center(
            child: Icon(Icons.arrow_back_sharp,)
        ),
      ),
    );
  }

  //button
static costumButton(BuildContext context,String title,  action, page)
{
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    height: 50,
    width: Widgets.getScreenWidth(context),
    decoration: BoxDecoration(
      color: Widgets.btnColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: ElevatedButton(
      onPressed: () {
        action;
        GlobalViewModel.transitonPageSlide(context, page);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent)
      ),
      child: Text(title, style: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),),
    ),
  );
}


//formfield

static formField(String label,Icon? icon, TextInputType type, data )
{
  return
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
                  data  = val;
                },
              keyboardType: type,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                    labelText: label,
                     labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: icon,
                    prefixIconColor: Colors.white,
                    border: InputBorder.none)),
          );
}
}
