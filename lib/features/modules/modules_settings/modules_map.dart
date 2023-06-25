// Alert Module
Map<String, dynamic> alertModuleMap = {
  'disabled': true,
  'module': 'alert',
};

// Clock Module
Map<String, dynamic> clockModuleMap = {
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
Map<String, dynamic> weatherCurrentModuleMap = {
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
Map<String, dynamic> weatherForcastModuleMap = {
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
Map<String, dynamic> newsModuleMap = {
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
Map<String, dynamic> calendarModuleMap = {
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
Map<String, dynamic> complimentsModuleMap = {
  'disabled': false,
  'module': 'compliments',
  'position': 'lower_third',
  'config': {
    'compliments': {
      'anytime': ['Hey there!'],
      'morning': [],
      'afternoon': [],
      'evening': [],
      'morningAdditional': [],
      'afternoonAdditional': [],
      'eveningAdditional': [],
      'noCompliments': 'No compliments found',
    },
  },
};

// Spotify Module
Map<String, dynamic> spotifyModuleMap = {
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
Map<String, dynamic> wallpaperModuleMap = {
  'disabled': false,
  'module': 'MMM-Wallpaper',
  'position': 'fullscreen_below',
  'config': {
    'index': 0,
    'source':
        'https://firebasestorage.googleapis.com/v0/b/smart-mirror-5467c.appspot.com/o/default%20wallpapers%2FBlack.jpg?alt=media&token=8ec6b3fd-a424-4606-b004-69a8f74a8fcc',
  },
};

// Brightness Module
Map<String, dynamic> brightnessModuleMap = {
  'disabled': false,
  'module': 'MMM-Brightness',
  'position': 'fullscreen_above',
  'config': {
    'brightness': 0.5,
  },
};

// News Feed RSS
Map<String, dynamic> newsFeedRSS = {
  'Al Jazeera': {
    'title': 'Al Jazeera',
    'url': 'http://www.aljazeera.com/xml/rss/all.xml',
  },
  'BBC News': {
    'title': 'BBC News',
    'url': 'http://feeds.bbci.co.uk/news/rss.xml?edition=uk',
  },
  'BBC News Arabic': {
    'title': 'BBC News Arabic',
    'url': 'https://feeds.bbci.co.uk/arabic/rss.xml',
  },
  'CNN': {
    'title': 'CNN',
    'url': 'http://rss.cnn.com/rss/edition.rss',
  },
  'Nessma': {
    'title': 'Nessma',
    'url': 'https://www.nessma.tv/ar/rss/news/30',
  },
  'Tunisie Numérique': {
    'title': 'Tunisie Numérique',
    'url': 'https://www.tunisienumerique.com/feed/',
  },
  'Gaming News': {
    'title': 'Gaming News',
    'url': 'https://www.gameinformer.com/news.xml',
  },
  'TechCrunch': {
    'title': 'TechCrunch',
    'url': 'https://techcrunch.com/feed/',
  },
  'The Verge': {
    'title': 'The Verge',
    'url': 'https://www.theverge.com/rss/index.xml',
  },
  'The Next Web': {
    'title': 'The Next Web',
    'url': 'https://thenextweb.com/feed/',
  },
};

// Morning compliments
List<String> morningCompliments = [
  'Good morning!',
  'Enjoy your day!',
  'How was your sleep?',
  'Who needs coffee when you have your smile?',
  'Rise and shine, superstar!',
  'Keep smiling, it looks great on you!',
];

// Afternoon compliments
List<String> afternoonCompliments = [
  'You look nice!',
  'You\'re doing great today!',
  'Looking sharp!',
  'What\'s for lunch?',
  'Great outfit!',
  'Pleasant day, isn\'t it?',
];

// Evening compliments
List<String> eveningCompliments = [
  'Wow, you look so good tonight!',
  'You look fantastic!',
  'Have a nice evening!',
  'Sleep tight!',
  'Great Night isn\'t it?',
  'You\'re a gift to those around you.',
];
