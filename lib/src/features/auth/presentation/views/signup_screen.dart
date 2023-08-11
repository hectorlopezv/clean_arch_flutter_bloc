import 'package:clean_arch_bloc/src/shared/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
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
    return ElevatedButton(
      onPressed: () {},
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
  }
}

class _Password extends StatelessWidget {
  const _Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "Password",
      inputType: TextInputType.name,
      hintText: "Enter your password",
      obscureText: true,
    );
  }
}

class _Email extends StatelessWidget {
  const _Email({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "Email",
      inputType: TextInputType.emailAddress,
      hintText: "Enter your email",
      obscureText: true,
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: "Username",
      inputType: TextInputType.name,
      hintText: "Enter your username",
    );
  }
}
