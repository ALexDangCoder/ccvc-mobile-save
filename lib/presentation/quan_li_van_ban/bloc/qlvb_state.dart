import 'package:equatable/equatable.dart';

abstract class QLVBState extends Equatable {
  const QLVBState();
}

class QLVbStateInitial extends QLVBState {
  @override
  List<Object> get props => [];
}

class Loading extends QLVBState {
  @override
  List<Object> get props => [];
}

class ThongTinVanBan extends QLVBState {
  @override
  List<Object?> get props => [];
}

class BaoCaoThongKe extends QLVBState {
  @override
  List<Object?> get props => [];
}
