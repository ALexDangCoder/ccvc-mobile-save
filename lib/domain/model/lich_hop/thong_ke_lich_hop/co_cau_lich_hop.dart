import 'dart:math';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:flutter/material.dart';

const HOP_SO_KET = 'Họp sơ kết, tổng kết';
const HOP_CHUYEN_MON = 'Họp chuyên môn';
const HOP_CHUYEN_DE = 'Họp chuyên đề';
const HOP_GIAI_QUYET_CONG_VIEC = 'Họp giải quyết công việc';
const HOP_TAP_HUAN = 'Họp tập huấn, triển khai';
const HOP_THAM_MUU = 'Họp tham mưu, tư vấn';
const HOP_DIEU_PHOI = 'Họp điều phối';
const HOP_GIAO_BAN = 'Họp giao ban';

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
    color = getColor();
  }

  Color getColor() {
    switch (name) {
      case HOP_SO_KET:
        return colorFF9F43;
      case HOP_CHUYEN_MON:
        return color5A8DEE;
      case HOP_CHUYEN_DE:
        return color02C5DD;
      case HOP_GIAI_QUYET_CONG_VIEC:
        return color28C76F;
      case HOP_TAP_HUAN:
        return color9B8DFF;
      case HOP_THAM_MUU:
        return yellowColor;
      case HOP_DIEU_PHOI:
        return colorEA5455;
      case HOP_GIAO_BAN:
        return colorA2AEBD;
      default:
        return Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          1,
        );
    }
  }
}
