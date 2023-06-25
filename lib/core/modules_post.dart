import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../features/modules/modules_settings/modules_map.dart';

// Get the current user's uid
String displayName = FirebaseAuth.instance.currentUser!.displayName!;
String uid = FirebaseAuth.instance.currentUser!.uid;

// Send the user's modules to the database
Future<String> postModules(
    Map<String, dynamic> modules, int moduleNumber) async {
  try {
    debugPrint('Module $moduleNumber posted with data: $modules');
    final dbRef =
        FirebaseDatabase.instance.ref('users/$uid/modules/$moduleNumber');
    await dbRef.update(modules);
    debugPrint('Module $moduleNumber posted successfully');
    return 'Saved successfully';
  } on FirebaseException catch (e) {
    debugPrint('Failed to post module $moduleNumber: $e');
    return 'Failed to save, please try again later';
  }
}

// Modules class with all the modules and number of modules
class Modules {
  final int id;
  final Map<String, dynamic> map;

  Modules(this.id, this.map);
}

final List<Modules> modulesList = [
  Modules(0, alertModuleMapDefault),
  Modules(1, clockModuleMapDefault),
  Modules(2, calendarModuleMapDefault),
  Modules(3, complimentsModuleMapDefault),
  Modules(4, weatherCurrentModuleMapDefault),
  Modules(5, weatherForcastModuleMapDefault),
  Modules(6, newsModuleMapDefault),
  Modules(7, spotifyModuleMapDefault),
  Modules(8, wallpaperModuleMapDefault),
  Modules(9, brightnessModuleMapDefault),
];


// Alert Module
Map<String, dynamic> alertModuleMapDefault = {
  'disabled': true,
  'module': 'alert',
};

// Clock Module
Map<String, dynamic> clockModuleMapDefault = {
  'disabled': false,
  'module': 'clock',
  'position': 'top_left',
  'config': {
    'timeFormat': 24,
    'showTime': true,
    'showDate': true,
    'displayType': 'digital',
    'displaySeconds': true,
    'clockBold': false,
    'analogFace': 'face-001',
  }
};

// Weather Current Module
Map<String, dynamic> weatherCurrentModuleMapDefault = {
  'disabled': false,
  'module': 'weather',
  'position': 'top_right',
  'config': {
    'apiKey': '303ae10ea5f51a080a1d26700990f2a4',
    'location': 'Sousse',
    'locationID': '2464912',
    'weatherProvider': 'openweathermap',
    'type': 'current',
    'units': 'metric',
    'tempUnits': 'metric',
    'windUnits': 'metric',
  }
};

// Weather Forecast Module
Map<String, dynamic> weatherForcastModuleMapDefault = {
  'disabled': false,
  'module': 'weather',
  'position': 'top_right',
  'header': 'Weather Forecast',
  'config': {
    'apiKey': '303ae10ea5f51a080a1d26700990f2a4',
    'location': 'sousse',
    'locationID': '2464912',
    'weatherProvider': 'openweathermap',
    'type': 'forecast',
    'units': 'metric',
    'tempUnits': 'metric',
    'windUnits': 'metric',
  }
};

// News Module
Map<String, dynamic> newsModuleMapDefault = {
  'disabled': false,
  'module': 'newsfeed',
  'position': 'bottom_left',
  'config': {
    'feeds': [
      newsFeedRSS['Al Jazeera'],
    ],
    'showSourceTitle': true,
    'showPublishDate': true,
    'broadcastNewsFeeds': true,
    'broadcastNewsUpdates': true,
    'showDescription': false,
  }
};

// Calendar Module
Map<String, dynamic> calendarModuleMapDefault = {
  'disabled': false,
  'header': 'Your calendar',
  'module': 'calendar',
  'position': 'top_left',
  'config': {
    'calendars': [
      {
        'name': 'Islamics Holiday',
        'url':
            'https://calendar.google.com/calendar/ical/en.islamic%23holiday%40group.v.calendar.google.com/public/basic.ics',
        'symbol': 'kaaba',
      },
    ],
    'addionalCalendars': [
      {},
    ],
    'maximumEntries': 10,
    'fade': true,
  },
};

// Compliments Module
Map<String, dynamic> complimentsModuleMapDefault = {
  'disabled': false,
  'module': 'compliments',
  'position': 'lower_third',
  'config': {
    'compliments': {
      'anytime': ['Hey there!'],
      'morning': [
        'Good morning, $displayName'
      ],
      'afternoon': ['Hello, $displayName'],
      'evening': [
        'Hi, beautiful $displayName!'
      ],
      'morningAdditional': ['Good morning, $displayName'],
      'afternoonAdditional': ['Hello, $displayName'],
      'eveningAdditional': ['Hi, beautiful $displayName!'],
      'noCompliments': 'No compliments found',
    },
  },
};

// Spotify Module
Map<String, dynamic> spotifyModuleMapDefault = {
  'disabled': false,
  'module': 'MMM-OnSpotify',
  'position': 'bottom_right',
  'config': {
    'accessToken': '',
    'clientID': '5558dc3169fd40e6a349a195bfb1fa72',
    'clientSecret': 'b74e40e72bc5433a97cdc9e6c534e261',
    'refreshToken': null,
    'theming': {
      'alwaysUseDefaultDeviceIcon': true,
      'fadeAnimations': false,
      'mediaAnimations': false,
      'roundMediaCorners': true,
      'roundProgressBar': true,
      'showBlurBackground': false,
      'spotifyCodeExperimentalShow': false,
      'spotifyCodeExperimentalUseColor': true,
      'transitionAnimations': true,
      'useColorInProgressBar': true,
      'useColorInTitle': true,
      'useColorInUserData': true
    },
  },
};

// wallpaper Module
Map<String, dynamic> wallpaperModuleMapDefault = {
  'disabled': false,
  'module': 'MMM-Wallpaper',
  'position': 'fullscreen_below',
  'config': {
    'index': 0,
    'source': 'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBlack.jpg?alt=media&token=8ec6b3fd-a424-4606-b004-69a8f74a8fcc',
  },
};

// Brightness Module
Map<String, dynamic> brightnessModuleMapDefault = {
  'disabled': false,
  'module': 'MMM-Brightness',
  'position': 'fullscreen_above',
  'config': {
    'brightness': 1.0,
  },
};