import 'package:equatable/equatable.dart';

abstract class ChooseTimeState extends Equatable {
  const ChooseTimeState();
}

class ChooseTimeInitial extends ChooseTimeState {
  @override
  List<Object> get props => [];
}

class Loading extends ChooseTimeState {
  @override
  List<Object> get props => [];
}
