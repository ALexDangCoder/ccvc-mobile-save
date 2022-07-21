class LichLamViecRequest {
  String? dateFrom;
  String? dateTo;
  bool? isTatCa;
  bool? isLichDuocMoi;
  bool? isLichCuaToi;
  bool? isChoXacNhan;
  LichLamViecRequest(
      {this.dateFrom,
      this.dateTo,
      this.isTatCa,
      this.isLichDuocMoi,
      this.isLichCuaToi,
      this.isChoXacNhan,
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DateFrom'] = dateFrom;
    data['DateTo'] = dateTo;
    data['isTatCa'] = isTatCa;
    data['isLichDuocMoi'] = isLichDuocMoi;
    data['isLichCuaToi'] = isLichCuaToi;
    data['isChoXacNhan'] = isChoXacNhan;
    return data;
  }
}

