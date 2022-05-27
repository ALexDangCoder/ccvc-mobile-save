import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:equatable/equatable.dart';

abstract class CalenderState extends Equatable {
  const CalenderState(this.type);

  final Type_Choose_Option_Day type;
}

class CalenderStateIntial extends CalenderState {
  const CalenderStateIntial() : super(Type_Choose_Option_Day.DAY);

  @override
  List<Object?> get props => [];
}

class LichLVStateDangLich extends CalenderState {
  const LichLVStateDangLich(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}

class LichLVStateDangList extends CalenderState {
  const LichLVStateDangList(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}

class LichLVStateDangDanhSach extends CalenderState {
  const LichLVStateDangDanhSach(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}

class LichHopStateDay extends CalenderState {
  const LichHopStateDay(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}

class LichHopStateWeek extends CalenderState {
  const LichHopStateWeek(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}

class LichHopStateMonth extends CalenderState {
  const LichHopStateMonth(Type_Choose_Option_Day type) : super(type);

  @override
  List<Object?> get props => [type];
}
