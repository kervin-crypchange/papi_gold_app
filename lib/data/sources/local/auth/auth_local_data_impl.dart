import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/sources/local/auth/auth_local_data.dart';

class AuthLocalDataImpl extends AuthLocalData with LoggerMixin {
  late final Box box;

  AuthLocalDataImpl() {
    box = Hive.box(BoxEnum.config.name);
  }

  @override
  String getSavedToken() {
    try {
      return box.get(BoxEnum.config.token, defaultValue: '');
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  void saveToken(String token) {
    try {
      box.put(BoxEnum.config.token, token);
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  bool getIsLogged() {
    return box.get(BoxEnum.config.isLogged) ?? false;
  }

  @override
  void setIsLogged(bool isLogged) {
    box.put(BoxEnum.config.isLogged, isLogged);
  }
  
  @override
  void clear() {
    box.clear();
  }
}
