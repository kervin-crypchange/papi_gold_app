import 'package:papi_gold/data/models/client_model.dart';

abstract class AuthLocalData {
  Future<String> getSavedToken();
  bool deleteToken();
  bool deleteUserLogged();
  bool saveToken(String token);
  bool saveUserLogged(ClientModel m);
  ClientModel getUserLogged();
  bool getIsLogged();
  void setIsLogged(bool isLogged);
}
