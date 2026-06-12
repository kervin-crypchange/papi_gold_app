class RecoveryModel {
  final String email;

  RecoveryModel({required this.email});

  /// Converts a JSON map to a [RecoveryModel].
  factory RecoveryModel.fromJson(Map<String, dynamic> json) {
    return RecoveryModel(email: json['email']);
  }

/// Converts a [RecoveryModel] to a JSON map.
  Map<String, dynamic> toJson(){
    return <String, dynamic> {
      'email': email
    };
  }
}
