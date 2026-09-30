import 'package:desk/repos/user_repos.dart';

class AuthRepos {
  final UserRepos userRepos;

  AuthRepos({required this.userRepos});

  bool _isLogin = false;

  bool get isAuth => _isLogin;

  bool signIn(final String email, final String password) {
    final user = userRepos.getUser(email, password);
    _isLogin = user != null;
    userRepos.current = user;
    return _isLogin;
  }

  bool signUp(final String email, final String password, final String name) {
    userRepos.addUser(email, password, name);
    final user = userRepos.getUser(email, password);
    _isLogin = user != null;
    userRepos.current = user;
    return _isLogin;
  }

  void signOut() {
    _isLogin = false;
    userRepos.current = null;
  }
}
