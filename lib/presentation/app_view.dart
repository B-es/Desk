import 'package:desk/presentation/cubit/auth_cubit.dart';
import 'package:desk/presentation/pages/auth/auth.dart';
import 'package:desk/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:desk/repos/auth_repos.dart';
import 'package:desk/repos/services_repos.dart';
import 'package:desk/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/navbar_cubit.dart';
import 'main_form.dart';

class AppView extends StatefulWidget {
  AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final ServicesRepos serviceRepos;

  late final UserRepos userRepos;

  late final AuthRepos authRepos;

  @override
  void initState() {
    serviceRepos = ServicesRepos();
    userRepos = UserRepos();
    authRepos = AuthRepos(userRepos: userRepos);
    super.initState();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Desk',
      theme: ThemeData(
        fontFamily: "M PLUS Rounded 1c",
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            // Focused Border
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            // Error Border
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            // Focused Error Border
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
            iconColor: Colors.black,
            focusColor: Colors.black,
            hoverColor: Colors.black,
            fillColor: Colors.black,
            activeIndicatorBorder: BorderSide(color: Colors.black)),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontSize: 20),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
            tileColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
        primaryTextTheme: const TextTheme(
            titleMedium: TextStyle(color: Colors.white, fontSize: 18),
            labelMedium: TextStyle(color: Colors.grey, fontSize: 14)),
        tooltipTheme: const TooltipThemeData(preferBelow: false),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => serviceRepos,
          ),
          RepositoryProvider(
            create: (_) => userRepos,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ServicesCubit(repos: serviceRepos, userRepos: userRepos)
                    ..loadServices(),
            ),
            BlocProvider(
              create: (context) =>
                  ProfileCubit(repos: serviceRepos, userRepos: userRepos)
                    ..loadProfileServices(),
            ),
            BlocProvider(create: (context) => NavbarCubit()),
            BlocProvider(create: (context) => AuthCubit(authRepos: authRepos))
          ],
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UnAuthed) {
                if (state.msg != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      backgroundColor: Colors.black,
                      content: Text(textAlign: TextAlign.center, state.msg!),
                    ),
                  );
                }
              }
              BlocProvider.of<ServicesCubit>(context).loadServices();
              BlocProvider.of<ProfileCubit>(context).loadLastServices();
            },
            builder: (context, state) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is ToMain) {
                    return const MainForm();
                  }
                  if (state is Authed) {
                    return const MainForm();
                  }
                  if (state is ToAuth) {
                    return const Auth();
                  }
                  return const MainForm();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
