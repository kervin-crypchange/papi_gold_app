abstract class AuthLocalData {
  String getSavedToken();
  void saveToken(String token);
  String getSavedRefreshToken();
  void saveRefreshToken(String token);
  void setIsLogged(bool isLogged);
  void clear();
  bool getIsLogged();
}
