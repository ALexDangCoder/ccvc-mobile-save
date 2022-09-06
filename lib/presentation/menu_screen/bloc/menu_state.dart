import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class MainStateInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class Loading extends MenuState {
  @override
  List<Object> get props => [];
}

class ChuyenPhamViSucsess extends MenuState {
  final String token;

  const ChuyenPhamViSucsess(this.token);

  @override
  List<Object> get props => [token];
}
