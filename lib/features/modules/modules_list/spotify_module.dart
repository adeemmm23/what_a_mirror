import 'package:flutter/material.dart';
import 'package:the_mirror/core/images.dart';

import '../../../core/modules_post.dart';
import '../../../core/spotify_request.dart';
import '../../../core/widgets.dart';
import '../modules_settings/modules_map.dart';

class SpotifyModule extends StatefulWidget {
  const SpotifyModule({super.key});

  @override
  State<SpotifyModule> createState() => _SpotifyModuleState();
}

class _SpotifyModuleState extends State<SpotifyModule> {
  bool connectedSpotify = spotifyModuleMap['config']['refreshToken'] != null; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String message = await postModules(spotifyModuleMap, 7);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          }
        },
        icon: const Icon(Icons.save),
        label: const Text('Save'),
      ),
      appBar: AppBar(
        title: const Text('Spotify Module'),
      ),
      body: StatefulBuilder(builder: (context, localSetState) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              shadowColor: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                isDark(
                    context, spotifyImage['dark'], spotifyImage['light']),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: !spotifyModuleMap['disabled'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['disabled'] = !value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.music_note),
                  title: const Text('Enable Module'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.background),
                      backgroundColor: connectedSpotify
                          ? MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary)
                          : MaterialStateProperty.all(
                              Theme.of(context).colorScheme.tertiary),
                    ),
                    onPressed: () {
                      if (!connectedSpotify) {
                        launchSpotifyAuthentication();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Disconnect Spotify'),
                                content: const Text(
                                    'Are you sure you want to disconnect Spotify?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      localSetState(() {
                                        spotifyModuleMap['config']
                                            ['refreshToken'] = null;
                                        connectedSpotify = false;
                                      });
                                      postModules(spotifyModuleMap, 7);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Disconnect'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: connectedSpotify
                        ? const Text('Connected')
                        : const Text('Connect'),
                  ),
                  leading: const Icon(Icons.link),
                  title: const Text('Connect to Spotify'),
                )),
            const Divider(
              height: 20,
              indent: 20,
              endIndent: 20,
            ),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: FilledButton.icon(
                    onPressed: () {
                      spotifyModulePositionMBS(
                          context, positions, localSetState);
                    },
                    icon: const Icon(Icons.expand_more),
                    label:
                        Text(getPositionName(spotifyModuleMap['position'])),
                  ),
                  leading: const Icon(Icons.flip_to_front),
                  title: const Text('Position'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: spotifyModuleMap['config']['theming']
                        ['showBlurBackground'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['config']['theming']
                            ['showBlurBackground'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.blur_on),
                  title: const Text('Show blur background'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: spotifyModuleMap['config']['theming']
                        ['spotifyCodeExperimentalShow'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['config']['theming']
                            ['spotifyCodeExperimentalShow'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.qr_code),
                  title: const Text('Song bar code'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: spotifyModuleMap['config']['theming']
                        ['roundProgressBar'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['config']['theming']
                            ['roundProgressBar'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.egg_rounded),
                  title: const Text('Round progress bar'),
                )),
            Card(
                elevation: 2,
                shadowColor: Colors.transparent,
                child: ListTile(
                  trailing: Switch(
                    value: spotifyModuleMap['config']['theming']
                        ['fadeAnimations'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['config']['theming']
                            ['fadeAnimations'] = value;
                      });
                    },
                  ),
                  leading: const Icon(Icons.animation),
                  title: const Text('Fade animations'),
                )),
            const SizedBox(height: 150)
          ],
        );
      }),
    );
  }

  // Modal Bottom Sheet for Position
  Future<dynamic> spotifyModulePositionMBS(
      BuildContext context, List positions, StateSetter localSetState) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
        showDragHandle: true,
        context: context,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            children: [
              for (var position in positions)
                ListTile(
                  title: Text(position.position),
                  trailing: Radio(
                    value: position.id,
                    groupValue: spotifyModuleMap['position'],
                    onChanged: (value) {
                      localSetState(() {
                        spotifyModuleMap['position'] = value;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          );
        });
  }
}
