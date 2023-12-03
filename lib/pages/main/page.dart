import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/storycard.dart';
import '../../components/tag.dart';
import '../../components/titlebar.dart';
import '../../controllers/news.dart';
import '../pages.dart';

class MainPage extends GetView<NewsController> {
  static const String routeName = '/';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NewsController>(
        initState: (state) => controller.getNews(),
        builder: (_) {
          return RefreshIndicator(
            onRefresh: controller.getNews,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TitleBar(
                    title: 'News',
                    actions: [
                      IconButton(
                        onPressed: controller.getNews,
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: () => Get.toNamed(SettingsPage.routeName),
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                if (controller.tags.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 72.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: buildTagList(context)),
                    ),
                  ),
                ],
                controller.stories.isNotEmpty
                    ? SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            buildStoryList(context),
                          ),
                        ),
                      )
                    : SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            'No stories found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildStoryList(BuildContext context) {
    final controller = NewsController.to;

    if (controller.isLoading) {
      return List.generate(
        6,
        (index) => Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surfaceVariant,
          highlightColor: Theme.of(context).colorScheme.surface,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 8.0,
            ),
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ), // Box decoration
            ),
          ),
        ),
      );
    }

    return controller.stories.map((story) => StoryCard(story)).toList();
  }

  List<Widget> buildTagList(BuildContext context) {
    final controller = NewsController.to;

    if (controller.isLoading) {
      return List.generate(
        6,
        (index) => Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surfaceVariant,
          highlightColor: Theme.of(context).colorScheme.surface,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 20.0,
            ),
            child: Container(
              width: 86.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return controller.tags
        .map(
          (tag) => Tag(
            title: tag,
            onTagClick: controller.filterByTag,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        )
        .toList();
  }
}
