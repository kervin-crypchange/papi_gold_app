import 'package:papi_gold/app/common/utils/utils.dart';
import 'package:papi_gold/domain/entities/update_password_entity.dart';

class UpdatePasswordModel extends UpdatePasswordEntity {
  const UpdatePasswordModel({
    required super.confirmNewPassword,
    required super.currentPassword,
    required super.newPassword,
    super.verificationCode,
  });

  factory UpdatePasswordModel.fromEntity(UpdatePasswordEntity e) {
    return UpdatePasswordModel(
      currentPassword: e.currentPassword,
      confirmNewPassword: e.confirmNewPassword,
      newPassword: e.newPassword,
      verificationCode: e.verificationCode,
    );
  }
  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordModel(
      confirmNewPassword: safeString(json['confirmNewPassword']),
      currentPassword: safeString(json['currentPassword']),
      newPassword: safeString(json['newPassword']),
      verificationCode: safeString(json['verificationCode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
      'verification_code': verificationCode,
    };
  }
}
