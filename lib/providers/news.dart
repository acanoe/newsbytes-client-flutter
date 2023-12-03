import 'package:get/get.dart';

import '../models/news.dart';

class NewsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = News.fromJson;
  }

  Future<Response<News>> getNews(String url, {String? tag}) {
    String path = '/feed.json';
    if (tag != null) {
      path += '?search=$tag';
    }
    return get(url + path);
  }
}
