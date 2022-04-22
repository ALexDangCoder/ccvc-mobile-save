import 'package:equatable/equatable.dart';

abstract class YKienNguoiDanState extends Equatable {
  const YKienNguoiDanState();
}

class YKienNguoiDanStateInitial extends YKienNguoiDanState {
  @override
  List<Object> get props => [];
}

class Loading extends YKienNguoiDanState {
  @override
  List<Object> get props => [];
}
class ThongTinChung extends YKienNguoiDanState {
  @override
  List<Object?> get props => [];
}

class BaoCaoThongKe extends YKienNguoiDanState {
  @override
  List<Object?> get props => [];
}

