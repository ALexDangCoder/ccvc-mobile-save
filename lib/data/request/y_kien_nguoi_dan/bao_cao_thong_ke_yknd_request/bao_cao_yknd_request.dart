class BaoCaoYKNDRequest {
  List<String>? donViXuLy;
  String? tuNgay;
  String? denNgay;

  BaoCaoYKNDRequest({this.donViXuLy, this.tuNgay, this.denNgay});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (donViXuLy?.isNotEmpty ?? false) {
      data['DonViXuLy'] = donViXuLy?.join(',');
    }
    data['TuNgay'] = tuNgay;
    data['DenNgay'] = denNgay;
    return data;
  }
}
