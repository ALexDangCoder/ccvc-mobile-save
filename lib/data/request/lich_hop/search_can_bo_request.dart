class SearchCanBoRequest {
  String? iDDonVi;
  int? pageIndex;
  int? pageSize;

  SearchCanBoRequest({this.iDDonVi, this.pageIndex, this.pageSize});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID_DonVi'] = iDDonVi;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}