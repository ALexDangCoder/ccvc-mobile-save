part of 'chi_tiet_pakn_cubit.dart';

abstract class ChiTietPaknState extends Equatable {
  const ChiTietPaknState();
}

class ChiTietPaknInitial extends ChiTietPaknState {
  @override
  List<Object> get props => [];
}

class ChiTietPaknLoading extends ChiTietPaknState {
  @override
  List<Object?> get props => [];
}

class ChiTietPaknSuccess extends ChiTietPaknState {
  final CompleteType completeType;
  final List<YKienXuLyYKNDModel>? list;
  final String? message;

  ChiTietPaknSuccess(
    this.completeType, {
    this.list,
    this.message,
  });

  @override
  List<Object?> get props => [completeType, list, message];
}
