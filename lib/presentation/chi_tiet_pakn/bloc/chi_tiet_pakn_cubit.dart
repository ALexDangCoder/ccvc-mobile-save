import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'chi_tiet_pakn_state.dart';

class ChiTietPaknCubit extends BaseCubit<ChiTietPaknState> {
  ChiTietPaknCubit() : super(ChiTietPaknInitial());

  ///declare variable
  final YKienNguoiDanRepository YKNDRepo = Get.find();

  final BehaviorSubject<List<List<ListRowYKND>>> tienTrinhXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

  final BehaviorSubject<List<List<ListRowYKND>>> ketQuaXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

//tab y kien xu ly
  int byteToMb = 1048576;
  int size = 0;
  String kienNghiId='';
  final List<PickImageFileModel> listPickFileMain = [];
  final List<YKienXuLyYKNDModel> listYKienXuLy = [];

  //final Set<PickImageFileModel> listYkien = {};
  List<File> listFileMain = [];
  final BehaviorSubject<String> validateNhapYkien = BehaviorSubject.seeded('');
  String mess = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;
  String idYkien = '';
  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getDanhSachYKienXuLyPAKN(idYkien);
    }
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getDanhSachYKienXuLyPAKN(idYkien);
    }
  }

  ///Function
  Future<void> getTienTrinhXyLy(String kienNghiId) async {
    tienTrinhXuLyRowData.value.clear();
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
                content: [element.ngayBatDau],
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
        error: (error) {});
  }

  Future<void> getKetQuaXuLy(String kienNghiId, String taskID) async {
    ketQuaXuLyRowData.value.clear();
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
                content: [element.trichYeu],
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
              ),
            );

            listData.add(rowData);
            ketQuaXuLyRowData.sink.add(listData);
          }
        },
        error: (error) {});
  }

  Future<void> getDanhSachYKienXuLyPAKN(String kienNghiId) async {
    showLoading();
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
        idYkien = res.danhSachKetQua?.first.kienNghiId ?? '';
      },
      error: (error) {
        emit(
          ChiTietPaknSuccess(
            CompleteType.SUCCESS,
            message: error.message,
          ),
        );
      },
    );
  }

  Future<String> postYKienXuLy({
    required String nguoiChoYKien,
    required String kienNghiId,
    required String noiDung,
    required List<File> file,
  }) async {
    String status = '';
    showLoading();
    final result = await YKNDRepo.postYKienXuLy(
      nguoiChoYKien,
      kienNghiId,
      noiDung,
      file,
    );
    result.when(
      success: (res) {
        status = 'success';
        showContent();
      },
      error: (error) {
        status = '';
        showContent();
      },
    );
    return status;
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
        // chiTietYKNDSubject.sink.add(res.chiTietYKNDModel);
        // checkIndex = res.chiTietYKNDModel.doiTuongId;
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
        final NguoiPhanAnhModel nguoiPhanAnhModel = NguoiPhanAnhModel(
          doiTuong: data.doiTuongId,
          tenCaNhan: data.tenNguoiPhanAnh,
          cmnd: data.cMTND,
          diaChiChiTiet: data.diaChiChiTiet,
          diaChiEmail: data.email,
          soDienthoai: data.soDienThoai,
        );
        // final List<DataRowChiTietKienNghi> dataRowThongTinNguoiXuLy =
        // getMapDataNguoiPhananh(nguoiPhanAnhModel);
        // _headerRowData.sink.add(listRowHeaderData);
        // _rowDataChiTietYKienNguoiDan.sink.add(
        //   ChiTietYKienNguoiDanRow(
        //     dataRowThongTinNguoiXuLy,
        //   ),
        // );
      },
      error: (err) {
        return;
      },
    );
  }
}
