

class OrderModel
{
  final int id;
  final String status;
  final String quantity;
  final String price;
  final String city;
  final String quarter;
  final String laltitude;
  final String longitude;
  final String deliveryDate;
  final String indiqueName;
  final String indiqueNumber;
  final String deliveryHours;
  final String utility;
  final String codePromo;


  OrderModel({
    required this.id,
    required this.status,
    required this.quantity,
    required this.price,
    required this.city,
    required this.quarter,
    required this.laltitude,
    required this.longitude,
    required this.deliveryDate,
    required this.indiqueName,
    required this.indiqueNumber,
    required this.deliveryHours,
    required this.utility,
    required this.codePromo,
});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(id: json["id"], status: json["status"], quantity: json["quantity"], price: json["price"], city: json["city"], quarter: json["quarter"], laltitude: json["laltitude"], longitude: json["longitude"], deliveryDate: json["deliveryDate"], indiqueName: json["indiqueName"], indiqueNumber: json["indiqueNumber"], deliveryHours: json["deliveryHours"], utility:json[" utility"], codePromo: json["codePromo"]);
  }

//   Map<String, dynamic> toMap()
//   {
//     return{
//       'orderId': orderId,
//       'status': status,
//       'driverId': driverId,
//       'orderDate': orderDate,
//       'dateofdelivery':dateOfDelivery,
//       'customerName': customerName,
//       'quatity': quantity,
//       'deliverutime': deliveryTime,
//       'indiqueName': indiqueName,
//       'indiqueNumber': indiqueNumber,
//       'link': link,
//       'picture': picture,
//     };
//   }
//
// //convert to string
//   String toString()
//   {
//     return '  orderId: $orderId, status: $status,driverId: $driverId,orderDate: $orderDate,dateofdelivery:$dateOfDelivery,customerName: $customerName,quatity: $quantity, deliverutime: $deliveryTime,indiqueName: $indiqueName,indiqueNumber: $indiqueNumber,link: $link, picture: $picture,';
//   }
}