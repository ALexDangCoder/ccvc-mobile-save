import 'package:equatable/equatable.dart';

abstract class PickDateCupertinoState extends Equatable {
  const PickDateCupertinoState();
}

class PickDateCupertinoInitial extends PickDateCupertinoState {
  @override
  List<Object?> get props => [];
}

class Loading extends PickDateCupertinoState {
  @override
  List<Object> get props => [];
}
