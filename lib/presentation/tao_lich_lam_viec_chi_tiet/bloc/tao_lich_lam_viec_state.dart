import 'package:equatable/equatable.dart';

abstract class TaoLichLamViecState extends Equatable {
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
