class TongHopNhiemVuRequest {
  String canBoID;

  TongHopNhiemVuRequest({required this.canBoID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CanBoId'] = canBoID;
    return data;
  }
}
