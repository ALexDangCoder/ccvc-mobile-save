class LichHopRequest {
  String? dateFrom;
  String? dateTo;
  bool? isLichCuaToi;
  bool? isLichDuocMoi;
  bool? isDuyetLich;
  bool? isChoXacNhan;
  LichHopRequest({
    this.dateFrom,
    this.dateTo,
    this.isLichCuaToi,
    this.isLichDuocMoi,
    this.isDuyetLich,
    this.isChoXacNhan,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DateFrom'] = dateFrom;
    data['DateTo'] = dateTo;
    data['isLichCuaToi'] = isLichCuaToi;
    data['isLichDuocMoi'] = isLichDuocMoi;
    data['isDuyetLich'] = isDuyetLich;
    data['isChoXacNhan'] = isChoXacNhan;
    return data;
  }
}
