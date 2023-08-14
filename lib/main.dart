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
import 'package:clean_arch_bloc/src/features/content/domain/usecases/create_post.dart';
import 'package:clean_arch_bloc/src/features/content/presentation/blocs/add_content/add_content_bloc.dart';
import 'package:clean_arch_bloc/src/features/feed/data/datasources/local_feed_data_source.dart';
import 'package:clean_arch_bloc/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:clean_arch_bloc/src/features/feed/data/repository/post_repository_impl.dart';
import 'package:clean_arch_bloc/src/features/feed/data/repository/user_repository_impl.dart';
import 'package:clean_arch_bloc/src/shared/data/models/post_model.dart';
import 'package:clean_arch_bloc/src/shared/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
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
        ),
        RepositoryProvider(
          create: (context) => PostRepositoryImpl(
            MockFeedDataSourceImpl(),
            LocalFeedDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepositoryImpl(
            mockFeedDataSource: MockFeedDataSourceImpl(),
          ),
        ),
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
            create: (context) => AddContentCubit(
              createPost: CreatePost(
                postRepository: context.read<PostRepositoryImpl>(),
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
          ),
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
