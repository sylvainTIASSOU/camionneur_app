class ModelUser {
  int? id;
  int phone;
  String password;
  String role;
  int driver_id;
  ModelUser({
    this.id,
    required this.phone,
    required this.password,
    required this.role,
    required this.driver_id,
});

  Map<String, dynamic> toMap()
  {
    return{
      'phone': phone,
      'password': password,
      'role': role,
      'driver_id': driver_id,
    };
  }

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
        id: json['id'] as int,
     phone: json['phone'] as int,
        password: json['password'] as String,
        role: json['role'] as String,
        driver_id: ['driver_id'] as int);
  }
}