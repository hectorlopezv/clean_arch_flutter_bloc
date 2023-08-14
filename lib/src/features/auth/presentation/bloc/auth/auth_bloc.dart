import 'dart:async';

import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/get_auth_status_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/get_logged_in_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/logout_user_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_bloc/src/shared/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final GetLoggedInUser _getLoggedInUser;
  final GetStatusUser _getAuthStatus;
  late StreamSubscription<AuthStatus> _authStatusSubscription;
  final LoginCubit _loginCubit;

  AuthBloc({
    required LogoutUser logoutUser,
    required GetLoggedInUser getLoggedInUser,
    required GetStatusUser getAuthStatus,
    required LoginCubit loginCubit,
  })  : _logoutUser = logoutUser,
        _getLoggedInUser = getLoggedInUser,
        _getAuthStatus = getAuthStatus,
        _loginCubit = loginCubit,
        super(const AuthState.unknown()) {
    on<AuthLogoutUser>(_onAuthLogoutUser);
    on<AuthGetStatus>(_onAuthGetStatus);
    _authStatusSubscription = _getAuthStatus(NoParams()).listen(
      (status) {
        print("subs");
        print("cambio el auth status");
        print("status $status");
        add(AuthGetStatus(status));
      },
    );
  }

  Future<void> _onAuthGetStatus(
      AuthGetStatus event, Emitter<AuthState> emit) async {
    debugPrint("Get AuthGetStatus: ${event.status}");
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());

      case AuthStatus.authenticated:
        final user = await _getLoggedInUser(
          GetLoggedInUserParams(
            username: _loginCubit.state.username.value,
          ),
        );
        print("el usuario logeado");
        print(user);
        return emit(
          AuthState.authenticated(user: user),
        );

      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutUser(AuthLogoutUser event, Emitter<AuthState> emit) async {
    debugPrint("Start user logout with _onAuthLogoutUser");

    await _logoutUser(NoParams());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
