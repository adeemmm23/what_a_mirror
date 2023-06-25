import 'package:flutter/material.dart';

// validate Email
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email address';
  }
  final String email = value.trim();
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegExp.hasMatch(email)) {
    return 'Please enter a valid email address';
  }
  return null;
}

// validate Password
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

// validate Repeat Password
String? validateRepeatPassword(
    String? value, TextEditingController controller) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value != controller.text) {
    return 'The password isn\'t matching';
  }
  return null;
}

// validate Url that ends with .ics
String? validateUrl(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your calendar url';
  }
  final String url = value.trim();
  final RegExp urlRegExp = RegExp(
    r'^https?:\/\/.*\.ics$',
  );
  if (!urlRegExp.hasMatch(url)) {
    return 'Please enter a valid calendar url';
  }
  return null;
}

// validate name not empty
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }
  return null;
}

// validate name not empty
String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a name';
  }
  if (value.contains(' ')) {
    return 'Please enter just your first name';
  }
  return null;
}

// validate name not empty
String? validateDelete(String? value) {
  if (value != 'DELETE') {
    return 'Please enter DELETE';
  }
  return null;
}