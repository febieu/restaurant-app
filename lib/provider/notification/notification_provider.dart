import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/services/notification/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  static const _prefKey = 'daily_reminder_enabled';

  final LocalNotificationService _localNotificationService;

  NotificationProvider(this._localNotificationService) {
    _loadPreference();
  }

  bool? _permission = false;
  bool get permission => _permission ?? false;

  Future<void> requestPermissions() async {
    _permission = await _localNotificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _permission = prefs.getBool(_prefKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleDailyReminder(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, isEnabled);
    _permission = isEnabled;
    notifyListeners();

    if (isEnabled) {
      await _localNotificationService.scheduleDailyElevenAMNotification(id: 1);
    } else {
      await _localNotificationService.cancelNotification(1);
    }
    // print('toggleDailyReminder called with value: $isEnabled');
  }

  // void showNotification() {
  //   _localNotificationService.scheduleDailyElevenAMNotification(
  //       id: 1
  //   );
  // }
}