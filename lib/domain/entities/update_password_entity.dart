import 'package:equatable/equatable.dart';

class UpdatePasswordEntity extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final String? verificationCode;

  const UpdatePasswordEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
    this.verificationCode,
  });

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmNewPassword,
    verificationCode,
  ];
}
