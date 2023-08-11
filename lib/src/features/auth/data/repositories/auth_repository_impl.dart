import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

class AuthRepositoryImpl extends AuthRepository {
  final MockAuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  // TODO: implement authStatus
  Stream<AuthStatus> get authStatus => authDataSource.authStatus;

  @override
  // TODO: implement loggedInUser
  Future<LoggedInUser> get loggedInUser => authDataSource.loggedInUser;

  @override
  Future<void> login({required Username username, required Password password}) {
    return authDataSource.login(username: username, password: password);
  }

  @override
  Future<void> logout() {
    return authDataSource.logout();
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return authDataSource.signup(loggedInUser: loggedInUser);
  }
}
