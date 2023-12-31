import 'dart:async';

import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

abstract class MockAuthDataSource {
  Stream<AuthStatus> get authStatus;

  Future<LoggedInUser> loggedInUser(String username);

  Future<void> signup({required LoggedInUser loggedInUser});

  Future<void> login({
    required Username username,
    required Password password,
  });

  Future<void> logout();
}

class MockAuthDatSourceImpl extends MockAuthDataSource {
  final CacheClient _cache;

  MockAuthDatSourceImpl({CacheClient? cache}) : _cache = cache ?? CacheClient();
  final _controller = StreamController<AuthStatus>();

  static const userCacheKey = "__user_cache_key";

  void _updateLoggedInUser({
    String? id,
    Username? username,
    Email? email,
  }) {
    LoggedInUser loggedInUser =
        _cache.read(key: userCacheKey) ?? LoggedInUser.empty;
    _cache.write(
      key: userCacheKey,
      value: loggedInUser.copyWith(
        id: id,
        username: username,
        email: email,
      ),
    );
  }

  @override
  Stream<AuthStatus> get authStatus async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<LoggedInUser> loggedInUser(String username) async {
    print("username aqui 2: $username");
    await Future.delayed(Duration(milliseconds: 300), () {});
    User user =
        _allUsers.where((user) => user.username.value == username).first;
    return _cache.read(key: userCacheKey) ??
        LoggedInUser.empty.copyWith(
          username: Username.dirty(username),
          id: user.id,
          imagePath: user.imagePath,
        );
  }

  @override
  Future<void> login(
      {required Username username, required Password password}) async {
    return Future.delayed(
      Duration(milliseconds: 300),
      () {
        print("entre");
        for (final user in _allUsers) {
          if (user.username.value == username.value) {
            _controller.add(AuthStatus.authenticated);
            return;
          }
        }
        print("imprime aca");
        throw LoginWithUsernameAndPasswordFailureEx('user-not-found');
      },
    );
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return Future.delayed(Duration(milliseconds: 300), () {
      _allUsers.add(loggedInUser);
      _updateLoggedInUser(
        id: loggedInUser.id,
        username: loggedInUser.username,
        email: loggedInUser.email,
      );

      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(Duration(milliseconds: 300), () {
      _cache.write(key: userCacheKey, value: LoggedInUser.empty);
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  List<User> _allUsers = <User>[
    User(
      id: 'user_1',
      username: Username.dirty("user_1"),
      imagePath: 'assets/images/image_1.jpg',
    ),
    User(
      id: 'user_2',
      username: Username.dirty("user_2"),
      imagePath: 'assets/images/image_2.jpg',
    ),
    User(
      id: 'user_3',
      username: Username.dirty("user_3"),
      imagePath: 'assets/images/image_3.jpg',
    ),
  ];
}

// local data source
class CacheClient {
  CacheClient() : _cache = <String, Object>{};
  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    return _cache[key] as T?;
  }
}

class LoginWithUsernameAndPasswordFailureEx implements Exception {
  const LoginWithUsernameAndPasswordFailureEx(this.message);

  final String message;

  factory LoginWithUsernameAndPasswordFailureEx.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginWithUsernameAndPasswordFailureEx('user-not-found');
      case 'wrong-password':
        return const LoginWithUsernameAndPasswordFailureEx('wrong-password');
      case 'invalid-username':
        return const LoginWithUsernameAndPasswordFailureEx('invalid-username');
      default:
        return const LoginWithUsernameAndPasswordFailureEx('unknown');
    }
  }
}
