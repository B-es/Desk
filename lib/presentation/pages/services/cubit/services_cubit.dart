import 'package:desk/model/service_model.dart';
import 'package:desk/model/type_model.dart';
import 'package:desk/repos/services_repos.dart';
import 'package:desk/repos/user_repos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit({required ServicesRepos repos, required UserRepos userRepos})
      : _repos = repos,
        _userRepos = userRepos,
        super(ServicesInitial());

  void loadServices() {
    if (!_userRepos.isAuth) {
      return emit(ServicesLoaded(models: _repos.models));
    }

    final models = _repos.models.where(
      (element) =>
          element.ownerId != _userRepos.current!.id &&
          element.orderedBy != _userRepos.current!.id,
    );
    emit(ServicesLoaded(models: models.toList()));
  }

  void filterServices(TypeEnum type) {
    if (!_userRepos.isAuth) {
      final models = _repos.models.where(
        (element) => element.type == type,
      );
      return emit(ServicesLoaded(models: models.toList()));
    }
    final models = _repos.models.where(
      (element) =>
          element.ownerId != _userRepos.current!.id &&
          element.orderedBy != _userRepos.current!.id &&
          element.type == type,
    );
    emit(FilteredServicesLoaded(models: models.toList()));
  }

  void setOrder(String id) {
    _repos.setOrder(id, _userRepos.current!.id);

    loadServices();
  }

  final ServicesRepos _repos;
  final UserRepos _userRepos;
}
