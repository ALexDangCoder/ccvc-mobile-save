import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_van_ban_den_response.g.dart';

@JsonSerializable()
class ChiTietVanBanDenDataResponse extends Equatable {
  @JsonKey(name: 'Data')
  ChiTietVanBanDenResponse? data;

  factory ChiTietVanBanDenDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietVanBanDenDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietVanBanDenDataResponseToJson(this);

  ChiTietVanBanDenDataResponse({this.data}); //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ChiTietVanBanDenResponse extends Equatable {
  @JsonKey(name: 'VanBanId')
  String? vanBanId;
  @JsonKey(name: 'IsDonViTrong')
  bool? isDonViTrong;
  @JsonKey(name: 'TaskId')
  String? taskId;
  @JsonKey(name: 'TaskParentId')
  String? taskParentId;
  @JsonKey(name: 'SoVanBanId')
  String? soVanBanId;
  @JsonKey(name: 'SoVanBan')
  String? soVanBan;
  @JsonKey(name: 'DonViNgoaiId')
  String? donViNgoaiId;
  @JsonKey(name: 'DonViTrongId')
  String? donViTrongId;
  @JsonKey(name: 'DonViBanHanh')
  String? donViBanHanh;
  @JsonKey(name: 'DonViVaoSoLanDauId')
  String? donViVaoSoLanDauId;
  @JsonKey(name: 'SoDen')
  int? soDen;
  @JsonKey(name: 'SoPhu')
  int? soPhu;
  @JsonKey(name: 'LoaiVanBanId')
  String? loaiVanBanId;
  @JsonKey(name: 'LoaiVanBan')
  String? loaiVanBan;
  @JsonKey(name: 'SoKyHieu')
  String? soKyHieu;
  @JsonKey(name: 'NgayBanHanh')
  String? ngayBanHanh;
  @JsonKey(name: 'NgayDen')
  String? ngayDen;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'IsChuyenCaBi')
  bool? isChuyenCaBi;
  @JsonKey(name: 'IsLanhDao')
  bool? isLanhDao;
  @JsonKey(name: 'IsThuTruongDonVi')
  bool? isThuTruongDonVi;
  @JsonKey(name: 'DoKhanId')
  String? doKhanId;
  @JsonKey(name: 'DoKhan')
  String? doKhan;
  @JsonKey(name: 'NgayHanXuLy')
  String? ngayHanXuLy;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'FileDinhKemIds')
  String? fileDinhKemIds;
  @JsonKey(name: 'FileDinhKems')
  List<FileDinhKemVanBanDenResponse>? fileDinhKems;
  @JsonKey(name: 'NguoiKy')
  String? nguoiKy;
  @JsonKey(name: 'SoBan')
  int? soBan;
  @JsonKey(name: 'SoTrang')
  int? soTrang;
  @JsonKey(name: 'PhuongThucNhanVanBanId')
  String? phuongThucNhanVanBanId;
  @JsonKey(name: 'PhuongThucNhan')
  String? phuongThucNhan;
  @JsonKey(name: 'IsQPPL')
  bool? isQPPL;
  @JsonKey(name: 'IsHoiBao')
  bool? isHoiBao;
  @JsonKey(name: 'IsNhanBanGiay')
  bool? isNhanBanGiay;
  @JsonKey(name: 'NgayNhanBanGiay')
  String? ngayNhanBanGiay;
  @JsonKey(name: 'CoTheCapNhatTrangThai')
  bool? coTheCapNhatTrangThai;
  @JsonKey(name: 'TrangThaiId')
  String? trangThaiId;
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;
  @JsonKey(name: 'CoTheXoa')
  bool? coTheXoa;
  @JsonKey(name: 'OwnerTypeCode')
  String? ownerTypeCode;
  @JsonKey(name: 'CoTheCapNhat')
  bool? coTheCapNhat;
  @JsonKey(name: 'CoTheSua')
  bool? coTheSua;
  @JsonKey(name: 'CoThePhanXuLy')
  bool? coThePhanXuLy;
  @JsonKey(name: 'CoTheTraLai')
  bool? coTheTraLai;
  @JsonKey(name: 'CoTheThuHoi')
  bool? coTheThuHoi;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'IsChoYKien')
  bool? isChoYKien;
  @JsonKey(name: 'IsDaChoYKien')
  bool? isDaChoYKien;
  @JsonKey(name: 'IsNhanDeBiet')
  bool? isNhanDeBiet;
  @JsonKey(name: 'ChoPhepThaoTac')
  bool? choPhepThaoTac;
  @JsonKey(name: 'ParentOwnerTaskId')
  String? parentOwnerTaskId;
  @JsonKey(name: 'LanhDaoId')
  String? lanhDaoId;
  @JsonKey(name: 'IsReadOnlyTaskAssignment')
  bool? isReadOnlyTaskAssignment;
  @JsonKey(name: 'CoTheTuChoi')
  bool? coTheTuChoi;
  @JsonKey(name: 'IsTrucVanBan')
  bool? isTrucVanBan;
  @JsonKey(name: 'MaPAKN')
  String? maPAKN;
  @JsonKey(name: 'CoTheNhanDaXem')
  bool? coTheNhanDaXem;
  @JsonKey(name: 'CoTheVaoSo')
  bool? coTheVaoSo;
  @JsonKey(name: 'CoTheTaoDuThao')
  bool? coTheTaoDuThao;
  @JsonKey(name: 'CoTheTaoPAKN')
  bool? coTheTaoPAKN;
  @JsonKey(name: 'CoTheXinYKien')
  bool? coTheXinYKien;
  @JsonKey(name: 'CoTheSaoChep')
  bool? coTheSaoChep;

  ChiTietVanBanDenResponse({
    this.vanBanId,
    this.isDonViTrong,
    this.taskId,
    this.taskParentId,
    this.soVanBanId,
    this.soVanBan,
    this.donViNgoaiId,
    this.donViTrongId,
    this.donViBanHanh,
    this.donViVaoSoLanDauId,
    this.soDen,
    this.soPhu,
    this.loaiVanBanId,
    this.loaiVanBan,
    this.soKyHieu,
    this.ngayBanHanh,
    this.ngayDen,
    this.trichYeu,
    this.isChuyenCaBi,
    this.isLanhDao,
    this.isThuTruongDonVi,
    this.doKhanId,
    this.doKhan,
    this.ngayHanXuLy,
    this.hanXuLy,
    this.fileDinhKemIds,
    this.fileDinhKems,
    this.nguoiKy,
    this.soBan,
    this.soTrang,
    this.phuongThucNhanVanBanId,
    this.phuongThucNhan,
    this.isQPPL,
    this.isHoiBao,
    this.isNhanBanGiay,
    this.ngayNhanBanGiay,
    this.coTheCapNhatTrangThai,
    this.trangThaiId,
    this.maTrangThai,
    this.coTheXoa,
    this.ownerTypeCode,
    this.coTheCapNhat,
    this.coTheSua,
    this.coThePhanXuLy,
    this.coTheTraLai,
    this.coTheThuHoi,
    this.nguoiTaoId,
    this.isChoYKien,
    this.isDaChoYKien,
    this.isNhanDeBiet,
    this.choPhepThaoTac,
    this.parentOwnerTaskId,
    this.lanhDaoId,
    this.isReadOnlyTaskAssignment,
    this.coTheTuChoi,
    this.isTrucVanBan,
    this.maPAKN,
    this.coTheNhanDaXem,
    this.coTheVaoSo,
    this.coTheTaoDuThao,
    this.coTheTaoPAKN,
    this.coTheXinYKien,
    this.coTheSaoChep,
  });

  factory ChiTietVanBanDenResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietVanBanDenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietVanBanDenResponseToJson(this);

  ChiTietVanBanDenModel toModel() => ChiTietVanBanDenModel(
        vanBanId: vanBanId ?? '',
        isDonViTrong: isDonViTrong ?? false,
        taskId: taskId ?? '',
        taskParentId: taskParentId ?? '',
        soVanBanId: soVanBanId ?? '',
        soVanBan: soVanBan ?? '',
        donViNgoaiId: donViNgoaiId ?? '',
        donViTrongId: donViTrongId ?? '',
        donViBanHanh: donViBanHanh ?? '',
        donViVaoSoLanDauId: donViVaoSoLanDauId ?? '',
        soDen: soDen,
        soPhu: soPhu,
        loaiVanBanId: loaiVanBanId ?? '',
        loaiVanBan: loaiVanBan ?? '',
        soKyHieu: soKyHieu ?? '',
        ngayBanHanh: ngayBanHanh ?? '',
        ngayDen: ngayDen ?? '',
        trichYeu: trichYeu?.parseHtml() ?? '',
        isChuyenCaBi: isChuyenCaBi ?? false,
        isLanhDao: isLanhDao ?? false,
        isThuTruongDonVi: isThuTruongDonVi ?? false,
        doKhanId: doKhanId ?? '',
        doKhan: doKhan ?? '',
        ngayHanXuLy: ngayHanXuLy ?? '',
        hanXuLy: hanXuLy ?? '',
        fileDinhKemIds: fileDinhKemIds ?? '',
        fileDinhKems: fileDinhKems?.map((e) => e.toModel()).toList(),
        nguoiKy: nguoiKy ?? '',
        soBan: soBan,
        soTrang: soTrang,
        phuongThucNhanVanBanId: phuongThucNhanVanBanId ?? '',
        phuongThucNhan: phuongThucNhan ?? '',
        isQPPL: isQPPL ?? false,
        isHoiBao: isHoiBao ?? false,
        isNhanBanGiay: isNhanBanGiay ?? false,
        ngayNhanBanGiay: ngayNhanBanGiay ?? '',
        coTheCapNhatTrangThai: coTheCapNhatTrangThai ?? false,
        trangThaiId: trangThaiId ?? '',
        maTrangThai: maTrangThai ?? '',
        coTheXoa: coTheXoa ?? false,
        ownerTypeCode: ownerTypeCode ?? '',
        coTheCapNhat: coTheCapNhat ?? false,
        coTheSua: coTheSua ?? false,
        coThePhanXuLy: coThePhanXuLy ?? false,
        coTheTraLai: coTheTraLai ?? false,
        coTheThuHoi: coTheThuHoi ?? false,
        nguoiTaoId: nguoiTaoId ?? '',
        isChoYKien: isChoYKien ?? false,
        isDaChoYKien: isDaChoYKien ?? false,
        isNhanDeBiet: isNhanDeBiet ?? false,
        choPhepThaoTac: choPhepThaoTac ?? false,
        parentOwnerTaskId: parentOwnerTaskId ?? '',
        lanhDaoId: lanhDaoId ?? '',
        isReadOnlyTaskAssignment: isReadOnlyTaskAssignment ?? false,
        coTheTuChoi: coTheTuChoi ?? false,
        isTrucVanBan: isTrucVanBan ?? false,
        maPAKN: maPAKN ?? '',
        coTheNhanDaXem: coTheNhanDaXem ?? false,
        coTheVaoSo: coTheVaoSo ?? false,
        coTheTaoDuThao: coTheTaoDuThao ?? false,
        coTheTaoPAKN: coTheTaoPAKN ?? false,
        coTheXinYKien: coTheXinYKien ?? false,
        coTheSaoChep: coTheSaoChep ?? false,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class FileDinhKemVanBanDenResponse extends Equatable {
  @JsonKey(name: 'STT')
  int? sTT;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IdFileGoc')
  String? idFileGoc;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'ProcessId')
  String? processId;
  @JsonKey(name: 'TaskId')
  String? taskId;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'DuoiMoRong')
  String? duoiMoRong;
  @JsonKey(name: 'DungLuong')
  String? dungLuong;
  @JsonKey(name: 'KieuDinhKem')
  String? kieuDinhKem;
  @JsonKey(name: 'IsSign')
  bool? isSign;
  @JsonKey(name: 'IsEdit')
  bool? isEdit;
  @JsonKey(name: 'QrCreated')
  bool? qrCreated;
  @JsonKey(name: 'Index')
  int? index;
  @JsonKey(name: 'NgayTao')
  String? ngayTao;

  FileDinhKemVanBanDenResponse({
    this.sTT,
    this.id,
    this.idFileGoc,
    this.nguoiTaoId,
    this.processId,
    this.taskId,
    this.ten,
    this.duongDan,
    this.duoiMoRong,
    this.dungLuong,
    this.kieuDinhKem,
    this.isSign,
    this.isEdit,
    this.qrCreated,
    this.index,
    this.ngayTao,
  });

  factory FileDinhKemVanBanDenResponse.fromJson(Map<String, dynamic> json) =>
      _$FileDinhKemVanBanDenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileDinhKemVanBanDenResponseToJson(this);

  FileDinhKemsVanBanDen toModel() => FileDinhKemsVanBanDen(
        sTT: sTT,
        id: id,
        idFileGoc: idFileGoc,
        nguoiTaoId: nguoiTaoId,
        processId: processId,
        taskId: taskId,
        ten: ten,
        duongDan: duongDan,
        duoiMoRong: duoiMoRong,
        dungLuong: dungLuong,
        kieuDinhKem: kieuDinhKem,
        isSign: isSign,
        isEdit: isEdit,
        qrCreated: qrCreated,
        index: index,
        ngayTao: ngayTao,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HoiBaoVanBanResponse {
  @JsonKey(name: 'Data')
  final List<DataHoiBaoVanBanResponse>? data;

  const HoiBaoVanBanResponse({this.data}); //todo convert to Model to use

  factory HoiBaoVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$HoiBaoVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HoiBaoVanBanResponseToJson(this);
}

@JsonSerializable()
class DataHoiBaoVanBanResponse {
  @JsonKey(name: 'Id')
  final String? id;
  @JsonKey(name: 'SoKyHieu')
  final String? soKyHieu;
  @JsonKey(name: 'TrichYeu')
  final String? trichYeu;
  @JsonKey(name: 'NguoiSoanThao')
  final String? nguoiSoanThao;
  @JsonKey(name: 'Files')
  final List<FileDinhKemVanBanDenResponse>? files;

  const DataHoiBaoVanBanResponse({
    this.id,
    this.nguoiSoanThao,
    this.trichYeu,
    this.soKyHieu,
    this.files,
  });
  factory DataHoiBaoVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$DataHoiBaoVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataHoiBaoVanBanResponseToJson(this);

  VanBanHoiBaoModel toModel() => VanBanHoiBaoModel(
        files:
            files?.map((e) => e.toModel().toFileDinhKemModel()).toList() ?? [],
        trichYeu: trichYeu?.parseHtml() ?? '',
        nguoiSoanThao: nguoiSoanThao ?? '',
        soKyHieu: soKyHieu ?? '',
        id: id ?? '',
      );
}
