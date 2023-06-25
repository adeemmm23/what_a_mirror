import 'package:flutter/material.dart';
import '../../core/modules_request.dart';
import '../favorite/favorite.dart';
import '../modules/modules.dart';
import '../settings/settings.dart';
import 'package:the_mirror/core/images.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bottomSelectedIndex = 0;

  late Future _future;
  @override
  void initState() {
    super.initState();
    _future = Future.wait([
      getClockModuleData(),
      getWeatherModuleData(),
      getNewsModuleData(),
      getComplementsModulesData(),
      getSpotifyModuleData(),
      getCalendarModuleData(),
      getWallpapersModuleData(),
      getBrightnessModuleData(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          debugPrint('snapshot.connectionState: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        isDark(context, logo['dark'], logo['light']),
                        height: 34,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            );
          }
          return StatefulBuilder(builder: (context, localSetState) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                  child: Image.asset(
                    isDark(context, logo['dark'], logo['light']),
                    height: 30,
                  ),
                ),
              ),
              body: IndexedStack(
                index: bottomSelectedIndex,
                children: const [
                  ModulesPage(),
                  FavoritePage(),
                  SettingPage(),
                ],
              ),
              bottomNavigationBar: NavigationBar(
               elevation: 0,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: bottomSelectedIndex,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.receipt),
                    label: 'Modules',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_rounded),
                    label: 'Theme',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_rounded),
                    label: 'Settings',
                  ),
                ],
                onDestinationSelected: (index) {
                  localSetState(() {
                    bottomSelectedIndex = index;
                  });
                },
              ),
            );
          });
        });
  }
}
