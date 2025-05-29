import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, Welcome Back!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "Find your perfect restaurant for eat today!",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 12,),
      ],
    );
  }

}