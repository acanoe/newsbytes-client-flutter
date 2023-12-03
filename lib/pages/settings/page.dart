import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/titlebar.dart';
import '../../controllers/news.dart';
import '../../controllers/settings.dart';

class SettingsPage extends GetView<SettingsController> {
  static const String routeName = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          TitleBar(
            title: 'Settings',
            showBack: true,
            onBack: () {
              Get.back();
              NewsController.to.getNews();
            },
          ),
          const SizedBox(height: 16.0),
          ListTile(
            title: const Text('Base URL'),
            subtitle: TextField(
              controller: controller.urlController,
              onSubmitted: controller.setBaseUrl,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.db.settings.listenable(),
            builder: (_, box, __) {
              String value = box.get('darkMode', defaultValue: 'system');

              return ListTile(
                title: const Text('Dark Mode'),
                trailing: DropdownButton<String>(
                  value: value,
                  items: const [
                    DropdownMenuItem(
                      value: 'system',
                      child: Text('System'),
                    ),
                    DropdownMenuItem(
                      value: 'light',
                      child: Text('Light'),
                    ),
                    DropdownMenuItem(
                      value: 'dark',
                      child: Text('Dark'),
                    ),
                  ],
                  onChanged: (value) => box.put('darkMode', value),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
