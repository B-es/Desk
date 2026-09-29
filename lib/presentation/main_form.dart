import 'package:desk/presentation/pages/profile/profile.dart';
import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/navbar_cubit.dart';
import 'pages/main/main.dart';
import 'pages/services/services.dart';

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  final List<Widget> _pages = [const Main(), Services(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Desk"),
          centerTitle: true,
        ),
        extendBody: true,
        body: IndexedStack(
          index: state,
          children: _pages,
        ),
        bottomNavigationBar: FloatingNavbar(
          iconSize: 18,
          fontSize: 10,
          margin: EdgeInsets.zero,
          onTap: (int val) {
            BlocProvider.of<NavbarCubit>(context).changeIndex(val);
            switch (val) {
              case 1:
                BlocProvider.of<ServicesCubit>(context).loadServices();
            }
          },
          currentIndex: state,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: "Главная страница"),
            FloatingNavbarItem(
                icon: Icons.align_horizontal_right_rounded,
                title: "Просмотр услуг"),
            FloatingNavbarItem(icon: Icons.account_circle, title: "Профиль")
          ],
        ),
      );
    });
  }
}
