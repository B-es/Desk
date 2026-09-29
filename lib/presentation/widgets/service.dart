import 'package:desk/const/type_models.dart';
import 'package:desk/model/service_model.dart';
import 'package:desk/presentation/cubit/auth_cubit.dart';
import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:desk/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart' hide Image, LinearGradient;

import '../pages/profile/cubit/profile_cubit.dart';

class Service extends StatelessWidget {
  const Service({super.key, required this.model});

  final ServiceModel model;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: model.description,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Stack(
          children: [
            Container(
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Opacity(
                  opacity: .2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/${typeModels.where((e) => e.type == model.type).first.imagePath}"),
                      ),
                    ),
                    child: createTile(context),
                  ),
                ),
              ),
            ),
            createTile(context),
          ],
        ),
      ),
    );
  }

  Widget createTile(BuildContext context) {
    return ListTile(
      title: Text(
        model.name,
        style: Theme.of(context).primaryTextTheme.titleMedium,
      ),
      subtitle: Text(
        model.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).primaryTextTheme.labelMedium,
      ),
      trailing: Text(
        "${model.cost} руб.",
        style: Theme.of(context).primaryTextTheme.titleMedium,
      ),
      onTap: () {
        onTap(context);
      },
    );
  }

  void onTap(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    if (!RepositoryProvider.of<UserRepos>(context).isAuth) {
      showModalBottomSheet(
          backgroundColor: Colors.black,
          context: context,
          clipBehavior: Clip.antiAlias,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          builder: (BuildContext context) {
            return GiffyBottomSheet.image(
              Image.asset(
                "assets/images/succes.gif",
                height: 200,
                fit: BoxFit.fitHeight,
              ),
              title: Text(
                'Не авторизованы',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .primaryTextTheme
                    .displayMedium
                    ?.copyWith(fontSize: 24),
              ),
              content: Text(
                'Вам нужно войти или зарегистрироваться',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'CANCEL');
                    authCubit.toAuth();
                  },
                  child: const Text('Регистрация/Войти'),
                ),
              ],
            );
          });
      return;
    }

    BlocProvider.of<ServicesCubit>(context).setOrder(model.id);
    BlocProvider.of<ProfileCubit>(context).loadLastServices();
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (BuildContext context) {
        return GiffyBottomSheet.image(
          Image.asset(
            "assets/images/succes.gif",
            height: 200,
            fit: BoxFit.fitHeight,
          ),
          title: Text(
            'Заказ принят',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .displayMedium
                ?.copyWith(fontSize: 24),
          ),
          content: Text(
            'Его можно увидеть в профиле',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
