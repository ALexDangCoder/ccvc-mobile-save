class CreatKetLuanHopRequest {
  String? scheduleId;
  String? content;
  String? reportStatusId;
  String? reportTemplateId;

  CreatKetLuanHopRequest({
    this.scheduleId,
    this.content,
    this.reportStatusId,
    this.reportTemplateId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleId'] = scheduleId;
    data['content'] = content;
    data['reportStatusId'] = reportStatusId;
    data['reportTemplateId'] = reportTemplateId;
    return data;
  }
}
