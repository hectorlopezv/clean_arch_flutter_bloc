import 'package:bloc/bloc.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/signup_user_use_case.dart';
import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUser _signUpUser;

  SignUpCubit({
    required SignUpUser signUpUser,
  })  : _signUpUser = signUpUser,
        super(SignUpState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password, state.email])
            ? SignUpStatus.valid
            : SignUpStatus.invalid,
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
          state.email,
          password,
        ])
            ? SignUpStatus.valid
            : SignUpStatus.invalid,
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          state.username,
          state.password,
          email,
        ])
            ? SignUpStatus.valid
            : SignUpStatus.invalid,
      ),
    );
  }

  Future<void> signUpWithCredentials() async {
    if (state.status == SignUpStatus.valid) {
      emit(state.copyWith(status: SignUpStatus.loading));
      try {
        _signUpUser(
          SignUpUserParams(
            user: LoggedInUser(
              id: "user_00",
              email: state.email,
              username: state.username,
              imagePath: "assets/images/image_1.jpg",
            ),
          ),
        );
        emit(state.copyWith(status: SignUpStatus.success));
      } catch (e) {
        emit(
          state.copyWith(status: SignUpStatus.failure),
        );
      }
    }
  }
}
