class LichHopItem {
  int numberOfSchedule = 0;
  String typeId = '';
  String typeName = '';

  LichHopItem(this.numberOfSchedule, this.typeId, this.typeName);
}

List<LichHopItem> listItemSchedule = [
  LichHopItem(0, '0', 'Lịch chủ trì'),
  LichHopItem(0, '0', 'Lịch cần KLCH'),
  LichHopItem(0, '0', 'Lịch sắp tới'),
  LichHopItem(0, '0', 'Lịch bị trùng'),
];
