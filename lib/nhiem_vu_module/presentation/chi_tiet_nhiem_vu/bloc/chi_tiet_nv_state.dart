import 'package:equatable/equatable.dart';

abstract class ChiTietNVState extends Equatable {
  const ChiTietNVState();
}

class ChiTietNVInitial extends ChiTietNVState {
  @override
  List<Object> get props => [];
}

class Loading extends ChiTietNVState {
  @override
  List<Object> get props => [];
}
