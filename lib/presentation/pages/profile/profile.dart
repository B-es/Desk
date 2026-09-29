import 'dart:ui';

import 'package:desk/model/user_model.dart';
import 'package:desk/presentation/cubit/auth_cubit.dart';
import 'package:desk/presentation/pages/profile/add_service.dart';
import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:desk/presentation/widgets/profile_service.dart';
import 'package:desk/presentation/widgets/user_service.dart';
import 'package:desk/repos/services_repos.dart';
import 'package:desk/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TabBar(
                    dividerColor: Colors.black,
                    labelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    onTap: (value) {
                      switch (value) {
                        case 0:
                          BlocProvider.of<ProfileCubit>(context)
                              .loadProfileServices();
                        case 1:
                          BlocProvider.of<ProfileCubit>(context)
                              .loadOrderedProfileServices();
                      }
                    },
                    tabs: const [
                      Tab(
                        text: "Мои услуги",
                      ),
                      Tab(text: "Заказанные услуги"),
                    ],
                  ),
                ),
                Expanded(
                  //height: 350,
                  child: TabBarView(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          print(state);
                          if (state is UnloggedProfileLoaded) {
                            return Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              "Нужно войти в аккаунт",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium
                                  ?.copyWith(color: Colors.black),
                            ));
                          }
                          if (state is ProfileLoaded) {
                            if (state.models.isEmpty) {
                              return Center(
                                  child: Text(
                                "Нет услуг",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displayMedium
                                    ?.copyWith(color: Colors.black),
                              ));
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.models.length,
                                itemBuilder: (context, i) =>
                                    UserService(model: state.models[i]));
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is UnloggedProfileLoaded) {
                            return Center(
                                child: Text(
                              textAlign: TextAlign.center,
                              "Нужно войти в аккаунт",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium
                                  ?.copyWith(color: Colors.black),
                            ));
                          }
                          if (state is OrderedProfileLoaded) {
                            if (state.models.isEmpty) {
                              return Center(
                                  child: Text(
                                "Нет услуг",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displayMedium
                                    ?.copyWith(color: Colors.black),
                              ));
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.models.length,
                                itemBuilder: (context, i) =>
                                    ProfileService(model: state.models[i]));
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 130),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is Authed) {
                          return AccountInfo(
                            model: RepositoryProvider.of<UserRepos>(context)
                                .current!,
                          );
                        }
                        return const AccountInfoUnlogged();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoUnlogged extends StatelessWidget {
  const AccountInfoUnlogged({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.25), BlendMode.dstATop),
          image: const AssetImage("assets/images/profile_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: TextButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).toAuth();
              },
              child: const Text("Войти"),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key, required this.model});

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .primaryTextTheme
        .displayMedium
        ?.copyWith(fontSize: 18);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.25), BlendMode.dstATop),
          image: const AssetImage("assets/images/profile_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model.name, style: textStyle),
              Text(
                model.email,
                style: textStyle,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 120,
                  child: TextButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => AddService(
                                action: (
                                  final name,
                                  final description,
                                  final cost,
                                  final type,
                                ) {
                                  final ownerId =
                                      RepositoryProvider.of<UserRepos>(context)
                                          .current!
                                          .id;
                                  RepositoryProvider.of<ServicesRepos>(context)
                                      .add(name, description, cost, type,
                                          ownerId);
                                  BlocProvider.of<ProfileCubit>(context)
                                      .loadProfileServices();
                                },
                              ),
                            ),
                          ),
                      child: const Text("Создать"))),
              SizedBox(
                  width: 120,
                  child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).signOut();
                        BlocProvider.of<ProfileCubit>(context)
                          ..loadProfileServices()
                          ..loadOrderedProfileServices();
                        BlocProvider.of<ServicesCubit>(context).loadServices();
                      },
                      child: const Text("Выйти"))),
            ],
          )
        ],
      ),
    );
  }
}
