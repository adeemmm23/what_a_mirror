// Packages import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Files import
import 'app_router.dart';
import './theme/color_schema.dart';
import 'firebase_options.dart';

// Theming
ThemeManager themeManager = ThemeManager();
ThemeMode currentTheme = ThemeMode.system;


getCurrentTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeMode = prefs.getString('themeMode');
    switch (themeMode) {
      case 'ThemeMode.light':
        currentTheme = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        currentTheme = ThemeMode.dark;
        break;
      default:
        currentTheme = ThemeMode.system;
    }
  }

// FingerPrint
bool pinLock = false;

// on boarding
bool getStarted = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getCurrentTheme();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinLock = prefs.getBool('pinLock') ?? false;
  getStarted = prefs.getBool('getStarted') ?? false;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late final appRoutes = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: themeManager,
        builder: (context, child) {
          return MaterialApp.router(
            themeAnimationCurve: Curves.easeInOut,
            debugShowCheckedModeBanner: false,
            title: 'What a Mirror',
            theme: ThemeData(
              colorScheme: lightMyColorScheme,
              useMaterial3: true,
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: darkMyColorScheme,
              useMaterial3: true,
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            themeMode: currentTheme,
            routeInformationParser: appRoutes.router.routeInformationParser,
            routeInformationProvider: appRoutes.router.routeInformationProvider,
            routerDelegate: appRoutes.router.routerDelegate,
          );
        });
  }
}
