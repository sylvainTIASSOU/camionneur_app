
import 'dart:typed_data';

class DriverModel
{
  var id;
  String firstName;
  String lastName;
  String? number;
  String location;
  String? photo;

  DriverModel({this.id, required this.firstName, required this.lastName, this.number, required this.location, this.photo});
  //convert to Map
  Map<String, dynamic> toMap()
  {
    return{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'number': number,
      'location': location,
      'photo': photo
    };
  }

//convert to string
  String toString()
  {
    return 'id: $id , firstName: $firstName, lastname: $lastName, number: $number, location: $location, photo: $photo';
  }

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as int,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        location: json['location'] as String,
    photo: json['photo'] as String);
  }
}