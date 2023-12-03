import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/storycard.dart';
import '../../components/titlebar.dart';
import '../../controllers/news.dart';
import '../pages.dart';

class FilterPage extends GetView<NewsController> {
  static const String routeName = '/filter';

  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    String tag = Get.arguments['tag'] ?? 'all';

    return Scaffold(
      body: GetBuilder<NewsController>(
        builder: (_) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TitleBar(
                  title: 'Filter Stories',
                  showBack: true,
                  onBack: () {
                    Get.offAllNamed(MainPage.routeName);
                    controller.getNews();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 72.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ActionChip(
                        label: Text(tag),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        side: BorderSide.none,
                        padding: const EdgeInsets.all(4.0),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    buildStoryList(context),
                  ),
                ),
              ),
            ],
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
}
