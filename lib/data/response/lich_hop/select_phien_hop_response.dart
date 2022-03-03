import 'package:ccvc_mobile/domain/model/lich_hop/select_phien_hop_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'select_phien_hop_response.g.dart';

@JsonSerializable()
class SelectPhienHopResponse {
  @JsonKey(name: 'data')
  List<SelectPhienHopData>? listPhienHop;

  SelectPhienHopResponse(this.listPhienHop);

  factory SelectPhienHopResponse.fromJson(Map<String, dynamic> json) =>
      _$SelectPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelectPhienHopResponseToJson(this);

  SelectPhienHopModel toModel() => SelectPhienHopModel(
        listPhienHopSelect:
            listPhienHop?.map((e) => e.toModel()).toList() ?? [],
      );
}

@JsonSerializable()
class SelectPhienHopData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'nguoiTao')
  String? nguoiTao;
  @JsonKey(name: 'ngayTao')
  String? ngayTao;
  @JsonKey(name: ' nguoiTaoId')
  String? nguoiTaoId;

  SelectPhienHopData(
      {this.id,
      this.scheduleId,
      this.content,
      this.ngayTao,
      this.nguoiTao,
      this.nguoiTaoId});

  factory SelectPhienHopData.fromJson(Map<String, dynamic> json) =>
      _$SelectPhienHopDataFromJson(json);

  Map<String, dynamic> toJson() => _$SelectPhienHopDataToJson(this);

  DataPhienHopSelect toModel() => DataPhienHopSelect(
        id: id,
        scheduleId: scheduleId,
        content: content,
        ngayTao: ngayTao,
        nguoiTao: nguoiTao,
        nguoiTaoId: nguoiTaoId,
      );
}
