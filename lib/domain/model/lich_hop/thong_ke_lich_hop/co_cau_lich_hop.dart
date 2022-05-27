import 'dart:math';

import 'package:flutter/material.dart';

class CoCauLichHopModel {
  String? id;
  String? name;
  int? quantities;
  Color? color;

  CoCauLichHopModel({
    required this.id,
    required this.name,
    required this.quantities,
  }) {
    final Random random = Random();
    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
  }
}
