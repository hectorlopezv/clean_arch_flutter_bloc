import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class LoginUser implements UseCase<void, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  @override
  call(LoginUserParams params) {
    return authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUserParams extends Params {
  final Username username;
  final Password password;

  LoginUserParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
