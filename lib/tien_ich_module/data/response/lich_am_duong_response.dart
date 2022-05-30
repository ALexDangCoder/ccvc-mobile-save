import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_am_duong_response.g.dart';

@JsonSerializable()
class DataLichAmDuongResponse extends Equatable {
  @JsonKey(name: 'data')
  LichAmDuongResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataLichAmDuongResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataLichAmDuongResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichAmDuongResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLichAmDuongResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class GioHoangDaoResponse extends Equatable {
  @JsonKey(name: 'ten')
  String? ten;
  @JsonKey(name: 'gio')
  String? gio;

  GioHoangDaoResponse({
    this.ten,
    this.gio,
  });

  factory GioHoangDaoResponse.fromJson(Map<String, dynamic> json) =>
      _$GioHoangDaoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GioHoangDaoResponseToJson(this);

  GioHoangDao toModel() => GioHoangDao(
        ten: ten,
        gio: gio,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class GioHacDaoResponse extends Equatable {
  @JsonKey(name: 'ten')
  String? ten;
  @JsonKey(name: 'gio')
  String? gio;

  GioHacDaoResponse({
    this.ten,
    this.gio,
  });

  factory GioHacDaoResponse.fromJson(Map<String, dynamic> json) =>
      _$GioHacDaoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GioHacDaoResponseToJson(this);

  GioHacDao toModel() => GioHacDao(
        ten: ten,
        gio: gio,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichAmDuongResponse extends Equatable {
  @JsonKey(name: 'gioHoangDao')
  List<GioHoangDaoResponse>? gioHoangDao;
  @JsonKey(name: 'gioHacDao')
  List<GioHacDaoResponse>? gioHacDao;
  @JsonKey(name: 'ngayAmLich')
  NgayAmLichResponse? ngayAmLich;
  @JsonKey(name: 'ngayAmLicgStr')
  String? ngayAmLicgStr;
  @JsonKey(name: 'tietKhi')
  String? tietKhi;
  @JsonKey(name: 'nguHanh')
  NguHanhResponse? nguHanh;
  @JsonKey(name: 'truc')
  String? truc;
  @JsonKey(name: 'chiTietTruc')
  List<ChiTietTrucResponse>? chiTietTruc;
  @JsonKey(name: 'thu')
  String? thu;
  @JsonKey(name: 'tuoiXungTheoNgay')
  List<TuoiXungTheoNgayResponse>? tuoiXungTheoNgay;
  @JsonKey(name: 'tuoiXungTheoThang')
  List<TuoiXungTheoThangResponse>? tuoiXungTheoThang;
  @JsonKey(name: 'ngayBachKy')
  List<NgayBachKyResponse>? ngayBachKy;
  @JsonKey(name: 'thapNhiBatTu')
  ThapNhiBatTuResponse? thapNhiBatTu;
  @JsonKey(name: 'thapNhiKienTru')
  ThapNhiKienTruResponse? thapNhiKienTru;
  @JsonKey(name: 'saoTot')
  List<SaoTotResponse>? saoTot;
  @JsonKey(name: 'saoXau')
  List<SaoXauResponse>? saoXau;
  @JsonKey(name: 'gioLyThuanPhong')
  List<GioLyThuanPhongResponse>? gioLyThuanPhong;

  LichAmDuongResponse({
    this.gioHoangDao,
    this.gioHacDao,
    this.ngayAmLich,
    this.ngayAmLicgStr,
    this.tietKhi,
    this.nguHanh,
    this.truc,
    this.chiTietTruc,
    this.thu,
    this.tuoiXungTheoNgay,
    this.tuoiXungTheoThang,
    this.ngayBachKy,
    this.thapNhiBatTu,
    this.thapNhiKienTru,
    this.saoTot,
    this.saoXau,
    this.gioLyThuanPhong,
  });

  factory LichAmDuongResponse.fromJson(Map<String, dynamic> json) =>
      _$LichAmDuongResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichAmDuongResponseToJson(this);

  LichAmDuong toModel() => LichAmDuong(
        gioHoangDao: gioHoangDao?.map((e) => e.toModel()).toList(),
        gioHacDao: gioHacDao?.map((e) => e.toModel()).toList(),
        ngayAmLich: ngayAmLich?.toModel(),
        ngayAmLicgStr: ngayAmLicgStr,
        tietKhi: tietKhi,
        nguHanh: nguHanh?.toModel(),
        truc: truc,
        chiTietTruc: chiTietTruc?.map((e) => e.toModel()).toList(),
        thu: thu,
        tuoiXungTheoNgay: tuoiXungTheoNgay?.map((e) => e.toModel()).toList(),
        tuoiXungTheoThang: tuoiXungTheoThang?.map((e) => e.toModel()).toList(),
        ngayBachKy: ngayBachKy?.map((e) => e.toModel()).toList(),
        thapNhiBatTu: thapNhiBatTu?.toModel(),
        thapNhiKienTru: thapNhiKienTru?.toModel(),
        saoTot: saoTot?.map((e) => e.toModel()).toList(),
        saoXau: saoXau?.map((e) => e.toModel()).toList(),
        gioLyThuanPhong: gioLyThuanPhong?.map((e) => e.toModel()).toList(),
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NgayAmLichResponse extends Equatable {
  @JsonKey(name: 'year')
  int? year;
  @JsonKey(name: 'month')
  int? month;
  @JsonKey(name: 'isLeapMonth')
  bool? isLeapMonth;
  @JsonKey(name: 'day')
  int? day;
  @JsonKey(name: 'solarDate')
  String? solarDate;
  @JsonKey(name: 'isTermBeginThisDay')
  bool? isTermBeginThisDay;
  @JsonKey(name: 'solarTermIndex')
  int? solarTermIndex;
  @JsonKey(name: 'yearName')
  String? yearName;
  @JsonKey(name: 'monthName')
  String? monthName;
  @JsonKey(name: 'monthShortName')
  String? monthShortName;
  @JsonKey(name: 'monthLongName')
  String? monthLongName;
  @JsonKey(name: 'monthFullName')
  String? monthFullName;
  @JsonKey(name: 'dayName')
  String? dayName;
  @JsonKey(name: 'solarTerm')
  String? solarTerm;
  @JsonKey(name: 'fullDayInfo')
  String? fullDayInfo;

  NgayAmLichResponse({
    this.year,
    this.month,
    this.isLeapMonth,
    this.day,
    this.solarDate,
    this.isTermBeginThisDay,
    this.solarTermIndex,
    this.yearName,
    this.monthName,
    this.monthShortName,
    this.monthLongName,
    this.monthFullName,
    this.dayName,
    this.solarTerm,
    this.fullDayInfo,
  });

  factory NgayAmLichResponse.fromJson(Map<String, dynamic> json) =>
      _$NgayAmLichResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NgayAmLichResponseToJson(this);

  NgayAmLich toModel() => NgayAmLich(
        year: year,
        month: month,
        isLeapMonth: isLeapMonth,
        day: day,
        solarDate: solarDate,
        isTermBeginThisDay: isTermBeginThisDay,
        solarTermIndex: solarTermIndex,
        yearName: yearName,
        monthName: monthName,
        monthShortName: monthShortName,
        monthLongName: monthLongName,
        monthFullName: monthFullName,
        dayName: dayName,
        solarTerm: solarTerm,
        fullDayInfo: fullDayInfo,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NguHanhResponse extends Equatable {
  @JsonKey(name: 'hanh')
  String? hanh;
  @JsonKey(name: 'sao')
  String? sao;
  @JsonKey(name: 'truc')
  String? truc;
  @JsonKey(name: 'mota')
  String? mota;
  @JsonKey(name: 'kieuNgay')
  int? kieuNgay;

  NguHanhResponse({
    this.hanh,
    this.sao,
    this.truc,
    this.mota,
    this.kieuNgay,
  });

  factory NguHanhResponse.fromJson(Map<String, dynamic> json) =>
      _$NguHanhResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguHanhResponseToJson(this);

  NguHanh toModel() => NguHanh(
        hanh: hanh,
        sao: sao,
        truc: truc,
        mota: mota,
        kieuNgay: kieuNgay,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ChiTietTrucResponse extends Equatable {
  @JsonKey(name: 'nenLam')
  String? nenLam;
  @JsonKey(name: 'khongNenLam')
  String? khongNenLam;
  @JsonKey(name: 'thongTinThem')
  String? thongTinThem;

  ChiTietTrucResponse({
    this.nenLam,
    this.khongNenLam,
    this.thongTinThem,
  });

  factory ChiTietTrucResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietTrucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietTrucResponseToJson(this);

  ChiTietTruc toModel() => ChiTietTruc(
        nenLam: nenLam,
        khongNenLam: khongNenLam,
        thongTinThem: thongTinThem,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TuoiXungTheoNgayResponse extends Equatable {
  @JsonKey(name: 'tenTuoi')
  String? tenTuoi;
  @JsonKey(name: 'nguHanh')
  String? nguHanh;
  @JsonKey(name: 'chi')
  String? chi;

  TuoiXungTheoNgayResponse({
    this.tenTuoi,
    this.nguHanh,
    this.chi,
  });

  factory TuoiXungTheoNgayResponse.fromJson(Map<String, dynamic> json) =>
      _$TuoiXungTheoNgayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TuoiXungTheoNgayResponseToJson(this);

  TuoiXungTheoNgay toModel() => TuoiXungTheoNgay(
        tenTuoi: tenTuoi,
        nguHanh: nguHanh,
        chi: chi,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TuoiXungTheoThangResponse extends Equatable {
  @JsonKey(name: 'tenTuoi')
  String? tenTuoi;
  @JsonKey(name: 'nguHanh')
  String? nguHanh;
  @JsonKey(name: 'chi')
  String? chi;

  TuoiXungTheoThangResponse({
    this.tenTuoi,
    this.nguHanh,
    this.chi,
  });

  factory TuoiXungTheoThangResponse.fromJson(Map<String, dynamic> json) =>
      _$TuoiXungTheoThangResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TuoiXungTheoThangResponseToJson(this);

  TuoiXungTheoThang toModel() => TuoiXungTheoThang(
        tenTuoi: tenTuoi,
        nguHanh: nguHanh,
        chi: chi,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NgayBachKyResponse extends Equatable {
  @JsonKey(name: 'ten')
  String? ten;
  @JsonKey(name: 'mo_ta')
  String? moTa;
  @JsonKey(name: 'tot_xau')
  String? totXau;

  NgayBachKyResponse({
    this.ten,
    this.moTa,
    this.totXau,
  });

  NgayBachKy toModel() => NgayBachKy(
        ten: ten,
        moTa: moTa,
        totXau: totXau,
      );

  factory NgayBachKyResponse.fromJson(Map<String, dynamic> json) =>
      _$NgayBachKyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NgayBachKyResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ThapNhiBatTuResponse extends Equatable {
  @JsonKey(name: 'tinhMoc')
  String? tinhMoc;
  @JsonKey(name: 'tot_xau')
  String? totXau;
  @JsonKey(name: 'nenLam')
  String? nenLam;
  @JsonKey(name: 'kieng')
  String? kieng;
  @JsonKey(name: 'ngoaiLe')
  String? ngoaiLe;

  ThapNhiBatTuResponse({
    this.tinhMoc,
    this.totXau,
    this.nenLam,
    this.kieng,
    this.ngoaiLe,
  });

  factory ThapNhiBatTuResponse.fromJson(Map<String, dynamic> json) =>
      _$ThapNhiBatTuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThapNhiBatTuResponseToJson(this);

  ThapNhiBatTu toModel() => ThapNhiBatTu(
        tinhMoc: tinhMoc,
        totXau: totXau,
        nenLam: nenLam,
        kieng: kieng,
        ngoaiLe: ngoaiLe,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ThapNhiKienTruResponse extends Equatable {
  @JsonKey(name: 'truc')
  String? truc;
  @JsonKey(name: 'nenLam')
  String? nenLam;
  @JsonKey(name: 'khongNenLam')
  String? khongNenLam;

  ThapNhiKienTruResponse({
    this.truc,
    this.nenLam,
    this.khongNenLam,
  });

  factory ThapNhiKienTruResponse.fromJson(Map<String, dynamic> json) =>
      _$ThapNhiKienTruResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThapNhiKienTruResponseToJson(this);

  ThapNhiKienTru toModel() => ThapNhiKienTru(
        truc: truc,
        nenLam: nenLam,
        khongNenLam: khongNenLam,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class SaoTotResponse extends Equatable {
  @JsonKey(name: 'tenSao')
  String? tenSao;
  @JsonKey(name: 'thongTin')
  String? thongTin;

  SaoTotResponse({
    this.tenSao,
    this.thongTin,
  });

  factory SaoTotResponse.fromJson(Map<String, dynamic> json) =>
      _$SaoTotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaoTotResponseToJson(this);

  SaoTot toModel() => SaoTot(
        tenSao: tenSao,
        thongTin: thongTin,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class SaoXauResponse extends Equatable {
  @JsonKey(name: 'tenSao')
  String? tenSao;
  @JsonKey(name: 'thongTin')
  String? thongTin;

  SaoXauResponse({
    this.tenSao,
    this.thongTin,
  });

  factory SaoXauResponse.fromJson(Map<String, dynamic> json) =>
      _$SaoXauResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SaoXauResponseToJson(this);

  SaoXau toModel() => SaoXau(
        tenSao: tenSao,
        thongTin: thongTin,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class GioLyThuanPhongResponse extends Equatable {
  @JsonKey(name: 'ten')
  String? ten;
  @JsonKey(name: 'mo_ta')
  String? moTa;

  GioLyThuanPhongResponse({
    this.ten,
    this.moTa,
  });

  factory GioLyThuanPhongResponse.fromJson(Map<String, dynamic> json) =>
      _$GioLyThuanPhongResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GioLyThuanPhongResponseToJson(this);

  GioLyThuanPhong toModel() => GioLyThuanPhong(
        ten: ten,
        moTa: moTa,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
