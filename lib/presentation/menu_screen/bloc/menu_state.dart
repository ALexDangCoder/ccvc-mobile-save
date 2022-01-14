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
