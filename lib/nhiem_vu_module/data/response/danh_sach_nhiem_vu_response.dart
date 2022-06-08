import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_nhiem_vu_response.g.dart';

@JsonSerializable()
class DanhSachNhiemVuResponse {
  @JsonKey(name: 'Data')
  DataResponse? daTa;

  DanhSachNhiemVuResponse(this.daTa);

  factory DanhSachNhiemVuResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachNhiemVuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachNhiemVuResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'PageData')
  List<PageDataResponse>? pageData;
  @JsonKey(name: 'TotalRows')
  int? totalRows;
  @JsonKey(name: 'CurrentPage')
  int? currentPage;
  @JsonKey(name: 'PageSize')
  int? pageSize;
  @JsonKey(name: 'TotalPage')
  int? totalPage;

  DataResponse(this.pageData);

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  DanhSachNhiemVuModel toDoMain() => DanhSachNhiemVuModel (
        pageData: pageData?.map((e) => e.toDomain()).toList() ?? [],
        totalRows: totalRows,
        currentPage: currentPage,
        pageSize: pageSize,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class PageDataResponse {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'SoNhiemVu')
  String? soNhiemVu;
  @JsonKey(name: 'NoiDungTheoDoi')
  String? noiDungTheoDoi;
  @JsonKey(name: 'DonViTheoDoi')
  String? donViTheoDoi;
  @JsonKey(name: 'ChuyenVienTheoDoi')
  String? chuyenVienTheoDoi;
  @JsonKey(name: 'NguoiGiaoViec')
  String? nguoiGiaoViec;
  @JsonKey(name: 'HanXuLyVPCP')
  String? hanXuLyVPCP;
  @JsonKey(name: 'HanXuLyVPCP_')
  String? hanXuLyVPCP2;
  @JsonKey(name: 'TinhHinhThucHienNoiBo')
  String? tinhHinhThucHienNoiBo;
  @JsonKey(name: 'TinhHinhThucHien')
  String? tinhHinhThucHien;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'HanXuLy_')
  String? hanXuLy2;
  @JsonKey(name: 'SoKyHieuVanBan')
  String? soKyHieuVanBan;
  @JsonKey(name: 'NgayVanBan')
  String? ngayVanBan;
  @JsonKey(name: 'NgayVanBan_')
  String? ngayVanBan2;
  @JsonKey(name: 'LoaiNhiemVuId')
  String? loaiNhiemVuId;
  @JsonKey(name: 'LoaiNhiemVu')
  String? loaiNhiemVu;
  @JsonKey(name: 'TrangThaiHanXuLy')
  int? trangThaiHanXuLy;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;
  @JsonKey(name: 'TrangThaiId')
  String? trangThaiId;
  @JsonKey(name: 'DonViTaoId')
  String? donViTaoId;
  @JsonKey(name: 'NguoiGiaoId')
  String? nguoiGiaoId;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'MaNV')
  String? maNV;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;
  @JsonKey(name: 'TrangThaiDonViXuLy')
  List<TrangThaiDonViXuLy>? trangThaiDonViXuLy;
  @JsonKey(name: 'CongViecCon')
  CongViecConResponse? congViecCon;
  @JsonKey(name: 'DaGuiVPCP')
  bool? daGuiVPCP;
  @JsonKey(name: 'TrichYeuVanBan')
  String? trichYeuVanBan;
  @JsonKey(name: 'NoiDungDonDoc')
  String? noiDungDonDoc;
  @JsonKey(name: 'ThoiGianDonDoc')
  String? thoiGianDonDoc;
  @JsonKey(name: 'TenDonViCaNhanBiDonDoc')
  String? tenDonViCaNhanBiDonDoc;
  @JsonKey(name: 'NoiDungYKien')
  String? noiDungYKien;
  @JsonKey(name: 'TenDonViCaNhanTraLai')
  String? tenDonViCaNhanTraLai;
  @JsonKey(name: 'NoiDungTraLai')
  String? noiDungTraLai;
  @JsonKey(name: 'NoiDungThuHoi')
  String? noiDungThuHoi;
  @JsonKey(name: 'TenDonViCaNhanThuHoi')
  String? tenDonViCaNhanThuHoi;
  @JsonKey(name: 'DienGiaiTrangThai')
  String? dienGiaiTrangThai;
  @JsonKey(name: 'NgayHoanThanh')
  String? ngayHoanThanh;
  @JsonKey(name: 'NgayHoanThanh_')
  String? ngayHoanThanh2;
  @JsonKey(name: 'IsChuTriTraLai')
  bool? isChuTriTraLai;
  @JsonKey(name: 'CoTheCapNhatTinhHinhThucHien')
  bool? coTheCapNhatTinhHinhThucHien;
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'PhamViId')
  String? phamViId;
  @JsonKey(name: 'CoTheXoa')
  bool? coTheXoa;
  @JsonKey(name: 'CoThePhanXuLy')
  bool? coThePhanXuLy;
  @JsonKey(name: 'CoTheThuHoi')
  bool? coTheThuHoi;
  @JsonKey(name: 'CoTheDonDoc')
  bool? coTheDonDoc;
  @JsonKey(name: 'CoTheTraLai')
  bool? coTheTraLai;
  @JsonKey(name: 'NgayTaoNhiemVu_')
  String? ngayTaoNhiemVu;
  @JsonKey(name: 'NgayTaoNhiemVu')
  String? ngayTaoNhiemVu2;
  @JsonKey(name: 'HasFile')
  bool? hasFile;
  @JsonKey(name: 'WTrangThai')
  int? wTrangThai;
  @JsonKey(name: 'IsHoanThanhQuaHan')
  bool? isHoanThanhQuaHan;
  @JsonKey(name: 'IdCuocHop')
  String? idCuocHop;

  PageDataResponse();

  factory PageDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseToJson(this);

  PageData toDomain() => PageData(
        id: id ?? '',
        soNhiemVu: soNhiemVu ?? '',
        noiDungTheoDoi: noiDungTheoDoi ?? '',
        donViTheoDoi: donViTheoDoi ?? '',
        chuyenVienTheoDoi: chuyenVienTheoDoi ?? '',
        nguoiGiaoViec: nguoiGiaoViec ?? '',
        hanXuLyVPCP: hanXuLyVPCP ?? '',
        hanXuLyVPCP2: hanXuLyVPCP2 ?? '',
        tinhHinhThucHienNoiBo: tinhHinhThucHienNoiBo ?? '',
        tinhHinhThucHien: tinhHinhThucHien ?? '',
        hanXuLy: hanXuLy ?? '',
        hanXuLy2: hanXuLy2 ?? '',
        soKyHieuVanBan: soKyHieuVanBan ?? '',
        ngayVanBan: ngayVanBan ?? '',
        ngayVanBan2: ngayVanBan2 ?? '',
        loaiNhiemVuId: loaiNhiemVuId ?? '',
        loaiNhiemVu: loaiNhiemVu ?? '',
        trangThaiHanXuLy: trangThaiHanXuLy ?? 0,
        trangThai: trangThai ?? '',
        maTrangThai: maTrangThai ?? '',
        trangThaiId: trangThaiId ?? '',
        donViTaoId: donViTaoId ?? '',
        nguoiGiaoId: nguoiGiaoId ?? '',
        nguoiTaoId: nguoiTaoId ?? '',
        maNV: maNV ?? '',
        ngayTao: ngayTao ?? '',
        trangThaiDonViXuLy:
            trangThaiDonViXuLy?.map((e) => e.toModel()).toList() ?? [],
        congViecCon: congViecCon?.toDomain() ?? CongViecCon(),
        daGuiVPCP: daGuiVPCP ?? false,
        trichYeuVanBan: trichYeuVanBan ?? '',
        noiDungDonDoc: noiDungDonDoc ?? '',
        thoiGianDonDoc: thoiGianDonDoc ?? '',
        tenDonViCaNhanBiDonDoc: tenDonViCaNhanBiDonDoc ?? '',
        noiDungYKien: noiDungYKien ?? '',
        tenDonViCaNhanTraLai: tenDonViCaNhanTraLai ?? '',
        noiDungTraLai: noiDungTraLai ?? '',
        noiDungThuHoi: noiDungThuHoi ?? '',
        tenDonViCaNhanThuHoi: tenDonViCaNhanThuHoi ?? '',
        dienGiaiTrangThai: dienGiaiTrangThai ?? '',
        ngayHoanThanh: ngayHoanThanh ?? '',
        ngayHoanThanh2: ngayHoanThanh2 ?? '',
        isChuTriTraLai: isChuTriTraLai ?? false,
        coTheCapNhatTinhHinhThucHien: coTheCapNhatTinhHinhThucHien ?? false,
        canBoId: canBoId ?? '',
        phamViId: phamViId ?? '',
        coTheXoa: coTheXoa ?? false,
        coThePhanXuLy: coThePhanXuLy ?? false,
        coTheThuHoi: coTheThuHoi ?? false,
        coTheDonDoc: coTheDonDoc ?? false,
        coTheTraLai: coTheTraLai ?? false,
        ngayTaoNhiemVu: ngayTaoNhiemVu ?? '',
        ngayTaoNhiemVu2: ngayTaoNhiemVu2 ?? '',
        hasFile: hasFile ?? false,
        wTrangThai: wTrangThai ?? 0,
        isHoanThanhQuaHan: isHoanThanhQuaHan ?? false,
        idCuocHop: idCuocHop ?? '',
      );
}

