import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:equatable/equatable.dart';

abstract class TaoLichLamViecState extends BaseState {
  const TaoLichLamViecState();
}

class TaoLichLVStateInitial extends TaoLichLamViecState {
  @override
  List<Object?> get props => [];
}

class Loading extends TaoLichLamViecState {
  @override
  List<Object> get props => [];
}

class CreateSuccess extends TaoLichLamViecState {
  @override
  List<Object> get props => [];
}
