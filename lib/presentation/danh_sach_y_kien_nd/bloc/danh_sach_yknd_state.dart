import 'package:equatable/equatable.dart';

abstract class DanhSachYKienNguoiDanState extends Equatable {
  const DanhSachYKienNguoiDanState();
}

class DanhSachYKienNguoiDanStateInitial extends DanhSachYKienNguoiDanState {
  @override
  List<Object> get props => [];
}

class Loading extends DanhSachYKienNguoiDanState {
  @override
  List<Object> get props => [];
}
