// Main Routes Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_mirror/features/settings/profile/delete.dart';
import 'package:the_mirror/features/settings/profile/name.dart';
import 'package:the_mirror/features/settings/profile/password.dart';
import 'package:the_mirror/features/settings/profile_settings.dart';
import 'package:the_mirror/features/settings/support.dart';
import 'package:the_mirror/features/settings/support_article.dart';
import 'features/modules/module_store.dart';
import 'features/settings/dark_mode.dart';
import 'features/settings/settings.dart';
import 'features/views/onboarding.dart';
import 'features/biometric/biometric.dart';
import 'main.dart';
import 'features/login/password_reset.dart';
import 'features/scanner/password_scanner.dart';
import 'core/spotify_request.dart';
import 'features/sign_up/verify_email.dart';
import 'features/views/spotify_success.dart';
import 'features/auth/auth.dart';
import 'features/login/login.dart';
import 'features/sign_up/sign_up.dart';
import 'features/views/error.dart';
import 'features/home/home.dart';
import 'features/scanner/scanner.dart';

// Modules Packages
import 'features/modules/modules_list/clock_module.dart';
import 'features/modules/modules_list/calendar_module.dart';
import 'features/modules/modules_list/weather_module.dart';
import 'features/modules/modules_list/compliments_module.dart';
import 'features/modules/modules_list/news_module.dart';
import 'features/modules/modules_list/spotify_module.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Auth(),
            );
          })),
      GoRoute(
          path: '/onboarding',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: OnBoarding(),
            );
          })),
      GoRoute(
          path: '/biometric',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Biometric(),
            );
          })),
      GoRoute(
          path: '/home',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Home(),
            );
          })),
      GoRoute(
          path: '/auth',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Auth(),
            );
          }),
          routes: [
            GoRoute(
                path: 'login',
                pageBuilder: ((context, state) {
                  return const MaterialPage(
                    child: Login(),
                  );
                }),
                routes: [
                  GoRoute(
                      path: 'password_reset',
                      pageBuilder: ((context, state) {
                        return const MaterialPage(
                          child: PasswordReset(),
                        );
                      })),
                ]),
            GoRoute(
                path: 'register',
                pageBuilder: ((context, state) {
                  return const MaterialPage(
                    child: SignUp(),
                  );
                }),
                routes: [
                  GoRoute(
                      path: 'verify_email',
                      pageBuilder: ((context, state) {
                        return const MaterialPage(
                          child: VerifyEmail(),
                        );
                      })),
                ]),
          ]),
      GoRoute(
          path: '/scanner',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Scanner(),
            );
          })),
      GoRoute(
          path: '/password_scanner',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: PasswordToScanner(),
            );
          })),
      GoRoute(
        path: '/modules',
        pageBuilder: ((context, state) {
          return const MaterialPage(
            child: Home(),
          );
        }),
        routes: [
          GoRoute(
              path: 'module_store',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: ModuleStore(),
                );
              })),
          GoRoute(
              path: 'clock_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: ClockModule(),
                );
              })),
          GoRoute(
              path: 'weather_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: WeatherModule(),
                );
              })),
          GoRoute(
              path: 'news_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: NewsModule(),
                );
              })),
          GoRoute(
              path: 'compliments_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: ComplimentsModule(),
                );
              })),
          GoRoute(
              path: 'calendar_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: CalendarModule(),
                );
              })),
          GoRoute(
              path: 'spotify_module',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: SpotifyModule(),
                );
              })),
        ],
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: ((context, state) {
          return const MaterialPage(
            child: SettingPage(),
          );
        }),
        routes: [
          GoRoute(
              path: 'dark_mode',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: DarkMode(),
                );
              })),
          GoRoute(
              path: 'profile',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: Profile(),
                );
              }),
              routes: [
                GoRoute(
                    path: 'name',
                    pageBuilder: ((context, state) {
                      return const MaterialPage(
                        child: NameSettings(),
                      );
                    })),
                GoRoute(
                    path: 'password',
                    pageBuilder: ((context, state) {
                      return const MaterialPage(
                        child: PasswordSettings(),
                      );
                    })),
                GoRoute(
                    path: 'delete_account',
                    pageBuilder: ((context, state) {
                      return const MaterialPage(
                        child: DeleteSettings(),
                      );
                    })),
              ]),
          GoRoute(
              path: 'support',
              pageBuilder: ((context, state) {
                return const MaterialPage(
                  child: SupportSetting(),
                );
              }),
              routes: [
                GoRoute(
                  path: 'article',
                  pageBuilder: ((context, state) {
                    final articleNameQuery = state.queryParameters['articleName'];
                    final articleContentQuery = state.queryParameters['articleContent'];
                    final articleName = articleNameQuery.toString();
                    final articleContent = articleContentQuery.toString();
                    debugPrint('$articleName is the article name');
                    debugPrint('$articleContent is the article content');
                    return  MaterialPage(
                      child: SupportArticle(articleName: articleName, articleContent: articleContent),
                    );
                  }),
                )
              ]),
        ],
      ),
      GoRoute(
        path: '/callback',
        pageBuilder: (context, state) {
          final queryParams = state.queryParameters['code'];
          debugPrint('$queryParams is the code');
          final code = queryParams.toString();
          getRefreshToken(code);
          return const MaterialPage(
            child: SpotifySuccess(),
          );
        },
      ),
    ],
    initialLocation: initialLocation(),
  );
}

// initial location
String initialLocation() {
  if (getStarted) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (pinLock) {
        return '/biometric';
      } else {
        return '/home';
      }
    } else {
      return '/auth';
    }
  } else {
    return '/onboarding';
  }
}
