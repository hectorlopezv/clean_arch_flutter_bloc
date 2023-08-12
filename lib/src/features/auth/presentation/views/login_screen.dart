import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final String title;

  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("login")),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginWithUsernameAndPasswordFailure.success) {
            context.goNamed("feed");
            return;
          }
          if (state.status == LoginWithUsernameAndPasswordFailure.failure) {
            String? errorMessage = state.errorText;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage?.isNotEmpty == true
                    ? state.errorText!
                    : "Something went wrong"),
              ),
            );
            Future.delayed(Duration(milliseconds: 300), () {
              context.read<LoginCubit>().emit(state.copyWith(
                  status: LoginWithUsernameAndPasswordFailure.initial));
            });
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Spacer(flex: 2),
                _Username(),
                SizedBox(height: 10),
                _Password(),
                SizedBox(height: 10),
                _LoginButton(),
                Spacer(flex: 2),
                _LoginRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("signup");
      },
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Sign up",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginWithUsernameAndPasswordFailure.loading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (state.status ==
                      LoginWithUsernameAndPasswordFailure.valid) {
                    context.read<LoginCubit>().loginInWithCredentials();
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Check your credentials: $state.status"),
                    ),
                  );
                },
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50), backgroundColor: Colors.white),
              );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        print("state $state");
        print(state.password.value);
        return CustomTextField(
            errorText:
                state.password.isNotValid && state.password.value.isNotEmpty
                    ? "Invalid password"
                    : null,
            labelText: "Password",
            inputType: TextInputType.text,
            hintText: "Enter your password",
            obscureText: true,
            onChanged: (password) {
              context.read<LoginCubit>().passwordChanged(password);
            });
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        print("state $state");
        print(state.username.value);
        return CustomTextField(
            errorText:
                state.username.isNotValid && state.username.value.isNotEmpty
                    ? "Invalid username"
                    : null,
            labelText: "Username",
            inputType: TextInputType.name,
            hintText: "Enter your username",
            onChanged: (username) {
              context.read<LoginCubit>().usernameChanged(username);
            });
      },
    );
  }
}
