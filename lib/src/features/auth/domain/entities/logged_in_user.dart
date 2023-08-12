import 'package:clean_arch_bloc/src/shared/domain/entities/user/user_entity.dart';
import 'package:formz/formz.dart';

class LoggedInUser extends User {
  final Email? email;

  const LoggedInUser({
    required super.id,
    required super.username,
    super.imagePath,
    super.followers,
    super.following,
    this.email,
  });

  static const empty =
      LoggedInUser(id: "", username: Username.pure(), email: Email.pure());

  @override
  List<Object?> get props =>
      [id, username, followers, following, imagePath, email];

  LoggedInUser copyWith({
    String? id,
    Username? username,
    int? followers,
    int? following,
    String? imagePath,
    Email? email,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      username: username ?? this.username,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      imagePath: imagePath ?? this.imagePath,
      email: email ?? this.email,
    );
  }
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegex = RegExp(
    r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  static final RegExp _passwordRegex = RegExp(
    r'^[0-9]*$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegex.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
