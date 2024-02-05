
import 'dart:convert';
import 'package:sebco_camioniste/model/notificationModel.dart';

import '../../model/driverModel.dart';
import 'package:http/http.dart' as http;

import '../../model/modelDriver.dart';
import '../../model/modelUser.dart';
import '../../model/orderModel.dart';

class ApiService
{
  static String url =  "https://636c-102-64-215-36.ngrok-free.app/";

  //chet connection
  static Future<bool> checkInertnetConnectivity() async {
    try{
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch(e) {
      return false;
    }
  }
  // fetch data ,function
  static fetchData(endPoint ) {
    Future<dynamic> fetchData() async {
      final uri = Uri.parse('$url$endPoint');
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('failed to load data');
      }
    }
    return fetchData();
  }
//fetch order
  static fetchOrder(endPoint ) {
    Future<OrderModel> fetchData() async {
      final uri = Uri.parse('$url$endPoint');
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('failed to load data');
      }
    }
    return fetchData();
  }

  ///fetch notification
  static Future<List<NotificationModel>> fetchNotification() async {
    final uri = Uri.parse('${url}delivery/findByDriver/1?status=create');
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final List<dynamic> maps = json.decode(response.body);
      return maps.map((notification) => NotificationModel.fromJson(notification)).toList();

    } else {
      throw Exception('failed to load data');
    }
  }



  // post function
  static postData(data, endPoint) {
    Future<dynamic> postData() async {
      final uri = Uri.parse('$url$endPoint');
      final response = await http.post(uri, body: data);

      if(response.statusCode == 201) {
        return json.decode(response.body);
      }else {
        throw Exception('failed to load data');
      }
    }
   return postData();
  }
  // update function
  static updateData(data, endPoint) {
    Future<dynamic> postData() async {
      final uri = Uri.parse('$url$endPoint');
      final response = await http.put(uri, body: data);

      if(response.statusCode == 201) {
        return json.decode(response.body);
      }else {
        throw Exception('failed to load data');
      }
    }
    return postData();
  }

  // delete function
  static deleteData(endPoint) {
    Future<dynamic>? deleteData() async {
      final uri = Uri.parse("$endPoint");
      final response = await http.delete(uri);

      if(response.statusCode == 200) {
        return null;
      }
      else {
        throw Exception("failed to load post");
      }
    }
    return deleteData();
  }

  //getDriver function
  static Future<DriverModel> getData() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final Map<String, dynamic> driverData = json.decode(response.body) ;
      return DriverModel.fromJson(driverData);
    }
    else {
      throw Exception('erreur de recuperation');
    }
  }

  //post driver function
static Future<ModelDriver> addDriver(ModelDriver driverModel) async {
  final uri = Uri.parse(url);
  final response = await http.post(uri,
  headers: <String, String>{
    'Content-Type' : 'application/json'
  },
  body: jsonEncode(driverModel.toMap()),
  );
  if(response.statusCode == 201) {
    final Map<String, dynamic> maps= json.decode(response.body);
    return ModelDriver.fromJson(maps);
  }
  else
    {
      throw Exception('impossible ');
    }

}


//add user
  //post driver function
  static Future<ModelUser> addUser(ModelUser modelUser) async {
    final uri = Uri.parse(url);
    final response = await http.post(uri,
      headers: <String, String>{
        'Content-Type' : 'application/json'
      },
      body: jsonEncode(modelUser.toMap()),
    );
    if(response.statusCode == 201) {
      final Map<String, dynamic> maps= json.decode(response.body);
      return ModelUser.fromJson(maps);
    }
    else
    {
      throw Exception('impossible ');
    }

  }
  //get commande


}