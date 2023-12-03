import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbService extends GetxService {
  Box get favorites => Hive.box('favorites');
  Box get settings => Hive.box('settings');

  Future<DbService> init() async {
    await Hive.initFlutter();
    await Hive.openBox('favorites');
    await Hive.openBox('settings');

    return this;
  }
}
