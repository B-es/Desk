import 'package:desk/const/type_models.dart';
import 'package:desk/model/type_model.dart';
import 'package:desk/presentation/cubit/navbar_cubit.dart';
import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return TypeCard(model: typeModels[index]);
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}

class TypeCard extends StatelessWidget {
  const TypeCard({super.key, required this.model});

  final TypeModel model;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.black,
      onTap: () {
        BlocProvider.of<NavbarCubit>(context).changeIndex(1);
        BlocProvider.of<ServicesCubit>(context).filterServices(model.type);
      },
      child: Card(
        elevation: 20,
        shadowColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black,
              ),
            ),
            Opacity(
              opacity: .4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  "assets/images/${model.imagePath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              model.title,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
