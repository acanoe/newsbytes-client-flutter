import 'package:get/get.dart';
import 'package:newsbytes/providers/news.dart';

import '../models/news.dart';
import '../pages/pages.dart';
import '../services/db.dart';
import 'settings.dart';

class NewsController extends GetxController {
  static NewsController get to => Get.find();

  final DbService db = Get.find();
  final SettingsController settings = Get.find();
  final NewsProvider newsProvider = Get.find();

  List<Story> stories = [];
  List<String> tags = [];
  bool isLoading = false;

  Future<void> getNews({String? tag}) async {
    isLoading = true;
    update();

    String url = settings.url;
    Response<News> res = await newsProvider.getNews(url, tag: tag);
    stories = res.body?.stories ?? [];
    tags = res.body?.tags ?? [];

    isLoading = false;
    update();
  }

  void filterByTag(String tag) {
    getNews(tag: tag);
    Get.toNamed(FilterPage.routeName, arguments: {'tag': tag});
  }

  Future<void> addFavorite(Story story) async {
    await db.favorites.add(story.toJson());
  }

  Future<void> removeFavorite(Story story) async {
    Map favorites = db.favorites.toMap();
    int index = favorites.entries
        .singleWhere((element) => element.value['href'] == story.href)
        .key;

    await db.favorites.deleteAt(index);
  }
}
