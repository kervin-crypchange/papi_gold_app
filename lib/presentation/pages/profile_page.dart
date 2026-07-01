import 'package:papi_gold/app/common/widgets/index.dart';
import 'package:papi_gold/app/core/extensions/index.dart';
import 'package:papi_gold/app/core/store/client_data_model.dart';
import 'package:papi_gold/app/core/store/persistent_client_data.dart';

class ProfilePage extends StatelessWidget {
  final PersistentClientDataModel clientData = PersistentClientData().getClientData();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(child: Text(clientData.fullName, style: context.titleMedium)),
      ),
    );
  }
}
