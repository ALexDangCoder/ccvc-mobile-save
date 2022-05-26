class LichLapModel {
  int? id;
  String? name;

  LichLapModel({
    this.id,
    this.name,
  });

  LichLapModel.seeded({this.id = 1, this.name = 'Không lặp lại'});
}

List<LichLapModel> listLichLap = [
  LichLapModel(name: 'Không lặp lại', id: 1),
  LichLapModel(name: 'Lặp lại hàng ngày', id: 2),
  LichLapModel(name: 'Thứ 2 đên thứ 6 hàng tuần', id: 3),
  LichLapModel(name: 'Lặp lại hàng tuần', id: 4),
  LichLapModel(name: 'Lặp lại hàng tháng', id: 5),
  LichLapModel(name: 'Lặp lại hàng năm', id: 6),
  LichLapModel(name: 'Tùy chỉnh', id: 7),
];

class DayOffWeek {
  int? index;
  String? name;
  bool? isChoose;

  DayOffWeek({this.index, this.name, this.isChoose});
}
