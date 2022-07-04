part of 'chi_tiet_ho_tro_cubit.dart';

@immutable
abstract class ChiTietHoTroState extends Equatable{}

class ChiTietHoTroInitial extends ChiTietHoTroState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChiTietHoTroLoading extends ChiTietHoTroState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChiTietHoTroSuccess extends ChiTietHoTroState {
  final CompleteType completeType;
  final SupportDetail? supportDetail;
  final String? errorMess;

  ChiTietHoTroSuccess({
    required this.completeType,
    this.supportDetail,
    this.errorMess,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [completeType,supportDetail,errorMess];
}
