import 'package:get/get.dart';

import 'filter/filter.dart';
import 'main/main.dart';
import 'settings/settings.dart';
export 'filter/filter.dart';
export 'main/main.dart';
export 'settings/settings.dart';

List<GetPage> appPages = [
  GetPage(
    name: MainPage.routeName,
    page: () => const MainPage(),
  ),
  GetPage(
    name: SettingsPage.routeName,
    page: () => const SettingsPage(),
  ),
  GetPage(
    name: FilterPage.routeName,
    page: () => const FilterPage(),
  )
];
