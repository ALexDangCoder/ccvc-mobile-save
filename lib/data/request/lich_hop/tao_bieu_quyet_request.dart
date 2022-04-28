class TaoBieuQuyetRequest {
  String? content;
  String? lichHopId;
  String? personName;
  String? phienHopId;
  int? time;
  String? unitName;

  TaoBieuQuyetRequest({
    this.content,
    this.lichHopId,
    this.personName,
    this.phienHopId,
    this.time,
    this.unitName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['lichHopId'] = lichHopId;
    data['personName'] = personName;
    data['phienHopId'] = phienHopId;
    data['time'] = time;
    data['unitName'] = unitName;

    return data;
  }
}
