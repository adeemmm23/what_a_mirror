import 'package:flutter/material.dart';

// Main images
const logo = {
  'dark': 'assets/images/dark_logo.png',
  'light': 'assets/images/light_logo.png',
};

const notFound = {
  'dark': 'assets/images/dark_not_found.png',
  'light': 'assets/images/light_not_found.png',
};

// Modules images
const clockImage = {
  'dark': 'assets/images/dark_clock_module.PNG',
  'light': 'assets/images/light_clock_module.PNG',
};

const calendarImage = {
  'dark': 'assets/images/dark_calendar_module.PNG',
  'light': 'assets/images/light_calendar_module.PNG',
};

const weatherImage = {
  'dark': 'assets/images/dark_weather_module.PNG',
  'light': 'assets/images/light_weather_module.PNG',
};

const newsImage = {
  'dark': 'assets/images/dark_news_module.PNG',
  'light': 'assets/images/light_news_module.PNG',
};

const spotifyImage = {
  'dark': 'assets/images/dark_spotify_module.PNG',
  'light': 'assets/images/light_spotify_module.PNG',
};

const complimentsImage = {
  'dark': 'assets/images/dark_compliments_module.PNG',
  'light': 'assets/images/light_compliments_module.PNG',
};

const scanningLottie = {
  'dark': 'assets/images/dark_scanning.json',
  'light': 'assets/images/light_scanning.json',
};

String isDark(BuildContext context, dark, light) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return dark;
  } else {
    return light;
  }
}
