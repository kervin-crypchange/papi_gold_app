import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/common/enums/index.dart';
import 'package:papi_gold/app/common/mixins/index.dart';
import 'package:papi_gold/app/core/error/failure.dart';
import 'package:papi_gold/data/models/index.dart';
import 'package:papi_gold/data/sources/local/auth_local_data.dart';

class AuthLocalDataImpl extends AuthLocalData with LoggerMixin{

  late final Box box;

  AuthLocalDataImpl(){
    box = Hive.box(BoxEnum.config.name);
  }

  @override
  bool deleteToken() {
     try {
      box.delete(BoxEnum.config.token);
      return true;
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  bool deleteUserLogged() {
     try {
      box.delete(BoxEnum.config.userLogged);
      return true;
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  Future<String> getSavedToken() {
     try {
      return Future.value(box.get(BoxEnum.config.token) ?? '');
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  ClientModel getUserLogged() {
    String client = box.get(BoxEnum.config.userLogged);
    return clientModelFromJson(client);
  }

  @override
  bool saveToken(String token) {
    try {
      box.put(BoxEnum.config.token, token);
      return true;
    } catch (e) {
      throw LocalFailure();
    }
  }

  @override
  bool saveUserLogged(ClientModel m) {
    try {
      box.put(BoxEnum.config.userLogged, m.toJson());
      return true;
    } catch (e) {
      throw LocalFailure();
    }
  }
}