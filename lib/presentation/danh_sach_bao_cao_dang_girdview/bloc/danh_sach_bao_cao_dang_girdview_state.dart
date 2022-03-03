import 'package:equatable/equatable.dart';

abstract class DanhSachBaoCaoState extends Equatable {
  const DanhSachBaoCaoState();
}

class DanhSachBaoCaoInitial extends DanhSachBaoCaoState {
  @override
  List<Object> get props => [];
}

class Loading extends DanhSachBaoCaoState {
  @override
  List<Object> get props => [];
}
