import 'package:logger/logger.dart';
import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/store/client_controller.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersistentClientData {
  Logger log = Logger();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Register the adapters
    // Hive.registerAdapter( PersistentClientData());
    //open cart box
    await Hive.openBox<PersistentClientData>('clientData');
  }

  Future<void> saveClientData(PersistentClientDataModel clientData) async {
    ClientController().saveClientData(clientData);
    log.i('ClientData saved to Hive box: ${clientData.toJson()}');
  }

  Future<PersistentClientDataModel> getClientData() async {
    PersistentClientDataModel clientData = ClientController().getClientData();
    log.i('ClientData retrieved from Hive box: ${clientData.toJson()}');
    return clientData;
  }

  Future<void> clearClientData() async {
    ClientController().clearClientData();
    log.i('ClientData cleared from Hive box');
  }
}
