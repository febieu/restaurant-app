import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final int maxLines = _isExpanded ? 30 : 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? "Read Less" : "Read More",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.deepOrange,
            ),
            // style: TextStyle(
            //   color: Colors.orange,
            // ),
          ),
        ),
      ],
    );
  }
}
