class LichLamViecRequest {
  String? dateFrom;
  String? dateTo;
  bool? isTatCa;
  bool? isLichDuocMoi;
  bool? isLichCuaToi;

  LichLamViecRequest(
      {this.dateFrom,
      this.dateTo,
      this.isTatCa,
      this.isLichDuocMoi,
      this.isLichCuaToi});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DateFrom'] = dateFrom;
    data['DateTo'] = dateTo;
    data['isTatCa'] = isTatCa;
    data['isLichDuocMoi'] = isLichDuocMoi;
    data['isLichCuaToi'] = isLichCuaToi;
    return data;
  }
}

