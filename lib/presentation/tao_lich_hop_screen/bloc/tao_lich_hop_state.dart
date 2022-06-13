import 'package:equatable/equatable.dart';

abstract class TaoLichHopState extends Equatable {
  const TaoLichHopState();
}

class MainStateInitial extends TaoLichHopState {
  @override
  List<Object> get props => [];
}

class Loading extends TaoLichHopState {
  @override
  List<Object> get props => [];
}
class LichTrung extends TaoLichHopState {
  @override
  List<Object> get props => [];
}

