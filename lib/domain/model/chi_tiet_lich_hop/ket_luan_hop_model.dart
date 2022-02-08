import 'dart:io';

import 'package:flutter/material.dart';

enum TrangThai { DaDuyet, ChoDuyet, ChuaGuiDuyet, HuyDuyet }
enum TinhTrang { TrungBinh, Dat, ChuaDat }

class KetLuanHopModel {
  String id = '';
  String thoiGian = '';
  TrangThai trangThai = TrangThai.ChoDuyet;
  TinhTrang tinhTrang = TinhTrang.ChuaDat;
  File file = File('');

  KetLuanHopModel.empty();

  KetLuanHopModel({
    required this.id,
    required this.thoiGian,
    required this.trangThai,
    required this.tinhTrang,
    required this.file,
  });
}
