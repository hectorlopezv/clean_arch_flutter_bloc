import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class SignUpUser implements UseCase<void, SignUpUserParams> {
  final AuthRepository authRepository;

  SignUpUser(this.authRepository);

  @override
  call(SignUpUserParams params) {
    return authRepository.signup(
      loggedInUser: params.user,
    );
  }
}

class SignUpUserParams extends Params {
  final LoggedInUser user;

  SignUpUserParams({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
