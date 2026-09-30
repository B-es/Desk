import 'package:desk/const/user_models.dart';
import 'package:desk/model/user_model.dart';

class UserRepos {
  UserModel? _model;

  void signOut() {
    _model = null;
  }

  UserModel? getUser(final email, final password) {
    try {
      return userModels.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  void addUser(final email, final password, final name) {
    return userModels.add(UserModel(
      id: (userModels.length + 1).toString(),
      name: name,
      password: password,
      email: email,
    ));
  }

  set current(UserModel? user) {
    _model = user;
  }

  bool get isAuth => _model != null;

  UserModel? get current => _model;
}
