import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

class AuthRepositoryImpl extends AuthRepository {
  final MockAuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Stream<AuthStatus> get authStatus => authDataSource.authStatus;

  @override
  Future<void> login(
      {required Username username, required Password password}) async {
    print("username: $username, password: $password");
    return await authDataSource.login(username: username, password: password);
  }

  @override
  Future<void> logout() {
    return authDataSource.logout();
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) async {
    return await authDataSource.signup(loggedInUser: loggedInUser);
  }

  @override
  Future<LoggedInUser> loggedInUser(String username) {
    return authDataSource.loggedInUser(username);
  }
}
