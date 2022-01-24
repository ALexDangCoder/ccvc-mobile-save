import 'package:equatable/equatable.dart';

abstract class AddCadresState extends Equatable {
  const AddCadresState();
}

class MainStateInitial extends AddCadresState {
  @override
  List<Object> get props => [];
}

class Loading extends AddCadresState {
  @override
  List<Object> get props => [];
}
