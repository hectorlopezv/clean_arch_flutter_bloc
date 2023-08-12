part of 'login_cubit.dart';

enum LoginWithUsernameAndPasswordFailure {
  invalidUsernameAndPasswordCombination,
  serverError,
  loading,
  valid,
  invalid,
  success,
  initial,
  failure,
}

class LoginState extends Equatable {
  final Username username;
  final Password password;
  final LoginWithUsernameAndPasswordFailure status;
  final String? errorText;

  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = LoginWithUsernameAndPasswordFailure.initial,
    this.errorText,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [username, password, status, errorText];

  factory LoginState.initial() {
    return LoginState(
      username: const Username.pure(),
      password: const Password.pure(),
      status: LoginWithUsernameAndPasswordFailure.initial,
      errorText: null,
    );
  }

  LoginState copyWith({
    Username? username,
    Password? password,
    LoginWithUsernameAndPasswordFailure? status,
    String? errorText,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
