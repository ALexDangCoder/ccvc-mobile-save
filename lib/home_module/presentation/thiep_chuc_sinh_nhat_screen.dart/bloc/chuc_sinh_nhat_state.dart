import 'package:equatable/equatable.dart';

abstract class ChucSinhNhatState extends Equatable {
  const ChucSinhNhatState();
}

class MainStateInitial extends ChucSinhNhatState {
  @override
  List<Object> get props => [];
}

class Loading extends ChucSinhNhatState {
  @override
  List<Object> get props => [];
}

class Succeeded extends ChucSinhNhatState {
  @override
  List<Object> get props => [];
}
