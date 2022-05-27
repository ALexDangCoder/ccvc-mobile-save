import 'package:equatable/equatable.dart';

abstract class ThongBaoState extends Equatable {
  const ThongBaoState();
}

class ThongBaoStateInitial extends ThongBaoState {
  @override
  List<Object> get props => [];
}

class Loading extends ThongBaoState {
  @override
  List<Object> get props => [];
}
