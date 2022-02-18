class LichLamViecRequest {
  String? dateFrom;
  String? dateTo;
  bool? isTatCa;

  LichLamViecRequest({this.dateFrom, this.dateTo, this.isTatCa});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DateFrom'] = dateFrom;
    data['DateTo'] = dateTo;
    data['isTatCa'] = isTatCa;
    return data;
  }
}
