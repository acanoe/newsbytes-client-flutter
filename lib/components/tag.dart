import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.title,
    required this.onTagClick,
    this.backgroundColor,
  });

  final String title;
  final Function(String title) onTagClick;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(title),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
        visualDensity: VisualDensity.compact,
        onSelected: (_) => onTagClick(title),
      ),
    );
  }
}
