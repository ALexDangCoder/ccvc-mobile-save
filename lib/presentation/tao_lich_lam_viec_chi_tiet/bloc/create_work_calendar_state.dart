import 'package:ccvc_mobile/config/base/base_state.dart';

abstract class CreateWorkCalState extends BaseState {
  const CreateWorkCalState();
}

class TaoLichLVStateInitial extends CreateWorkCalState {
  @override
  List<Object?> get props => [];
}

class Loading extends CreateWorkCalState {
  @override
  List<Object> get props => [];
}

class CreateSuccess extends CreateWorkCalState {
  @override
  List<Object> get props => [];
}
