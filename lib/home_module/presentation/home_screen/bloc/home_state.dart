import 'dart:io';

import 'package:ccvc_mobile/domain/model/lich_hop/file_model.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class MainStateInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class Loading extends HomeState {
  @override
  List<Object> get props => [];
}

