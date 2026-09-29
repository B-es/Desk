import 'package:desk/presentation/pages/services/cubit/services_cubit.dart';
import 'package:desk/presentation/widgets/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state is ServicesLoaded) {
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
              itemCount: state.models.length,
              itemBuilder: (context, i) => Service(model: state.models[i]));
        }
        if (state is FilteredServicesLoaded) {
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
              itemCount: state.models.length,
              itemBuilder: (context, i) => Service(model: state.models[i]));
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
