import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/notification_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold (
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Lunch Notification",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: provider.permission,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      provider.toggleDailyReminder(value);
                      print(value);
                    },
                  ),
                ),
              ],
            ),
            // SizedBox(height: 12),
            // FilledButton(
            //     onPressed: () {
            //       provider.showNotification();
            //     },
            //     child: Text("Test Reminder")
            // )
          ],
        ),
      ),
    );
  }

}