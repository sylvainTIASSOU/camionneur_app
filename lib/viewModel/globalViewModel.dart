import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
class GlobalViewModel
{
  
  //page transition
 static transitonPage(BuildContext context,   page)
  {
    Navigator.pushReplacement(context, 
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
        pageBuilder:
    (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child)
        {
          animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          return FadeTransition(opacity: animation, child: child,);
        }
    )
    );
  }

 static transitonPageSlide(BuildContext context,   page)
 {
   Navigator.pushReplacement(context,
       PageRouteBuilder(
           transitionDuration: Duration(milliseconds: 1000),
           reverseTransitionDuration: Duration(milliseconds: 400),
           pageBuilder:
               (context, animation, secondaryAnimation) => page,
           transitionsBuilder: (context, animation, secondaryAnimation, child)
           {
             animation = CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn, reverseCurve: Curves.fastOutSlowIn);
             return SlideTransition(position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation),
             textDirection: TextDirection.rtl,
               child: child,);
           }
       )
   );
 }


  static bool isuser = false;

  //Get the path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // create the file on the path get
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  // fontion to read data
  static Future<String> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0
      return 'null';
    }
  }
  // function to write on data
  static Future<File> writeCounter({data = ''}) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$data');
  }




// ----------------------------------- save id

  // fontion to read data
  static Future<String> readId() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      return contents.toString();
    } catch (e) {
      // If encountering an error, return 0
      return 'null';
    }
  }
  // function to write on data
  static Future<File> writeId({data = ''}) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$data');
  }




  //----------------------------------------------------image stoke
 static Future<File> get _imageFile async {
   final path = await _localPath;
   return File('$path/imageData.txt');
 }
 static Future<String> readImage() async {
   try {
     final file = await _imageFile;
     // Read the file
     final contents = await file.readAsString();
     return contents.toString();
   } catch (e) {
     // If encountering an error, return 0
     return 'null';
   }
 }
 // function to write on data
 static Future<File> writeImage({data = ''}) async {
   final file = await _imageFile;
   // Write the file
   return file.writeAsString('$data');
 }

 static Future<String?> saveImageToFile(Uint8List imageData, String fileName) async {
    try{
      final appDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDir.path}/$fileName';
      File file = File(filePath);
      await file.writeAsBytes(imageData);
      return filePath;
    }catch(e) {
      print('erreur lors de la sovegade');
      return null;
    }
 }

 //get image by path
 static Future<Uint8List?>loadImage(String imagePath) async {
    try {
      File file = File(imagePath);
      if(await file.exists()) {
        Uint8List imageData = await file.readAsBytes();
        return imageData;
      }else {
        return null;
      }
    }catch(e) {
      print('erreur de chargement de la photo');
      return null;
    }
}
}