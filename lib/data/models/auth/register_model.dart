class RegisterModel {
  final String name;
  final String lastname;
  final String email;
  final String password;

  RegisterModel({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
  });

  /// Converts a JSON map to a [RegisterModel].
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      lastname: json['lastname'],
    );
  }

  /// Converts a [RegisterModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password,
    };
  }
}
