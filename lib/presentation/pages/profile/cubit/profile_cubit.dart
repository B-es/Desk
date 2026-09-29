import 'package:desk/model/service_model.dart';
import 'package:desk/repos/services_repos.dart';
import 'package:desk/repos/user_repos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ServicesRepos repos, required UserRepos userRepos})
      : _repos = repos,
        _userRepos = userRepos,
        super(ProfileInitial());

  void loadProfileServices() {
    if (!_userRepos.isAuth) {
      return emit(UnloggedProfileLoaded());
    }

    final models = _repos.models
        .where(
          (element) => element.ownerId == _userRepos.current?.id,
        )
        .toList();
    emit(ProfileLoaded(models: models));
    _last_index = 0;
  }

  void loadOrderedProfileServices() {
    if (!_userRepos.isAuth) {
      return emit(UnloggedProfileLoaded());
    }
    final models = _repos.models.where(
      (element) => element.orderedBy == _userRepos.current?.id,
    );
    emit(OrderedProfileLoaded(models: models.toList()));
    _last_index = 1;
  }

  void loadLastServices() {
    print(_last_index);
    if (_last_index == 0) {
      loadProfileServices();
    } else if (_last_index == 1) {
      loadOrderedProfileServices();
    }
  }

  final ServicesRepos _repos;
  final UserRepos _userRepos;
  int _last_index = 0;
}
