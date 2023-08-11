import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/repositories/auth_repositorty.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';

class GetStatusUser implements UseCase<LoggedInUser, NoParams> {
  final AuthRepository authRepository;

  GetStatusUser(this.authRepository);

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.authStatus;
  }
}
