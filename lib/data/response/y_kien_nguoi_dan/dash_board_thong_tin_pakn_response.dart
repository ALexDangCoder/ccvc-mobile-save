import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_thong_tin_pakn_response.g.dart';

int choDuyetChung = 0;

@JsonSerializable()
class DashBoardThongTinPaknTotalResponse {
  @JsonKey(name: 'Messages')
  List<String>? messages;

  @JsonKey(name: 'Data')
  DashBoardThongTinPaknResponse? data;

  DashBoardThongTinPaknTotalResponse(this.messages, this.data);

  factory DashBoardThongTinPaknTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DashBoardThongTinPaknTotalResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DashBoardThongTinPaknTotalResponseToJson(this);
}

@JsonSerializable()
class DashBoardThongTinPaknResponse {
  @JsonKey(name: 'TiepNhan')
  DashboardTiepNhanResponse? dashboardTiepNhan;
  @JsonKey(name: 'XuLy')
  DashboardXuLyResponse? dashboardXuLy;
  @JsonKey(name: 'HanXuLy')
  DashboardHanXuLyResponse? dashboardHanXuLy;

  DashBoardPAKNModel toModel() => DashBoardPAKNModel(
        dashBoardHanXuLyPAKNModel: dashboardHanXuLy?.toModel() ?? DashBoardHanXuLyPAKNModel(),
        dashBoardTiepNhanPAKNModel: dashboardTiepNhan?.toModel() ?? DashBoardTiepNhanPAKNModel(),
        dashBoardXuLyPAKNModelModel: dashboardXuLy?.toModel() ?? DashBoardXuLyPAKNModel(),
      );

  DashBoardThongTinPaknResponse(
      this.dashboardTiepNhan, this.dashboardXuLy, this.dashboardHanXuLy);

  factory DashBoardThongTinPaknResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardThongTinPaknResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardThongTinPaknResponseToJson(this);
}

@JsonSerializable()
class DashboardTiepNhanResponse {
  @JsonKey(name: 'ChoTiepNhan')
  int? choTiepNhan;
  @JsonKey(name: 'PhanXuLy')
  int? phanXuLy;
  @JsonKey(name: 'DangXuLy')
  int? dangXuLy;
  @JsonKey(name: 'ChoDuyet')
  int? choDuyet;
  @JsonKey(name: 'ChoBoSungThongTin')
  int? choBoSungThongTin;
  @JsonKey(name: 'DaHoanThanh')
  int? daHoanThanh;

  DashboardTiepNhanResponse(
    this.choTiepNhan,
    this.phanXuLy,
    this.dangXuLy,
    this.choDuyet,
    this.choBoSungThongTin,
    this.daHoanThanh,
  );

  factory DashboardTiepNhanResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardTiepNhanResponseFromJson(json);

  DashBoardTiepNhanPAKNModel toModel() => DashBoardTiepNhanPAKNModel(
        choTiepNhan: choTiepNhan ?? 0,
        phanXuLy: phanXuLy ?? 0,
        dangXuLy: dangXuLy ?? 0,
        choDuyet: choDuyetChung = (choDuyet ?? 0),
        choBoSungThongTin: choBoSungThongTin ?? 0,
        daHoanThanh: daHoanThanh ?? 0,
      );

  Map<String, dynamic> toJson() => _$DashboardTiepNhanResponseToJson(this);
}

@JsonSerializable()
class DashboardXuLyResponse {
  @JsonKey(name: 'ChoTiepNhanXuLy')
  int? choTiepNhanXuLy;
  @JsonKey(name: 'ChoXuLy')
  int? choXuLy;
  @JsonKey(name: 'ChoPhanXuLy')
  int? choPhanXuLy;
  @JsonKey(name: 'DaPhanCong')
  int? daPhanCong;
  @JsonKey(name: 'DaHoanThanh')
  int? daHoanThanh;

  DashboardXuLyResponse(
    this.choTiepNhanXuLy,
    this.choXuLy,
    this.choPhanXuLy,
    this.daPhanCong,
    this.daHoanThanh,
  );

  factory DashboardXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardXuLyResponseFromJson(json);

  DashBoardXuLyPAKNModel toModel() => DashBoardXuLyPAKNModel(
        choTiepNhanXuLy: choTiepNhanXuLy ?? 0,
        choXuLy: choXuLy ?? 0,
        choPhanXuLy: choPhanXuLy ?? 0,
        daPhanCong: daPhanCong ?? 0,
        daHoanThanh: daHoanThanh ?? 0,
        choDuyet: choDuyetChung,
      );

  Map<String, dynamic> toJson() => _$DashboardXuLyResponseToJson(this);
}

@JsonSerializable()
class DashboardHanXuLyResponse {
  @JsonKey(name: 'QuaHan')
  int? quaHan;
  @JsonKey(name: 'DenHan')
  int? denHan;
  @JsonKey(name: 'TrongHan')
  int? trongHan;

  DashboardHanXuLyResponse(this.quaHan, this.denHan, this.trongHan);

  factory DashboardHanXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardHanXuLyResponseFromJson(json);

  DashBoardHanXuLyPAKNModel toModel() => DashBoardHanXuLyPAKNModel(
        quaHan: quaHan ?? 0,
        denHan: denHan ?? 0,
        trongHan: trongHan ?? 0,
      );

  Map<String, dynamic> toJson() => _$DashboardHanXuLyResponseToJson(this);
}
