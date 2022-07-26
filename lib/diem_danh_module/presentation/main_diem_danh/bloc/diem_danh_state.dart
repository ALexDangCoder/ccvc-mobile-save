import 'package:equatable/equatable.dart';

abstract class DiemDanhState extends Equatable {
  const DiemDanhState();
}

class DiemDanhStateIntial extends DiemDanhState {
  const DiemDanhStateIntial() : super();

  @override
  List<Object?> get props => [];
}

class DiemDanhCaNhan extends DiemDanhState {
  @override
  List<Object?> get props => [];
}

class DiemDanhKhuonMat extends DiemDanhState {
  @override
  List<Object?> get props => [];
}

class ApiSuccess extends DiemDanhState {
  @override
  List<Object?> get props => [];
}
