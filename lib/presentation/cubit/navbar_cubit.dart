import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarCubit extends Cubit<int> {
  NavbarCubit() : super(0);

  void changeIndex(final int value) {
    _selectedIndex = value;
    emit(_selectedIndex);
  }

  int _selectedIndex = 0;
}
