import 'dart:async';

import 'package:clean_arch_bloc/src/features/auth/presentation/views/login_screen.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/views/signup_screen.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/discover_screen.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: "feed",
        path: "/login",
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: FeedScreen(title: "Feed"),
          );
        },
      ),
      GoRoute(
        name: "discover",
        path: "/discover",
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: DiscoverScreen(title: "Discover"),
          );
        },
        routes: [
          GoRoute(
              path: ":userId",
              name: "user",
              builder: (BuildContext context, GoRouterState state) {
                return const Scaffold(
                  body: Center(
                    child: Text("User"),
                  ),
                );
              }),
        ],
      ),
      GoRoute(
        path: "/",
        name: "login",
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: LoginScreen(title: "login"),
          );
        },
        routes: [
          GoRoute(
            path: "signup",
            name: "signup",
            builder: (BuildContext context, GoRouterState state) {
              return const Scaffold(
                body: SignUpScreen(
                  title: "SignuP",
                ),
              );
            },
          ),
        ],
      ),
    ],

    //redirect user to logo screen if not logged in
    //authenticated: go to feed screen
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
