import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/description_provider.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DescriptionProvider>();
    final int maxLines = provider.isExpanded ? 30 : 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            provider.toggleExpanded();
          },
          child: Text(
            provider.isExpanded ? "Read Less" : "Read More",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.deepOrange,
            ),
          ),
        ),
      ],
    );
  }
}