@JsonSerializable()
class TrangThaiDonViXuLy {
  @JsonKey(name: 'CanBoId')
  String? canBoId;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'TrangThaiHanXuLy')
  int? trangThaiHanXuLy;

  TrangThaiDonViXuLy();

  factory TrangThaiDonViXuLy.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TrangThaiDonViXuLyFromJson(json);

  Map<String, dynamic> toJson() => _$TrangThaiDonViXuLyToJson(this);

  TrangThaiDonViXuLyModel toModel() => TrangThaiDonViXuLyModel(
        canBoId: canBoId,
        donViId: donViId,
        trangThai: trangThai,
        trangThaiHanXuLy: trangThaiHanXuLy,
      );
}

@JsonSerializable()
class CongViecConResponse {
  @JsonKey(name: 'TongSo')
  int? tongSo;
  @JsonKey(name: 'TrongHan')
  int? trongHan;
  @JsonKey(name: 'QuaHan')
  int? quaHan;
  @JsonKey(name: 'ToiHan')
  int? toiHan;

  CongViecConResponse();

  factory CongViecConResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CongViecConResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CongViecConResponseToJson(this);

  CongViecCon toDomain() => CongViecCon(
        tongSo: tongSo ?? 0,
        trongHan: trongHan ?? 0,
        quaHan: quaHan ?? 0,
        toiHan: toiHan ?? 0,
      );
}
