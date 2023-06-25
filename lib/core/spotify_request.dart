import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'modules_post.dart';
import '/features/modules/modules_settings/modules_map.dart';


// open Spotify authorization page in user's browser
final authorizationUrl =
    Uri.parse('https://accounts.spotify.com/authorize').replace(
  queryParameters: {
    'client_id': '5558dc3169fd40e6a349a195bfb1fa72',
    'response_type': 'code',
    'redirect_uri': 'myapp://mirror/callback',
    'scope':
        'user-read-playback-state user-read-currently-playing user-top-read user-read-private',
  },
);

void launchSpotifyAuthentication() async {
  if (!await launchUrl(authorizationUrl,
      mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $authorizationUrl';
  }
}

Future getRefreshToken(String code) async {
  const clientId = '5558dc3169fd40e6a349a195bfb1fa72';
  const clientSecret = 'b74e40e72bc5433a97cdc9e6c534e261';
  const redirectUri = 'myapp://mirror/callback';

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}',
    },
    body: {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUri,
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final refreshToken = jsonResponse['refresh_token'] as String?;
    debugPrint('Spotify refresh token: $refreshToken');
    spotifyModuleMap['config']['refreshToken'] = refreshToken;
    postModules(spotifyModuleMap, 7);
  }
  else {
    throw Exception('Failed to get refresh token');
  }
}
