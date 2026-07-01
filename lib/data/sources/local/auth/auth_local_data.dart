import 'package:papi_gold/data/models/client_model.dart';

abstract class AuthLocalData {
  String getSavedToken();
  void saveToken(String token);
  void saveUserLogged(ClientModel m);
  void setIsLogged(bool isLogged);
  void clear();
  ClientModel getUserLogged();
  bool getIsLogged();
}
