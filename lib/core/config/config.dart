import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'https://api.nuryazid.com/dummy_/station.json';
  static const apiKey = 'API_KEY';
  static const notificationChannelId = 'traveloka_channel_id';
  static const notificationChannelName = 'traveloka notification';
  static const notificationChannelDesc = 'traveloka notification';
  static const savedNotification = 'FCM_MESSAGE';
  static const timeout = kDebugMode ? 90 * 1000 : 10 * 1000;
}
