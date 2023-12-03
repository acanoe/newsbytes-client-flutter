import 'dart:convert';

class News {
  final List<Story> stories;
  final List<String> tags;
  final int v;

  News({
    required this.stories,
    required this.tags,
    required this.v,
  });

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(dynamic json) => News(
        stories:
            List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        tags: List<String>.from(json["tags"].map((x) => x)),
        v: json["v"],
      );

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "v": v,
      };
}

class Story {
  final DateTime date;
  final String? hnews;
  final String href;
  final List<String> tags;
  final String title;
  final String? lobsters;
  final String? reddit;
  final String? slashdot;

  Story({
    required this.date,
    this.hnews,
    required this.href,
    required this.tags,
    required this.title,
    this.lobsters,
    this.reddit,
    this.slashdot,
  });

  factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        date: DateTime.parse(json["date"]),
        hnews: json["hnews"],
        href: json["href"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        title: json["title"],
        lobsters: json["lobsters"],
        reddit: json["reddit"],
        slashdot: json["slashdot"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "hnews": hnews,
        "href": href,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "title": title,
        "lobsters": lobsters,
        "reddit": reddit,
        "slashdot": slashdot,
      };
}
