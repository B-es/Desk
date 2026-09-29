import 'package:desk/presentation/cubit/auth_cubit.dart';
import 'package:desk/presentation/pages/auth/login.dart';
import 'package:desk/presentation/pages/auth/reg.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Auth extends StatefulWidget {
  const Auth({
    super.key,
  });

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Desk"),
          centerTitle: true,
          bottom: TabBar(
            dividerColor: Colors.black,
            labelColor: Colors.grey,
            indicatorColor: Colors.black,
            onTap: (value) {},
            tabs: const [
              Tab(
                text: "Войти",
              ),
              Tab(text: "Зарегестрироваться"),
            ],
          ),
        ),
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: const TabBarView(
                  children: [Login(), Reg()],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 130),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(
                                  BorderSide(color: Colors.black))),
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).toMain();
                          },
                          icon: const Icon(Icons.done_outline_outlined),
                          label: const Text("На главную страницу")),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
