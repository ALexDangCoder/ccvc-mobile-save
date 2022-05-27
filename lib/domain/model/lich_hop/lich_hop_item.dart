class LichHopItem {
  int numberOfSchedule = 0;
  String typeId = '';
  String typeName = '';

  LichHopItem(this.numberOfSchedule, this.typeId, this.typeName);
}

List<LichHopItem> listItemSchedule = [
  LichHopItem(20, '22', 'Lịch chủ trì'),
  LichHopItem(12, '22', 'Lịch cần KLCH'),
  LichHopItem(9, '22', 'Lịch sắp tới'),
  LichHopItem(26, '22', 'Lịch bị trùng'),
];
