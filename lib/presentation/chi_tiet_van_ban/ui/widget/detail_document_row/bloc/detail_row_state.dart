import 'package:equatable/equatable.dart';

abstract class DetailRowState extends Equatable {
  const DetailRowState();
}

class DetailRowInitial extends DetailRowState {
  @override
  List<Object> get props => [];
}

class Loading extends DetailRowState {
  @override
  List<Object> get props => [];
}
