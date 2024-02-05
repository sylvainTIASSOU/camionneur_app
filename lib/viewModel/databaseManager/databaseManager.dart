
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sebco_camioniste/model/orderModel.dart';
import 'package:sebco_camioniste/model/truckModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/driverModel.dart';

class DatabaseManager
{
  DatabaseManager._();
  static final DatabaseManager instance = DatabaseManager._();
  static  var database ;

  static Future<Database> get databases async
  {
    if(database!= null)
    {
      return database;
    }

    database = await initDB();
    return database;

  }


  static initDB() async
  {
    final path = join(await getDatabasesPath(), 'Usermanagerdb.db');
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      path,
      version: 1,
      //cree les tables
      onCreate: (db, version)
      {
        db.execute('CREATE TABLE driver(id INTEGER PRIMARY KEY AUTOINCREMENT,firstName TEXT, lastName TEXT, number TEXT, location TEXT, photo TEXT )');
        db.execute('CREATE TABLE truck(id INTEGER PRIMARY KEY AUTOINCREMENT, marque TEXT, matricule TEXT,plaque TEXT, dimention TEXT, photo TEXT)');
        db.execute('CREATE TABLE order(id INTEGER PRIMARY KEY AUTOINCREMENT,  driverId INTEGER, status TEXT, orderDate Date, dateOfDelivery Date, deliveryTime TEXT,  custumName TEXT, indiqueName TEXT, indiqueNumber TEXT, picture TEXT, link TEXT, quantity TEXT)');
      },

    );
  }

  ///-------------------------------------------------------------> driver
  //function to insert in db

  static Future<void> insertDriver(DriverModel driverModel) async
  {
    final Database db  = await databases;

    await db.insert(
        "driver",
        driverModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<Uint8List?> getImage(int id) async {
    final Database db =  await databases;
    final List<Map<String, dynamic>> maps = await db.query('driver',
    columns: ['photo'],
      where: 'id = ?',
      whereArgs: [id]
    );
    if(maps.isNotEmpty) {
      return maps[0]['photo'];
    }
    return null;
  }

//fonction to get all data of table
  static Future<List<DriverModel>> getAllDriver() async
  {
    final Database db  = await databases;
    //requete de selection
    final List<Map<String, dynamic>> maps = await db.query("driver"
        ,
        orderBy: "id DESC");
    return List.generate(maps.length, (i) {
      return DriverModel(
          id: maps[i]['id'],
          firstName: maps[i]['firstName'],
          lastName: maps[i]['lastName'],
          number: maps[i]['number'],
          location: maps[i]['location'],
          photo: maps[i]['photo']
      );
    });
  }

//function of update
  static Future<void> updateDriver(id, DriverModel driverModel) async
  {
    final Database db  = await databases;
    await db.update("driver",
        driverModel.toMap(),
        where: 'id = ?',
        whereArgs: [id]
    );
  }

//function to delete
  static Future<void>deleteDriver(String lastName) async
  {
    final Database db  = await databases;
    await db.delete("driver",
        where: 'lastName=?',
        whereArgs: [lastName]
    );
  }

//fonction to getUserId

  static Future<int>  getDriverId(Map<dynamic, dynamic> data) async
  {
    List<Map<String, dynamic>> results = await database.rawQuery(
      'SELECT id FROM driver WHERE number = ?',
      [data['number']],
    );

    if (results.isNotEmpty) {
      return results.first['id'];
    } else {
      return -1 ;
    }
  }



  ///-------------------------------------------------------------> truck
  //function to insert in db

  static Future<int> insertTruck(TruckModel chartModel) async
  {
    final Database db  = await databases;
var resp = null;
   resp = await db.insert(
        "truck",
        chartModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
   if(resp != null) {
     return 1;
   }
    return -1;
  }

//fonction to get all data of table
  static Future<List<TruckModel>> getAllTruck() async
  {
    final Database db  = await databases;
    //requete de selection
    final List<Map<String, dynamic>> maps = await db.query("truck"
        ,
        orderBy: "id DESC");
    return List.generate(maps.length, (i) {
      return TruckModel(
          id: maps[i]['id'],
          dimention: maps[i]['dimention'],
          marque: maps[i]['marque'],
          matricule: maps[i]['matricule'],
          plaque: maps[i]['plaque'],
          photo: maps[i]['photo']
      );
    });
  }

//function of update
  static Future<int> updateTruck(id, TruckModel chartModel) async
  {
    final Database db  = await databases;
    var res = null;
    res = await db.update("truck",
        chartModel.toMap(),
        where: 'id = ?',
        whereArgs: [id]
    );
    if(res != null) {
      return 1;
    }
    return -1;
  }

  static Future<List<TruckModel>?> getTruckById(int id) async{
    final Database db = await databases;
    final List<Map<String, dynamic>> maps = await db.query(
      'truck',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if(maps.isNotEmpty) {
       return List.generate(maps.length, (i)
       {
         return TruckModel(
             id: maps[i]['id'],
             dimention: maps[i]['dimention'],
             marque: maps[i]['marque'],
             matricule: maps[i]['matricule'],
             plaque: maps[i]['plaque'],
             photo: maps[i]['photo']
         );
       });
    }
    return null;
  }



// //function to delete
//   static Future<void>deleteBD(String lastName) async
//   {
//     final Database db  = await databases;
//     await db.delete("driver",
//         where: 'lastName=?',
//         whereArgs: [lastName]
//     );
//   }
//
// //fonction to getUserId
//
//   static Future<int>  getUserId(Map<dynamic, dynamic> data) async
//   {
//     List<Map<String, dynamic>> results = await database.rawQuery(
//       'SELECT id FROM driver WHERE number = ?',
//       [data['number']],
//     );
//
//     if (results.isNotEmpty) {
//       return results.first['id'];
//     } else {
//       return -1 ;
//     }
//   }


  ///-------------------------------------------------------------> order
//   //function to insert in db
//
//   static Future<void> insertOrder(OrderModel orderModel) async
//   {
//     final Database db  = await databases;
//
//     await db.insert(
//         "order",
//         orderModel.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace
//     );
//   }
//
// //fonction to get all data of table
//   static Future<List<OrderModel>> getAllOrder() async
//   {
//     final Database db  = await databases;
//     //requete de selection
//     final List<Map<String, dynamic>> maps = await db.query("driver"
//         ,
//         orderBy: "driverId DESC");
//     return List.generate(maps.length, (i) {
//       return OrderModel(status: '', orderId: null, driverId: null, orderDate: '', dateOfDelivery: '', quantity: '', customerName: '', deliveryTime: '', indiqueName: '', indiqueNumber: '', link: '', picture: ''
//       );
//     });
//   }
//
// //function of update
//   static Future<void> updateOrder(id, OrderModel orderModel) async
//   {
//     final Database db  = await databases;
//     await db.update("order",
//         orderModel.toMap(),
//         where: 'orderId = ?',
//         whereArgs: [id]
//     );
//   }

// //function to delete
//   static Future<void>deleteDriver(String lastName) async
//   {
//     final Database db  = await databases;
//     await db.delete("driver",
//         where: 'lastName=?',
//         whereArgs: [lastName]
//     );
//   }

//fonction to getUserId

  static Future<int>  getOrderId(Map<dynamic, dynamic> data) async
  {
    List<Map<String, dynamic>> results = await database.rawQuery(
      'SELECT id FROM order WHERE customName = ?',
      [data['customName']],
    );

    if (results.isNotEmpty) {
      return results.first['id'];
    } else {
      return -1 ;
    }
  }

}