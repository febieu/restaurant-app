import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.themeMode == ThemeMode.dark;

    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: isDark,
        activeColor: Colors.orange,
        onChanged: (bool value) {
          themeProvider.toggleTheme(value);

          final error = themeProvider.error;
          if (error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      ),
    );
  }
}