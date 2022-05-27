import 'package:equatable/equatable.dart';

abstract class NhiemVuState extends Equatable {
  const NhiemVuState();
}

class NhiemVuStateIntial extends NhiemVuState {
  const NhiemVuStateIntial() : super();

  @override
  List<Object?> get props => [];
}

class NhiemVuCaNhan extends NhiemVuState {
  @override
  List<Object?> get props => [];
}

class NhiemVuDonVi extends NhiemVuState {
  @override
  List<Object?> get props => [];
}

class BaoCaoThongKe extends NhiemVuState {
  @override
  List<Object?> get props => [];
}
