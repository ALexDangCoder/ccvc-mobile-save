import 'package:ccvc_mobile/generated/l10n.dart';

class LichLapModel {
  static const int KHONG_LAP_LAI = 1;
  static const int HANG_NGAY = 2;
  static const int TRONG_TUAN = 3;
  static const int HANG_TUAN = 4;
  static const int HANG_THANG = 5;
  static const int HANG_NAM = 6;
  static const int TUY_CHINH = 7;
  static const String KHONG_LAP = 'Không lặp lại';
  int? id;
  String? name;

  LichLapModel({
    this.id,
    this.name,
  });

  LichLapModel.seeded({this.id = KHONG_LAP_LAI, this.name = KHONG_LAP});
}

List<LichLapModel> listLichLap = [
  LichLapModel(name: S.current.khong_lap_lai, id: LichLapModel.KHONG_LAP_LAI),
  LichLapModel(name: S.current.lap_lai_hang_ngay, id: LichLapModel.HANG_NGAY),
  LichLapModel(
      name: S.current.tu_thu_2_den_thu_6, id: LichLapModel.TRONG_TUAN),
  LichLapModel(name: S.current.lap_lai_hang_tuan, id: LichLapModel.HANG_TUAN),
  LichLapModel(name: S.current.lap_lai_hang_thang, id: LichLapModel.HANG_THANG),
  LichLapModel(name: S.current.lap_lai_hang_nam, id: LichLapModel.HANG_NAM),
  LichLapModel(name: S.current.tuy_chinh, id: LichLapModel.TUY_CHINH),
];

class DayOffWeek {
  int? index;
  String? name;
  bool? isChoose;

  DayOffWeek({this.index, this.name, this.isChoose});
}
