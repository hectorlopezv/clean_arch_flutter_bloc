import 'package:clean_arch_bloc/src/features/auth/presentation/bloc/signup/signup_cubit.dart';
import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  final String title;

  const SignUpScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("SignUp"),
        ),
      ),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status == SignUpStatus.success) {
            context.goNamed("login");
            return;
          }
          if (state.status == SignUpStatus.failure) {
            String? errorMessage = state.errorText;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage?.isNotEmpty == true
                    ? state.errorText!
                    : "Something went wrong"),
              ),
            );
            Future.delayed(Duration(milliseconds: 300), () {
              context
                  .read<SignUpCubit>()
                  .emit(state.copyWith(status: SignUpStatus.initial));
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
                _Email(),
                SizedBox(height: 10),
                _SignUpButton(),
                Spacer(flex: 2),
                _SignUpRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpRedirect extends StatelessWidget {
  const _SignUpRedirect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("login");
      },
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Login",
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignUpStatus.loading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  await context.read<SignUpCubit>().signUpWithCredentials();
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          labelText: "Password",
          inputType: TextInputType.name,
          errorText:
              state.password.isNotValid && state.password.value.isNotEmpty
                  ? "Invalid password"
                  : null,
          hintText: "Enter your password",
          obscureText: true,
          onChanged: (password) {
            context.read<SignUpCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          labelText: "Email",
          inputType: TextInputType.emailAddress,
          errorText: state.email.isNotValid && state.email.value.isNotEmpty
              ? "Invalid email"
              : null,
          hintText: "Enter your email",
          obscureText: true,
          onChanged: (email) {
            context.read<SignUpCubit>().emailChanged(email);
          },
        );
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextField(
          labelText: "Username",
          inputType: TextInputType.name,
          hintText: "Enter your username",
          errorText:
              state.username.isNotValid && state.username.value.isNotEmpty
                  ? "Invalid username"
                  : null,
          onChanged: (username) {
            context.read<SignUpCubit>().usernameChanged(username);
          },
        );
      },
    );
  }
}
