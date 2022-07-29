import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/location_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

enum DiaChi {
  TINH_THANH_PHO,
  QUAN_HUYEN,
  XA_PHUONG,
}

class ChiTietPaknCubit extends BaseCubit<BaseState> {
  ChiTietPaknCubit() : super(ChiTietPAKNStateInitial());

  ///declare variable
  final YKienNguoiDanRepository YKNDRepo = Get.find();

  final BehaviorSubject<List<List<ListRowYKND>>> tienTrinhXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

  BehaviorSubject<ThongTinXuLyPAKNModel> listThongTinXuLy =
      BehaviorSubject<ThongTinXuLyPAKNModel>();

  final BehaviorSubject<List<List<ListRowYKND>>> ketQuaXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

  final BehaviorSubject<List<ListRowYKND>> headerRowData =
      BehaviorSubject<List<ListRowYKND>>();

  final BehaviorSubject<ChiTietYKienNguoiDanRow> rowDataChiTietYKienNguoiDan =
      BehaviorSubject<ChiTietYKienNguoiDanRow>();

  final BehaviorSubject<ChiTietYKNDModel> chiTietYKNDSubject =
      BehaviorSubject<ChiTietYKNDModel>();

//tab y kien xu ly
  static const int MAX_MB = 20;
  List<int> sizeFileList = [];
  int sizeFile = 0;
  final List<PickImageFileModel> listPickFileMain = [];
  final List<YKienXuLyYKNDModel> listYKienXuLy = [];

  List<File> listFileMain = [];
  final BehaviorSubject<String> validateNhapYkien = BehaviorSubject.seeded('');
  String mess = '';
  String idYkienParam = '';

  void deleteFile(PickImageFileModel objPick) {
    for (int i = 0; i < listPickFileMain.length; i++) {
      if (objPick == listPickFileMain[i]) {
        listFileMain.removeAt(i);
        sizeFileList.removeAt(i);
      }
    }
    listPickFileMain.remove(objPick);
  }

  bool checkMaxSize() {
    sizeFile = 0;
    for (final int value in sizeFileList) {
      sizeFile += value;
    }
    return sizeFile / BYTE_TO_MB > MAX_MB;
  }

