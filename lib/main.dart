import 'package:clean_arch_bloc/src/config/app_router.dart';
import 'package:clean_arch_bloc/src/config/app_theme.dart';
import 'package:clean_arch_bloc/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:clean_arch_bloc/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/get_auth_status_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/get_logged_in_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/login_user_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/logout_user_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/domain/usecases/signup_user_use_case.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            authDataSource: MockAuthDatSourceImpl(),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              getAuthStatus: GetStatusUser(
                context.read<AuthRepositoryImpl>(),
              ),
              getLoggedInUser: GetLoggedInUser(
                context.read<AuthRepositoryImpl>(),
              ),
              logoutUser: LogoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              loginUser: LoginUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              signUpUser: SignUpUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          )
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: CustomTheme().theme(),
              routerConfig: AppRouter(
                authBloc: context.read<AuthBloc>(),
              ).router,
            );
          },
        ),
      ),
    );
  }
}
