import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser _loginUser;

  LoginCubit({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(LoginState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password])
            ? LoginWithUsernameAndPasswordFailure.valid
            : LoginWithUsernameAndPasswordFailure.invalid,
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.username,
          password,
        ])
            ? LoginWithUsernameAndPasswordFailure.valid
            : LoginWithUsernameAndPasswordFailure.invalid,
      ),
    );
  }

  Future<void> loginInWithCredentials() async {
    if (state.status == LoginWithUsernameAndPasswordFailure.valid) {
      emit(state.copyWith(status: LoginWithUsernameAndPasswordFailure.loading));

      try {
        await _loginUser(
          LoginUserParams(
            username: state.username,
            password: state.password,
          ),
        );
        emit(state.copyWith(
            status: LoginWithUsernameAndPasswordFailure.success));
      } on LoginWithUsernameAndPasswordFailureEx catch (e) {
        print("aca1");
        print(e);
        print(e.toString());
        emit(
          state.copyWith(
            status: LoginWithUsernameAndPasswordFailure.failure,
            errorText: e.toString(),
          ),
        );
      } catch (e) {
        print("aca2");
        print(e);
        print(e.toString());
        emit(
          state.copyWith(status: LoginWithUsernameAndPasswordFailure.failure),
        );
      }
    }
  }
}
