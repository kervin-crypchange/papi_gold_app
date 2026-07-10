import 'package:hive_flutter/hive_flutter.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';

class ClientController {
  final Box<PersistentClientDataModel> _clientBox =
      Hive.box<PersistentClientDataModel>('clientBox');

  void saveClientData(PersistentClientDataModel clientData) {
    PersistentClientDataModel? existingData = _clientBox.get('clientData');
    if (existingData != null) {
      _clientBox.put(
        'clientData',
        PersistentClientDataModel(
          id: existingData.id,
          name: clientData.name,
          lastName: clientData.lastName,
          email: clientData.email,
          phone: clientData.phone,
          country: clientData.country,
          state: clientData.state,
          city: clientData.city,
          address1: clientData.address1,
          address2: clientData.address2,
          codeZip: clientData.codeZip,
          receiveAdvertise: clientData.receiveAdvertise,
          category: clientData.category,
        ),
      );
    } else {
      _clientBox.put(
        'clientData',
        PersistentClientDataModel(
          id: clientData.id,
          name: clientData.name,
          lastName: clientData.lastName,
          email: clientData.email,
          phone: clientData.phone,
          country: clientData.country,
          state: clientData.state,
          city: clientData.city,
          address1: clientData.address1,
          address2: clientData.address2,
          codeZip: clientData.codeZip,
          receiveAdvertise: clientData.receiveAdvertise,
          category: clientData.category,
        ),
      );
    }
  }

  PersistentClientDataModel getClientData() {
    PersistentClientDataModel clientData =
        _clientBox.get('clientData') ??
        PersistentClientDataModel(
          id: 0,
          name: '',
          lastName: '',
          email: '',
          phone: '',
          country: {},
          state: {},
          city: {},
          address1: '',
          address2: '',
          codeZip: '',
          receiveAdvertise: false,
          category: '',
        );
    return clientData;
  }

  String getFullName() {
    PersistentClientDataModel clientData = getClientData();
    return '${clientData.name} ${clientData.lastName}';
  }

  String getEmail() {
    PersistentClientDataModel clientData = getClientData();
    return clientData.email;
  }

  void clearClientData() {
    _clientBox.clear();
  }
}
