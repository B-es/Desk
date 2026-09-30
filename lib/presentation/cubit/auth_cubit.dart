import 'package:desk/repos/auth_repos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepos}) : super(AuthInitial());

  void init() {
    final isAuthed = authRepos.isAuth;

    emit(isAuthed ? Authed() : UnAuthed());
  }

  void toAuth() {
    emit(ToAuth());
  }

  void toMain() {
    emit(ToMain());
  }

  void signIn(final email, final password) {
    if (authRepos.signIn(email, password)) {
      emit(Authed());
    } else {
      emit(UnAuthed(msg: "Нет такого пользователя"));
    }
  }

  void signUp(final name, final email, final password) {
    if (authRepos.signUp(email, password, name)) {
      emit(Authed());
    } else {
      emit(UnAuthed(msg: "Регистрация не удалась"));
    }
  }

  void signOut() {
    authRepos.signOut();
    emit(UnAuthed(msg: "Вы вышли"));
  }

  final AuthRepos authRepos;
}
