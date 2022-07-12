import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/location_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/thong_tin_xy_ly_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'chi_tiet_pakn_state.dart';

enum DIACHI {
  TINHTHANHPHO,
  QUANHUYEN,
  XAPHUONG,
}

class ChiTietPaknCubit extends BaseCubit<ChiTietPaknState> {
  ChiTietPaknCubit() : super(ChiTietPaknInitial());

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
  int byteToMb = 1048576;
  int size = 0;
  final List<PickImageFileModel> listPickFileMain = [];
  final List<YKienXuLyYKNDModel> listYKienXuLy = [];

  //final Set<PickImageFileModel> listYkien = {};
  List<File> listFileMain = [];
  final BehaviorSubject<String> validateNhapYkien = BehaviorSubject.seeded('');
  String mess = '';
  bool canLoadMoreMy = false;
  bool _isRefresh = true;
  bool isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;
  String idYkien = '';

  Future<void> refreshPosts() async {
    if (!isLoading) {
      page = 0;
      _isRefresh = true;
      isLoading = true;
      await getDanhSachYKienXuLyPAKN(idYkien);
    }
  }

  void loadMorePosts() {
    if (!isLoading) {
      page += 1;
      _isRefresh = false;
      isLoading = true;
      // /getDanhSachYKienXuLyPAKN(idYkien);
    }
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
        for (final element in res) {
          final List<ListRowYKND> rowData = [];
          rowData.add(
            ListRowYKND(
              title: S.current.thoi_gian_thao_tac,
              // content: [element.ngayBatDau],
              content: [(DateTime.parse(element.ngayBatDau).formatPAKN)],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.don_vi_thao_tac,
              content: [element.donViThaoTac],
            ),
          );

          rowData.add(
            ListRowYKND(
              title: S.current.tai_khoan_thao_tac,
              content: [element.taiKhoanThaoTac],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.trang_thai_xu_ly,
              content: [element.trangThaiXuLy],
            ),
          );
          rowData.add(
            ListRowYKND(
              title: S.current.noi_dung_xu_ly,
              content: [element.noiDungXuLy],
            ),
          );
          // rowData.add(
          //   ListRowYKND(
          //     title: S.current.file_dinh_kem,
          //     content: element.taiLieus.map((e) => e.ten).toList(),
          //   ),
          // );
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
              content: [element.nguoiKyDuyet],
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
              content: [element.trangThai.toString()],
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

  Future<void> getDanhSachYKienXuLyPAKN(String kienNghiId) async {
    showLoading();
    emit(ChiTietPaknLoading());
    final Result<DanhSachKetQuaYKXLModel> result =
        await YKNDRepo.getDanhSachYKienPAKN(
      kienNghiId,
      2,
    );
    showContent();
    result.when(
      success: (res) {
        emit(
          ChiTietPaknSuccess(
            CompleteType.SUCCESS,
            list: res.danhSachKetQua,
          ),
        );
      },
      error: (error) {
        // if(error is NoNetworkException){
        //   MessageConfig.show(
        //     title: S.current.no_internet,
        //     messState: MessState.error,
        //   );
        // }
        emit(
          ChiTietPaknSuccess(
            CompleteType.SUCCESS,
            message: error.message,
          ),
        );
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
    tinhThanhPhoResponse.when(success: (success) {
      nguoiPhanAnhModel.tinhThanhPho = getTinhQuanXa(
          typeDiaChi: DIACHI.TINHTHANHPHO,
          listLocationModel: success,
          id: int.parse(nguoiPhanAnhModel.idTinhTp ?? '0'));
    }, error: (error) {
      nguoiPhanAnhModel.tinhThanhPho = '';
    });

    final quanHuyenXaResponse =
        await YKNDRepo.getLocationAddress(id: nguoiPhanAnhModel.idTinhTp);
    quanHuyenXaResponse.when(
      success: (success) {
        nguoiPhanAnhModel.quanHuyen = getTinhQuanXa(
            typeDiaChi: DIACHI.QUANHUYEN,
            listLocationModel: success,
            id: int.parse(nguoiPhanAnhModel.idQuanHuyen ?? '0'));
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
          typeDiaChi: DIACHI.XAPHUONG,
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
    required DIACHI typeDiaChi,
    int? id,
    required List<LocationModel> listLocationModel,
  }) {
    String result = '';
    switch (typeDiaChi) {
      case DIACHI.TINHTHANHPHO:
        {
          listLocationModel.forEach((element) {
            if (element.id == id) {
              result = element.name ?? '';
            }
          });
        }
        break;
      case DIACHI.QUANHUYEN:
        {
          listLocationModel.forEach((element) {
            if (element.id == id) {
              result = element.name ?? '';
            }
          });
        }
        break;
      default:
        {
          listLocationModel.forEach((element) {
            if (element.id == id) {
              result = element.name ?? '';
            }
          });
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
        error: (error) {});
    return result;
  }

  Future<String> postYKienXuLy({
    // required String nguoiChoYKien,
    required String kienNghiId,
    required String noiDung,
    required List<File> file,
  }) async {
    String status = '';
    showLoading();
    final result = await YKNDRepo.postChoYKienYKienXuLy(
      //  nguoiChoYKien,
      kienNghiId,
      noiDung,
      file,
    );
    result.when(
      success: (res) {
        status = 'success';
        showContent();
        isLoading = false;
        refreshPosts();
      },
      error: (error) {
        status = '';
        showContent();
        isLoading = false;
        refreshPosts();
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
          for (final element in data.fileDinhKem) {
            listFileName.add(element.tenFile);
            listUrlFile.add(element.duongDan);
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
        // listRowHeaderData.add(
        //   ListRowYKND(
        //     title: S.current.lien_quan_quy_dinh,
        //     content: [data.tenLuat],
        //   ),
        // );

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
          for (final element in data.fileDinhKem) {
            listFileName.add(element.tenFile);
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
              content: listFileName),
        );
        headerRowData.sink.add(listRowHeaderData);
      },
      error: (err) {
        return;
      },
    );
  }

  List<DataRowChiTietKienNghi> getMapDataNguoiPhananh(
      NguoiPhanAnhModel nguoiPhanAnhModel) {
    final List<DataRowChiTietKienNghi> listData = [];
    listData.add(
      DataRowChiTietKienNghi(
          title: S.current.doi_tuong_nop,
          content: nguoiPhanAnhModel.doiTuongNop ?? ''),
    );
    listData.add(
      DataRowChiTietKienNghi(
          title: S.current.ten_ca_nhan_tc_full,
          content: nguoiPhanAnhModel.tenCaNhan ?? ''),
    );
    listData.add(
      DataRowChiTietKienNghi(
          title: S.current.cmt_can_cuoc, content: nguoiPhanAnhModel.cmnd ?? ''),
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
}
