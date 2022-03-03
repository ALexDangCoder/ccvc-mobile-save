class SelectPhienHopModel {
  List<DataPhienHopSelect>? listPhienHopSelect;

  SelectPhienHopModel({this.listPhienHopSelect});
}

class DataPhienHopSelect {
  String? id;
  String? scheduleId;
  String? content;
  String? nguoiTao;
  String? ngayTao;
  String? nguoiTaoId;

  DataPhienHopSelect(
      {this.id,
      this.scheduleId,
      this.content,
      this.nguoiTao,
      this.ngayTao,
      this.nguoiTaoId});
}
