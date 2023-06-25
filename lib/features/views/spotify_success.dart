import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpotifySuccess extends StatelessWidget {
  const SpotifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 100,
              child: Image.asset('assets/images/spotify_logo.png'),
            ),
            const SizedBox(height: 20),
            const Text('Connected to Spotify!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            const Text(
              'You can now use Spotify on your mirror!',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  context.go('/modules/spotify_module');
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(left: 15, right: 15)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 30, 215, 95)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text('Go Back')),
          ],
        ),
      ),
    );
  }
}
