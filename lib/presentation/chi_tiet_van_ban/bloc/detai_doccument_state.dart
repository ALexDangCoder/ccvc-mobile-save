import 'package:equatable/equatable.dart';

abstract class DetailDocumentState extends Equatable {
  const DetailDocumentState();
}

class DetailDocumentInitial extends DetailDocumentState {
  @override
  List<Object> get props => [];
}

class Loading extends DetailDocumentState {
  @override
  List<Object> get props => [];
}
