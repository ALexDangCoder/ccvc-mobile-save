import 'package:ccvc_mobile/ket_noi_module/domain/model/danh_sach_chung_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_chung_ket_noi_response.g.dart';

@JsonSerializable()
class ListChungKetNoiResponse {
  @JsonKey(name: 'data')
  DataKetNoiResponse data;

  ListChungKetNoiResponse(this.data);

  factory ListChungKetNoiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ListChungKetNoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListChungKetNoiResponseToJson(this);
}

@JsonSerializable()
class DataKetNoiResponse {
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'pageData')
  List<KetNoiResponse>? pageData;
  @JsonKey(name: 'hasPreviousPage')
  bool? hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;

  DataKetNoiResponse();

  factory DataKetNoiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataKetNoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataKetNoiResponseToJson(this);

  DataDanhSachChungModel toDomain() => DataDanhSachChungModel(
        pageIndex: pageIndex,
        totalPages: totalPages,
        totalItems: totalItems,
        pageData: pageData?.map((e) => e.toModel()).toList() ?? [],
        hasPreviousPage: hasPreviousPage,
        hasNextPage: hasNextPage,
      );
}

@JsonSerializable()
class KetNoiResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'tenSuKien')
  String? tenSuKien;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'thanhPhanThamGia')
  String? thanhPhanThamGia;
  @JsonKey(name: 'thongTinLienHe')
  String? thongTinLienHe;
  @JsonKey(name: 'danhSachHinhAnh')
  String? danhSachHinhAnh;
  @JsonKey(name: 'danhSachIdLoaiSuKien')
  List<String>? danhSachIdLoaiSuKien;
  @JsonKey(name: 'isBookMark')
  bool? isBookMark;

  KetNoiResponse();

  factory KetNoiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$KetNoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KetNoiResponseToJson(this);

  DanhSachChungModel toModel() => DanhSachChungModel(
        id: id,
        tenSuKien: tenSuKien,
        thoiGianBatDau: thoiGianBatDau,
        diaChi: diaChi,
        thanhPhanThamGia: thanhPhanThamGia,
        thongTinLienHe: thongTinLienHe,
        danhSachHinhAnh: danhSachHinhAnh,
        danhSachIdLoaiSuKien: danhSachIdLoaiSuKien,
        isBookMark: isBookMark,
      );
}
