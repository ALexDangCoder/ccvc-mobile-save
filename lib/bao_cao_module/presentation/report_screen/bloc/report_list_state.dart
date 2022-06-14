import 'package:equatable/equatable.dart';

abstract class ReportListState extends Equatable {
  const ReportListState();
}

class ReportListStateInitial extends ReportListState {
  @override
  List<Object> get props => [];
}

class Loading extends ReportListState {
  @override
  List<Object> get props => [];
}
