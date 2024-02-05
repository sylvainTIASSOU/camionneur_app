class ModelDriver {
  int? id;
  String firstName;
  String lastName;
  String location;
  String? photo;
  String? status;
  ModelDriver({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.location,
    this.photo,
    this.status,
});

  Map<String, dynamic> toMap()
  {
    return{
      'firstName': firstName,
      'lastName': lastName,
      'location': location,
      'photo': photo
    };
  }

  factory ModelDriver.fromJson(Map<String, dynamic> json) {
    return ModelDriver(
        id: json['id'] as int,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        location: json['location'] as String,
        photo: json['photo'] as String,
        status: json['status'] as String);
  }
}