import 'package:api/core/Api/endPoints.dart';

class SignInModel {
  final String message;
  final String token;

  SignInModel({required this.message, required this.token});
  factory SignInModel.formJson(Map<String, dynamic> json) {
    return SignInModel(
      message: json[ApiKey.message],
      token: json[ApiKey.token],
    );
  }
}
