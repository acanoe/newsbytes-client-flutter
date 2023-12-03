import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/news.dart';
import '../models/news.dart';
import 'tag.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard(this.story, {super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find();

    return GestureDetector(
      onTap: () => _launchInBrowser(story.href),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                story.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 48.0,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: story.tags
                      .map(
                        (tag) => Tag(
                          title: tag,
                          onTagClick: controller.filterByTag,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
