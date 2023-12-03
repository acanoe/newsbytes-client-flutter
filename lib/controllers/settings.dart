import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/db.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final DbService db = Get.find();
  late final TextEditingController urlController;

  String url = '';

  @override
  void onInit() {
    super.onInit();

    String baseUrl = db.settings.get(
      'url',
      defaultValue: 'https://progscrape.com',
    );

    urlController = TextEditingController(text: baseUrl);
    url = baseUrl;
  }

  void setBaseUrl(String baseUrl) {
    db.settings.put('url', baseUrl);
    url = baseUrl;
    update();
  }
}
