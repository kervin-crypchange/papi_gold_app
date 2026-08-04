import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/store/client/client_controller.dart';
import 'package:papi_gold/app/core/store/client/client_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersistentClientData {
  Logger log = Logger();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PersistentClientDataModelAdapter());
    await Hive.openBox<PersistentClientDataModel>('clientBox');
  }

  Future<void> saveClientData(PersistentClientDataModel clientData) async {
    ClientController().saveClientData(clientData);
    log.i('ClientData saved to Hive box: ${clientData.toJson()}');
  }

  PersistentClientDataModel getClientData() {
    PersistentClientDataModel clientData = ClientController().getClientData();
    log.i('ClientData retrieved from Hive box: ${clientData.toJson()}');
    return clientData;
  }

  String getFullName() {
    log.i('Retrieving full name from Hive box');
    return ClientController().getFullName();
  }
  String getEmail() {
    log.i('Retrieving email from Hive box');
    return ClientController().getEmail();
  }

  Future<void> clearClientData() async {
    ClientController().clearClientData();
    log.i('ClientData cleared from Hive box');
  }
}
