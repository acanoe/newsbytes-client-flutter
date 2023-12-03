import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'controllers/news.dart';
import 'controllers/settings.dart';
import 'providers/news.dart';
import 'services/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const NewsBytesApp());
}

Future initServices() async {
  if (kDebugMode) print('starting services ...');
  await Get.putAsync(() => DbService().init());

  Get.lazyPut(() => NewsProvider());

  Get.lazyPut(() => SettingsController());
  Get.lazyPut(() => NewsController());
  if (kDebugMode) print('All services started...');
}
