import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get authStatus;

  Future<LoggedInUser> get loggedInUser;

  Future<void> signup({required LoggedInUser loggedInUser});

  Future<void> login({
    required Username username,
    required Password password,
  });

  Future<void> logout();
}
