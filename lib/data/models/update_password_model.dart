import 'package:papi_gold/domain/entities/update_password_entity.dart';

class UpdatePasswordModel extends UpdatePasswordEntity {
  const UpdatePasswordModel({
    required super.confirmNewPassword,
    required super.currentPassword,
    required super.newPassword,
  });

  factory UpdatePasswordModel.fromEntity(UpdatePasswordEntity e) {
    return UpdatePasswordModel(
      currentPassword: e.currentPassword,
      confirmNewPassword: e.confirmNewPassword,
      newPassword: e.newPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
    };
  }
}
