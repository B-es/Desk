part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class UnAuthed extends AuthState {
  final String? msg;
  final String now = DateTime.timestamp().toString();
  UnAuthed({this.msg});
}

final class ToMain extends AuthState {}

final class ToAuth extends AuthState {}

final class Authed extends AuthState {}