  ///Function
  Future<void> getTienTrinhXyLy(String kienNghiId) async {
    if (tienTrinhXuLyRowData.hasValue) {
      tienTrinhXuLyRowData.value.clear();
    } else {}
    showLoading();
    final result = await YKNDRepo.tienTrinhXuLy(
      kienNghiId,
    );
    showContent();
    result.when(
      success: (res) {
        final List<List<ListRowYKND>> listData = [];
        for (final value in res) {
          final List<ListRowYKND> rowData = [];
          rowData.add(
            ListRowYKND(
              title: S.current.thoi_gian_thao_tac,
              content: [(DateTime.parse(value.ngayBatDau).formatPAKN)],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.nguoi_thao_tac,
              content: ['${value.nguoiThaoTac} - ${value.donViThaoTac}'],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.tai_khoan_thao_tac,
              content: [value.taiKhoanThaoTac],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.trang_thai_xu_ly,
              // content: [getTextByStatus(value.trangThaiXuLy)],
              content: [value.trangThaiXuLy],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.noi_dung_xu_ly,
              content: [value.noiDungXuLy],
            ),
          );
          listData.add(rowData);
          tienTrinhXuLyRowData.sink.add(listData);
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> getKetQuaXuLy(String kienNghiId, String taskID) async {
    if (ketQuaXuLyRowData.hasValue) {
      ketQuaXuLyRowData.value.clear();
    } else {}
    showLoading();
    final result = await YKNDRepo.ketQuaXuLy(
      kienNghiId,
      taskID,
    );
    showContent();
    result.when(
      success: (res) {
        final List<List<ListRowYKND>> listData = [];
        for (final element in res) {
          final List<ListRowYKND> rowData = [];
          rowData.add(
            ListRowYKND(
              title: S.current.chuyen_vien_xu_ly,
              content: [element.tenCanBo],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.don_vi_xu_ly,
              content: [element.tenDonVi],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.vai_tro_xu_ly,
              content: element.isChuTri
                  ? [S.current.chu_tri]
                  : [S.current.chuyen_vien],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.trang_thai_xu_ly,
              content: [getTextByStatus(element.trangThai.toString())],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.noi_dung_xu_ly,
              content: [element.taskContent.parseHtml()],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.so_hieu_van_ban,
              content: [element.soVanBanDi],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.so_hieu_van_ban,
              content: [element.soVanBanDi],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.ngay_ban_hanh,
              content: [element.ngayKyVanBanDi],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.trich_yeu,
              content: [element.trichYeu.parseHtml()],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.co_quan_ban_hanh,
              content: [element.coQuanBanHanh],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.file_dinh_kem,
              content: element.dSFile.map((e) => e.ten).toList(),
              urlDownload: element.dSFile.map((e) => e.duongDan).toList(),
              nameFile: element.dSFile.map((e) => e.ten).toList(),
            ),
          );
          listData.add(rowData);
          ketQuaXuLyRowData.sink.add(listData);
        }
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> getDanhSachYKienXuLyPAKN() async {
    showLoading();
    final Result<DanhSachKetQuaYKXLModel> result =
        await YKNDRepo.getDanhSachYKienPAKN(
      kienNghiId: idYkienParam,
      type: TypeTaskYKien.ChoYKien,
    );
    showContent();
    result.when(
      success: (res) {
        if (res.danhSachKetQua?.isEmpty ?? false) {
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
          showContent();
        } else {
          emit(
            CompletedLoadMore(
              CompleteType.SUCCESS,
              posts: res.danhSachKetQua,
            ),
          );
          showContent();
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  String getDoiTuongNop(int id) {
    switch (id) {
      case 1:
        return S.current.ca_nhan;
      case 2:
        return S.current.doanh_nghiep;
      case 3:
        return S.current.to_chuc;
      default:
        return S.current.co_quan_nha_muoc;
    }
  }

  Future<void> getThongTinNguoiPhanAnh(
    String kienNghiId,
    String taskId,
  ) async {
    showLoading();
    final result = await YKNDRepo.chiTietYKienNguoiDan(
      kienNghiId,
      taskId,
    );
    if (rowDataChiTietYKienNguoiDan.hasValue) {
      rowDataChiTietYKienNguoiDan.value = ChiTietYKienNguoiDanRow([]);
    } else {}
    final NguoiPhanAnhModel nguoiPhanAnhModel = NguoiPhanAnhModel();
    result.when(
      success: (res) {
        final data = res.chiTietYKNDModel;
        nguoiPhanAnhModel.doiTuongNop = getDoiTuongNop(data.doiTuongId);
        nguoiPhanAnhModel.idTinhTp = data.tinhId.toString();
        nguoiPhanAnhModel.idXaPhuong = data.xaId.toString();
        nguoiPhanAnhModel.idQuanHuyen = data.huyenId.toString();
        nguoiPhanAnhModel.doiTuong = data.doiTuongId;
        nguoiPhanAnhModel.tenCaNhan = data.tenNguoiPhanAnh;
        nguoiPhanAnhModel.cmnd = data.cMTND;
        nguoiPhanAnhModel.diaChiChiTiet = data.diaChiChiTiet;
        nguoiPhanAnhModel.diaChiEmail = data.email;
        nguoiPhanAnhModel.soDienthoai = data.soDienThoai;
      },
      error: (err) {
        return;
      },
    );

    final tinhThanhPhoResponse = await YKNDRepo.getLocationAddress();
    tinhThanhPhoResponse.when(
      success: (success) {
        nguoiPhanAnhModel.tinhThanhPho = getTinhQuanXa(
          typeDiaChi: DiaChi.TINH_THANH_PHO,
          listLocationModel: success,
          id: int.parse(nguoiPhanAnhModel.idTinhTp ?? '0'),
        );
      },
      error: (error) {
        nguoiPhanAnhModel.tinhThanhPho = '';
      },
    );

    final quanHuyenXaResponse =
        await YKNDRepo.getLocationAddress(id: nguoiPhanAnhModel.idTinhTp);
    quanHuyenXaResponse.when(
      success: (success) {
        nguoiPhanAnhModel.quanHuyen = getTinhQuanXa(
          typeDiaChi: DiaChi.QUAN_HUYEN,
          listLocationModel: success,
          id: int.parse(nguoiPhanAnhModel.idQuanHuyen ?? '0'),
        );
      },
      error: (error) {
        nguoiPhanAnhModel.quanHuyen = '';
      },
    );

    final xaPhuongResponse =
        await YKNDRepo.getLocationAddress(id: nguoiPhanAnhModel.idQuanHuyen);
    xaPhuongResponse.when(
      success: (success) {
        nguoiPhanAnhModel.xaPhuong = getTinhQuanXa(
          typeDiaChi: DiaChi.XA_PHUONG,
          listLocationModel: success,
          id: int.parse(nguoiPhanAnhModel.idXaPhuong ?? '0'),
        );
      },
      error: (error) {
        nguoiPhanAnhModel.xaPhuong = '';
      },
    );

    final List<DataRowChiTietKienNghi> dataRowThongTinNguoiXuLy =
        getMapDataNguoiPhananh(nguoiPhanAnhModel);
    rowDataChiTietYKienNguoiDan.sink.add(
      ChiTietYKienNguoiDanRow(
        dataRowThongTinNguoiXuLy,
      ),
    );
    showContent();
  }

  String getTinhQuanXa({
    required DiaChi typeDiaChi,
    int? id,
    required List<LocationModel> listLocationModel,
  }) {
    String result = '';
    switch (typeDiaChi) {
      case DiaChi.TINH_THANH_PHO:
        {
          for (final value in listLocationModel) {
            if (value.id == id) {
              result = value.name ?? '';
            }
          }
        }
        break;
      case DiaChi.QUAN_HUYEN:
        {
          for (final value in listLocationModel) {
            if (value.id == id) {
              result = value.name ?? '';
            }
          }
        }
        break;
      default:
        {
          for (final value in listLocationModel) {
            if (value.id == id) {
              result = value.name ?? '';
            }
          }
        }
        break;
    }
    return result;
  }

  Future<List<LocationModel>> getLocationThongTinNguoiPAKN({String? id}) async {
    List<LocationModel> result = [];
    final resultResponse = await YKNDRepo.getLocationAddress(id: id);
    resultResponse.when(
      success: (success) {
        result = success;
      },
      error: (error) {},
    );
    return result;
  }

  Future<bool> postYKienXuLy({
    required String kienNghiId,
    required String noiDung,
    required List<File> file,
  }) async {
    bool status = false;
    showLoading();
    final result = await YKNDRepo.postChoYKienYKienXuLy(
      kienNghiId,
      noiDung,
      file,
    );
    result.when(
      success: (res) {
        status = true;
        showContent();
      },
      error: (error) {
        status = false;
        showContent();
      },
    );
    return status;
  }

  Future<void> getThongTinXuLyPAKN(String kienNghiId, String taskId) async {
    if (listThongTinXuLy.hasValue) {
      listThongTinXuLy.value.donViDuocPhanXuLy?.clear();
    } else {}
    showLoading();
    final result = await YKNDRepo.thongTinXuLyPAKN(kienNghiId, taskId);
    result.when(
      success: (success) {
        showContent();
        listThongTinXuLy.sink.add(success);
      },
      error: (error) {
        showContent();
        listThongTinXuLy.sink.add(ThongTinXuLyPAKNModel.seeded());
      },
    );
  }

  Future<void> getThongTinPAKN(
    String kienNghiId,
    String taskId,
  ) async {
    if (headerRowData.hasValue) {
      headerRowData.value.clear();
    } else {}

    showLoading();
    final result = await YKNDRepo.chiTietYKienNguoiDan(
      kienNghiId,
      taskId,
    );
    showContent();
    result.when(
      success: (res) {
        chiTietYKNDSubject.sink.add(res.chiTietYKNDModel);
        final data = res.chiTietYKNDModel;
        final List<String> listFileName = [];
        final List<String> listUrlFile = [];
        if (data.fileDinhKem.isNotEmpty) {
          for (final value in data.fileDinhKem) {
            listFileName.add(value.tenFile);
            listUrlFile.add(value.duongDan);
          }
        }
        final List<ListRowYKND> listRowHeaderData = [];
        listRowHeaderData
            .add(ListRowYKND(title: S.current.tieu_de, content: [data.tieuDe]));
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.just_noi_dung,
            content: [data.noiDung],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.nguon_pakn,
            content: [data.tenNguonPAKN],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.phan_loai,
            content: [data.phanLoaiPAKN],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.linh_vuc,
            content: [data.linhVucPaknTen],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.ngay_phan_anh,
            content: [data.ngayPhanAnh],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.han_xu_ly,
            content: [data.hanXuLy],
          ),
        );

        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.tai_lieu_dinh_kem_cong_dan,
            content: listFileName,
            nameFile: listFileName,
            urlDownload: listUrlFile,
          ),
        );
        headerRowData.sink.add(listRowHeaderData);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getchiTietYKienNguoiDan(
    String kienNghiId,
    String taskId,
  ) async {
    showLoading();
    final result = await YKNDRepo.chiTietYKienNguoiDan(
      kienNghiId,
      taskId,
    );
    showContent();
    result.when(
      success: (res) {
        chiTietYKNDSubject.sink.add(res.chiTietYKNDModel);
        final data = res.chiTietYKNDModel;
        final List<String> listFileName = [];
        if (data.fileDinhKem.isNotEmpty) {
          for (final value in data.fileDinhKem) {
            listFileName.add(value.tenFile);
          }
        }
        final List<ListRowYKND> listRowHeaderData = [];
        listRowHeaderData
            .add(ListRowYKND(title: S.current.tieu_de, content: [data.tieuDe]));
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.noi_dung,
            content: [data.noiDung],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.nguon_pakn,
            content: [data.tenNguonPAKN],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.phan_loai_pakn,
            content: [data.phanLoaiPAKN],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.ngay_phan_anh,
            content: [data.ngayPhanAnh],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.han_xu_ly,
            content: [data.hanXuLy],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.lien_quan_quy_dinh,
            content: [data.tenLuat],
          ),
        );
        listRowHeaderData.add(
          ListRowYKND(
            title: S.current.tai_lieu_dinh_kem_cong_dan,
            content: listFileName,
          ),
        );
        headerRowData.sink.add(listRowHeaderData);
      },
      error: (err) {
        return;
      },
    );
  }

  List<DataRowChiTietKienNghi> getMapDataNguoiPhananh(
    NguoiPhanAnhModel nguoiPhanAnhModel,
  ) {
    final List<DataRowChiTietKienNghi> listData = [];
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.doi_tuong_nop,
        content: nguoiPhanAnhModel.doiTuongNop ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.ten_ca_nhan_tc_full,
        content: nguoiPhanAnhModel.tenCaNhan ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.cmt_can_cuoc,
        content: nguoiPhanAnhModel.cmnd ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.dia_chi_mail,
        content: nguoiPhanAnhModel.diaChiEmail ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.so_dien_thoai,
        content: nguoiPhanAnhModel.soDienthoai ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.dia_chi_chi_tiet,
        content: nguoiPhanAnhModel.diaChiChiTiet ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.tinh_cheo_thanh_pho,
        content: nguoiPhanAnhModel.tinhThanhPho ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.quan_cheo_huyen,
        content: nguoiPhanAnhModel.quanHuyen ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.xa_cheo_phuong,
        content: nguoiPhanAnhModel.xaPhuong ?? '',
      ),
    );
    return listData;
  }

  String getTextByStatus(String status) {
    switch (status) {
      case ChoTiepNhan:
        return S.current.cho_tiep_nhan;
      case ChoChuyenXuLy:
        return S.current.cho_chuyen_xu_ly;
      case ChoTiepNhanXuLy:
        return S.current.cho_tiep_nhan_xu_ly;
      case ChoPhanCongXuLy:
        return S.current.cho_phan_cong_xu_ly;
      case ChoDonViDuyet:
        return S.current.cho_don_vi_duyet;
      case ChoBoDuyet:
        return S.current.cho_bo_duyet;
      case ChoDuyet:
        return S.current.cho_duyet;
      case ChoChuyenDonVi:
        return S.current.cho_chuyen_don_vi;
      case DaHoanThanh:
        return S.current.da_hoan_thanh;
      case ChoBoSungThongTin:
        return S.current.cho_bo_sung_thong_tin;
      case TuChoiTiepNhan:
        return S.current.tu_choi_tiep_nhan;
      case HuyBo:
        return S.current.huy_bo;
      case ChoXuLy:
        return S.current.cho_xu_ly;
      case ChoDuyetChuyenDonViXuLy:
        return S.current.cho_duyet_chuyen_dv_xu_ly;
      case ChoXacNhanChuyenDonViXuLy:
        return S.current.cho_xac_nhan;
      case HuyTrinh:
        return S.current.huy_trinh;
      case HuyDuyet:
        return S.current.huy_duyet;
      case ThuHoi:
        return S.current.thu_hoi;
      case ChoDuyetYCPH:
        return S.current.cho_duyet;
      case ChuyenXuLy:
        return S.current.chuyen_xu_ly;
      case DaPhanCong:
        return S.current.da_phan_cong;
      case PhanXuLy:
        return S.current.phan_xu_ly;
      case DangXuLy:
        return S.current.dang_xu_ly;
      default:
        return S.current.cho_nguoi_dan_bo_sung_thong_tin;
    }
  }

  static const String ChoTiepNhan = '1';
  static const String ChoChuyenXuLy = '2';
  static const String ChoTiepNhanXuLy = '3';
  static const String ChoPhanCongXuLy = '4,12';
  static const String ChoDonViDuyet = '5';
  static const String ChoBoDuyet = '6';
  static const String ChoDuyet = '6,13,18';
  static const String ChoChuyenDonVi = '7';
  static const String DaHoanThanh = '8';
  static const String ChoBoSungThongTin = '9,22';
  static const String TuChoiTiepNhan = '10';
  static const String HuyBo = '11';
  static const String ChoXuLy = '12';
  static const String ChoDuyetChuyenDonViXuLy = '13';
  static const String ChoXacNhanChuyenDonViXuLy = '14';
  static const String HuyTrinh = '15';
  static const String HuyDuyet = '16';
  static const String ThuHoi = '17';
  static const String ChoDuyetYCPH = '18';
  static const String ChuyenXuLy = '19';
  static const String DaPhanCong = '20';
  static const String PhanXuLy = '21';
  static const String DangXuLy = '3,4,12';
  static const String ChoNguoiDanBoSungThongTin = '22';
}
