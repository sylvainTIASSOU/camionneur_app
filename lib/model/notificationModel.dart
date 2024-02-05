

import 'dart:core';

class NotificationModel
{
  final String? orderDate;
  final String deliveryDate;
  final String? deliveryHours;
  final int? id;
  final int? deliveryId;

  NotificationModel({required this.orderDate, required this.deliveryDate, required this.deliveryHours, required this.id, required this.deliveryId});

  String toString()
  {
    return 'id: $id , orderDate: $orderDate, deliveryDate: $deliveryDate, deliveryHours: $deliveryHours';
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        orderDate: json['orderDate'] ,
        deliveryDate: json['deliveryDate'].toString(),
        deliveryHours: json['deliveryHours'] ,
      id: json['id'] ,
      deliveryId: json['deliveryId'] );
  }
}