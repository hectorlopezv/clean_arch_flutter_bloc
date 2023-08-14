import 'dart:async';

import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/views/login_screen.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/views/signup_screen.dart';
import 'package:clean_arch_bloc/src/features/feed/data/repository/post_repository_impl.dart';
import 'package:clean_arch_bloc/src/features/feed/data/repository/user_repository_impl.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/use_cases/get_posts.dart';
import 'package:clean_arch_bloc/src/features/feed/domain/use_cases/get_users.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/blocs/discover/discover_bloc.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/blocs/feed/feed_bloc.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/views/discover_screen.dart';
import 'package:clean_arch_bloc/src/features/feed/presentation/views/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: "feed",
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) =>
            FeedBloc(
              getPosts: GetPosts(
                context.read<PostRepositoryImpl>(),
              ),
            )
              ..add(
                FeedGetsPosts(),
              ),
            child: const FeedScreen(),
          );
        },
      ),
      GoRoute(
        name: "discover",
        path: "/discover",
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) =>
            DiscoverBloc(
              getUsers: GetUsers(
                context.read<UserRepositoryImpl>(),
              ),

            )
              ..add(
                DiscoverGetUsers(),
              ),
            child: const DiscoverScreen(),
          );
        },
        routes: [
          GoRoute(
              path: ":userId",
              name: "user",
              builder: (BuildContext context, GoRouterState state) {
                return DiscoverScreen();
              }),
        ],
      ),
      GoRoute(
        path: "/login",
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
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation("login");
      final feedLocation = state.namedLocation("feed");
      final discoverLocation = state.namedLocation("discover");
      final signUpLocation = state.namedLocation("signup");

      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;

      if (!isLoggedIn && state.fullPath == signUpLocation) {
        return signUpLocation;
      }
      if (!isLoggedIn && state.fullPath == loginLocation) {
        return loginLocation;
      }
      if (!isLoggedIn) {
        return loginLocation;
      }
      if (discoverLocation != null && state.fullPath == discoverLocation) {
        return discoverLocation;
      }
      return feedLocation;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
