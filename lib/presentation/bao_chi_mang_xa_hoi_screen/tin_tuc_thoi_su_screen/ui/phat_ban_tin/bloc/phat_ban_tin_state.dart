import 'package:equatable/equatable.dart';

abstract class PhatBanTinState extends Equatable {
  const PhatBanTinState();
}

class PhatBanTinStateInitial extends PhatBanTinState {
  @override
  List<Object> get props => [];
}

class Loading extends PhatBanTinState {
  @override
  List<Object> get props => [];
}
