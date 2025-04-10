import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String foodName;

  const FoodCard ({
    super.key,
    required this.foodName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          foodName,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.black54
          ),
        ),
      ),
    );
  }
}