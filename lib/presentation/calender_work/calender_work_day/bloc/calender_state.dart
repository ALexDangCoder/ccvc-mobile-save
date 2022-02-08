import 'package:equatable/equatable.dart';

abstract class CalenderState extends Equatable {
  const CalenderState();
}

class CalenderStateIntial extends CalenderState {
  @override
  List<Object?> get props => [];
}
