import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'modules_post.dart';
import '../features/modules/modules_settings/modules_map.dart';

// Clock Module Get Data
Future<void> getClockModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/1');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  clockModuleMap = Map<String, dynamic>.from(data);
  debugPrint('Clock module is ready');
}

// Calendar Module Get Data
Future<void> getCalendarModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/2');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  calendarModuleMap = Map<String, dynamic>.from(data);
  List<dynamic> calendarList =
      List<dynamic>.from(calendarModuleMap['config']['calendars'] ?? []);
  List<dynamic> addionalCalendars = List<dynamic>.from(
      calendarModuleMap['config']['addionalCalendars'] ?? []);
  calendarModuleMap['config']['calendars'] = calendarList;
  calendarModuleMap['config']['addionalCalendars'] = addionalCalendars;
  debugPrint('Calendar module is ready');
}

// Weather Current Module Get Data
Future<void> getWeatherModuleData() async {
  DatabaseReference ref1 =
      FirebaseDatabase.instance.ref('users/$uid/modules/4');
  DatabaseReference ref2 =
      FirebaseDatabase.instance.ref('users/$uid/modules/5');
  DatabaseEvent event1 = await ref1.once();
  DatabaseEvent event2 = await ref2.once();
  Map<dynamic, dynamic> data = event1.snapshot.value as Map<dynamic, dynamic>;
  Map<dynamic, dynamic> data2 = event2.snapshot.value as Map<dynamic, dynamic>;
  weatherCurrentModuleMap = Map<String, dynamic>.from(data);
  weatherForcastModuleMap = Map<String, dynamic>.from(data2);
  debugPrint('Weather module is ready');
}

// compliments Modules Get Data
Future<void> getComplementsModulesData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/3');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  complimentsModuleMap = Map<String, dynamic>.from(data);
  List<dynamic> afternoonList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['afternoon'] ?? []);
  List<dynamic> eveningList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['evening'] ?? []);
  List<dynamic> morningList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['morning'] ?? []);
  List<dynamic> afternoonAdditionalList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['afternoonAdditional'] ??
          []);
  List<dynamic> eveningAdditionalList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['eveningAdditional'] ?? []);
  List<dynamic> morningAdditionalList = List<dynamic>.from(
      complimentsModuleMap['config']['compliments']['morningAdditional'] ?? []);
  complimentsModuleMap['config']['compliments'] = {
    'afternoon': afternoonList,
    'evening': eveningList,
    'morning': morningList,
    'afternoonAdditional': afternoonAdditionalList,
    'eveningAdditional': eveningAdditionalList,
    'morningAdditional': morningAdditionalList,
    'noCompliments': 'No compliments found',
  };
  debugPrint('Compliments module is ready');
}

// News Module Get Data
Future<void> getNewsModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/6');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  newsModuleMap = Map<String, dynamic>.from(data);
  List<dynamic> newsList =
      List<dynamic>.from(newsModuleMap['config']['feeds'] ?? []);
  newsModuleMap['config']['feeds'] = newsList;
  debugPrint('News module is ready');
}

// Spotify Module Get Data
Future<void> getSpotifyModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/7');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  spotifyModuleMap = Map<String, dynamic>.from(data);
  debugPrint('Spotify module is ready');
}

// Wallpaper Module Get Data
Future<void> getWallpapersModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/8');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  wallpaperModuleMap = Map<String, dynamic>.from(data);
  debugPrint('Wallpaper module is ready');
}

// Brightness Module Get Data
Future<void> getBrightnessModuleData() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/modules/9');
  DatabaseEvent event = await ref.once();
  Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  brightnessModuleMap = Map<String, dynamic>.from(data);
  debugPrint('Brightness module is ready');
}