import 'package:json_annotation/json_annotation.dart';

part 'list_lich_lv_request.g.dart';

@JsonSerializable()
class ListLichLvRequest {
  bool isPublish;
  bool isLichCuaToi;
  bool isLichTaoHo;
  bool isLichHuyBo;
  bool isLichThuHoi;
  bool isLichDuocMoi;
  bool isChoXacNhan;
  bool isLichThamGia;
  bool isLichTuChoi;
  bool isChuaCoBaoCao;
  bool isDaCoBaoCao;
  bool IsLichLanhDao;
  String DateFrom;
  String DateTo;
  String UserId;
  String DonViId;
  int PageIndex;
  int PageSize;
  String ListUserId;
  String Title;

  ListLichLvRequest({
    required this.isPublish,
    required this.isLichCuaToi,
    required this.isLichTaoHo,
    required this.isLichHuyBo,
    required this.isLichThuHoi,
    required this.isLichDuocMoi,
    required this.isChoXacNhan,
    required this.isLichThamGia,
    required this.isLichTuChoi,
    required this.isChuaCoBaoCao,
    required this.isDaCoBaoCao,
    required this.IsLichLanhDao,
    required this.DateFrom,
    required this.DateTo,
    required this.UserId,
    required this.DonViId,
    required this.PageIndex,
    required this.PageSize,
    required this.ListUserId,
    required this.Title,
  });

  factory ListLichLvRequest.fromJson(Map<String, dynamic> json) =>
      _$ListLichLvRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListLichLvRequestToJson(this);
}
