import 'package:papi_gold/app/common/widgets/index.dart';

class UnreadNotificationsModel with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void unread(int count) {
    _count = count;
    notifyListeners();
  }
}