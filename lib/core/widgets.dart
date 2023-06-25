// states List
import 'package:flutter/material.dart';

class StateInfo {
  final String id;
  final String name;

  StateInfo(this.id, this.name);
}

final List<StateInfo> states = [
  StateInfo('2473245', 'Ariana'),
  StateInfo('2472770', 'Béja'),
  StateInfo('2472479', 'Ben Arous'),
  StateInfo('2472699', 'Bizerte'),
  StateInfo('2468365', 'Gabès'),
  StateInfo('2468351', 'Gafsa'),
  StateInfo('2470085', 'Jendouba'),
  StateInfo('2473451', 'Kairouan'),
  StateInfo('2473460', 'Kasserine'),
  StateInfo('2468014', 'Kébili'),
  StateInfo('2473634', 'El Kef'),
  StateInfo('2473574', 'Mahdia'),
  StateInfo('2469274', 'Manouba'),
  StateInfo('2469470', 'Médenine'),
  StateInfo('2473495', 'Monastir'),
  StateInfo('2468576', 'Nabeul'),
  StateInfo('2467450', 'Sfax'),
  StateInfo('2465837', 'Sidi Bouzid'),
  StateInfo('2465027', 'Siliana'),
  StateInfo('2464912', 'Sousse'),
  StateInfo('2464701', 'Tataouine'),
  StateInfo('2464645', 'Tozeur'),
  StateInfo('2464464', 'Tunis'),
  StateInfo('2464038', 'Zaghouan'),
];

// states List
class PositionInfo {
  final String id;
  final String position;

  PositionInfo(this.id, this.position);
}

final List<PositionInfo> positions = [
  PositionInfo('top_left', 'Top Left'),
  PositionInfo('top_center', 'Top Center'),
  PositionInfo('top_right', 'Top Right'),
  PositionInfo('lower_third', 'Center'),
  PositionInfo('bottom_left', 'Bottom Left'),
  PositionInfo('bottom_center', 'Bottom Center'),
  PositionInfo('bottom_right', 'Bottom Right'),
  PositionInfo('bottom_bar', 'Bottom Bar'),
];

// Units List
class UnitInfo {
  final String id;
  final String unit;

  UnitInfo(this.id, this.unit);
}

final List<UnitInfo> units = [
  UnitInfo('metric', 'Metric'),
  UnitInfo('imperial', 'Imperial'),
];

// Clock Face List
class ClockFaceInfo {
  final String id;
  final String face;

  ClockFaceInfo(this.id, this.face);
}

final List<ClockFaceInfo> clockFaces = [
  ClockFaceInfo('face-001', 'Face 1'),
  ClockFaceInfo('face-002', 'Face 2'),
  ClockFaceInfo('face-003', 'Face 3'),
  ClockFaceInfo('face-004', 'Face 4'),
  ClockFaceInfo('face-005', 'Face 5'),
  ClockFaceInfo('face-006', 'Face 6'),
  ClockFaceInfo('face-007', 'Face 7'),
  ClockFaceInfo('face-008', 'Face 8'),
  ClockFaceInfo('face-009', 'Face 9'),
  ClockFaceInfo('face-010', 'Face 10'),
  ClockFaceInfo('face-011', 'Face 11'),
  ClockFaceInfo('face-012', 'Face 12'),
];

// Newsfeed List
class NewsFeedInfo {
  final String feed;

  NewsFeedInfo(this.feed);
}

final List<NewsFeedInfo> newsFeedStations = [
  NewsFeedInfo('Al Jazeera'),
  NewsFeedInfo('BBC News'),
  NewsFeedInfo('BBC News Arabic'),
  NewsFeedInfo('CNN'),
  NewsFeedInfo('Nessma'),
  NewsFeedInfo('Tunisie Numérique'),
  NewsFeedInfo('Gaming News'),
  NewsFeedInfo('TechCrunch'),
  NewsFeedInfo('The Verge'),
  NewsFeedInfo('The Next Web'),
];

// postion id to name
String getPositionName(String id) {
  for (var position in positions) {
    if (position.id == id) {
      return position.position;
    }
  }
  return 'Unknown';
}

// clock face id to name
String getClockFaceName(String id) {
  for (var face in clockFaces) {
    if (face.id == id) {
      return face.face;
    }
  }
  return 'Unknown';
}

// Symbols List for Calendar
class CalendarSymbols {
  final String symbol;
  final IconData icon;

  CalendarSymbols(this.symbol, this.icon);
}

List calendarSymbols = [
  CalendarSymbols('calendar-check', Icons.calendar_today),
  CalendarSymbols('cake-candles fa-fade', Icons.cake),
  CalendarSymbols('star', Icons.star_rounded),
  CalendarSymbols('heart fa-beat', Icons.favorite),
  CalendarSymbols('clock', Icons.access_time),
  CalendarSymbols('person-walking', Icons.directions_walk),
  CalendarSymbols('person-running', Icons.directions_run),
  CalendarSymbols('party-horn', Icons.celebration),
  CalendarSymbols('sun', Icons.wb_sunny),
  CalendarSymbols('moon', Icons.nights_stay),
  CalendarSymbols('cloud', Icons.cloud),
  CalendarSymbols('laptop', Icons.laptop),
];

// Symbol getter
IconData getCalendarSymbol(String symbol) {
  for (var calendarSymbol in calendarSymbols) {
    if (calendarSymbol.symbol == symbol) {
      return calendarSymbol.icon;
    }
  }
  return Icons.calendar_today;
}

// reverse Symbol getter
String getCalendarSymbolName(IconData icon) {
  for (var calendarSymbol in calendarSymbols) {
    if (calendarSymbol.icon == icon) {
      return calendarSymbol.symbol;
    }
  }
  return 'calendar-check';
}

// Newsfeed List
class CalendarInfo {
  final String name;
  final IconData icon;

  CalendarInfo(this.name, this.icon);
}

final List<CalendarInfo> publicCalendarsName = [
  CalendarInfo('Tunisian Holiday', Icons.public),
  CalendarInfo('Islamics Holiday', Icons.mosque),
  CalendarInfo('Moon Phases', Icons.nights_stay),
];

Map<String, dynamic> publicCalendar = {
  'Tunisian Holiday': {
    'name': 'Tunisian Holiday',
    'url': 'https://calendar.google.com/calendar/ical/en.tn%23holiday%40group.v.calendar.google.com/public/basic.ics',
    'symbol': 'earth-africa',
  },
  'Islamics Holiday': {
    'name': 'Islamics Holiday',
    'url': 'https://calendar.google.com/calendar/ical/en.islamic%23holiday%40group.v.calendar.google.com/public/basic.ics',
    'symbol': 'kaaba',
  },
  'Moon Phases': {
    'name': 'Moon Phases',
    'url': 'https://calendar.google.com/calendar/ical/ht3jlfaac5lfd6263ulfh4tql8%40group.calendar.google.com/public/basic.ics',
    'symbol': 'moon',
  }
};

// annotated region
// SystemUiOverlayStyle buildSystemUiOverlayStyle(BuildContext context) {
//   return SystemUiOverlayStyle(
//     // statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
//     //     ? Brightness.light
//     //     : Brightness.dark,
//     // systemNavigationBarIconBrightness:
//     //     Theme.of(context).colorScheme.brightness,
//     // statusBarColor: Theme.of(context).colorScheme.surface,
//     // systemNavigationBarColor: Colors.transparent,
//     // systemNavigationBarDividerColor: Theme.of(context).colorScheme.surface,
//   );
// }