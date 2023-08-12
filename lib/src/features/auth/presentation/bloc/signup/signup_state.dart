part of 'signup_cubit.dart';

enum SignUpStatus {
  invalidUsernameAndPasswordCombination,
  serverError,
  loading,
  valid,
  invalid,
  success,
  initial,
  failure,
}

class SignUpState extends Equatable {
  final Username username;
  final Password password;
  final Email email;
  final SignUpStatus status;
  final String? errorText;

  const SignUpState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.status = SignUpStatus.initial,
    this.errorText,
  });

  factory SignUpState.initial() {
    return SignUpState(
      username: const Username.pure(),
      password: const Password.pure(),
      status: SignUpStatus.initial,
      errorText: null,
    );
  }

  SignUpState copyWith({
    Username? username,
    Password? password,
    Email? email,
    SignUpStatus? status,
    String? errorText,
  }) {
    return SignUpState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      email: email ?? this.email,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [username, password, status, errorText];
}
