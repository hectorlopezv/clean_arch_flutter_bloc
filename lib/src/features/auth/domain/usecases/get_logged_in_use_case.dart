import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetLoggedInUser implements UseCase<LoggedInUser, GetLoggedInUserParams> {
  final AuthRepository authRepository;

  GetLoggedInUser(this.authRepository);

  @override
  Future<LoggedInUser> call(GetLoggedInUserParams params) {
    return authRepository.loggedInUser(params.username);
  }
}

class GetLoggedInUserParams extends Params {
  final String username;

  GetLoggedInUserParams({required this.username});

  @override
  List<Object?> get props => [];
}
