import 'package:hive/hive.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';

class ClientController {
  final Box<PersistentClientDataModel> _clientBox = Hive.box<PersistentClientDataModel>(
    'clientBox',
  );

  void saveClientData(PersistentClientDataModel clientData) {
    PersistentClientDataModel? existingData = _clientBox.get(clientData.id);
    if (existingData != null) {
      _clientBox.put(
        existingData.key,
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
        ),
      );
    } else {
      // Add new data
      _clientBox.put(
        clientData.key,
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
        ),
      );
    }
  }

  PersistentClientDataModel getClientData() {
    PersistentClientDataModel clientData = _clientBox.get(_clientBox.keys.first) ?? PersistentClientDataModel(
      id: 0,
      name: '',
      lastName: '',
      email: '',
      phone: '',
      country: 0,
      state: 0,
      city: 0,
      address1: '',
      address2: '',
      codeZip: '',
      receiveAdvertise: false,
    );
    return clientData;
  }

  void clearClientData() {
    _clientBox.clear();
  }
}
