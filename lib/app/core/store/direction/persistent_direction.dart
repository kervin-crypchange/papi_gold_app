import 'package:flutter/material.dart';
import 'package:papi_gold/app/core/store/direction/model/persisten_direction_model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersistentDirection {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(PersistenDirectionModelAdapter());
    await Hive.openBox<PersistenDirectionModel>('directionBox');
  }

  
}
