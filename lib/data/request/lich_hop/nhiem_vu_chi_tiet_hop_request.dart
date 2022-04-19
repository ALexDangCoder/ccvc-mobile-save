class NhiemVuChiTietHopRequest {
  int? size;
  int? index;
  bool? isNhiemVuCaNhan;
  String? idCuocHop;

  NhiemVuChiTietHopRequest({
    this.size,
    this.index,
    this.isNhiemVuCaNhan,
    this.idCuocHop
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IdCuocHop'] = idCuocHop;
    data['Size'] = size;
    data['Index'] = index;
    data['IsNhiemVuCaNhan'] = isNhiemVuCaNhan;
    return data;
  }
}

class NgayTaoNhiemVu {
  String? fromDate;
  String? toDate;

  NgayTaoNhiemVu({this.fromDate, this.toDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    return data;
  }
}
