import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextField(
          cursorColor: Colors.black,
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: "Введите почту",
            icon: Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          cursorColor: Colors.black,
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: "Введите пароль",
            icon: Icon(Icons.password_outlined),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextButton.icon(
                  style: const ButtonStyle(
                      side: MaterialStatePropertyAll(
                          BorderSide(color: Colors.black))),
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    BlocProvider.of<AuthCubit>(context).signIn(email, password);
                  },
                  icon: const Icon(Icons.done_outline_outlined),
                  label: const Text("Войти")),
            ),
          ],
        ),
      ],
    );
  }
}
