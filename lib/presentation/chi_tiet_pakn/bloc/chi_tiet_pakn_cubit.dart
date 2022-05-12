import 'package:bloc/bloc.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/ket_qua_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
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

  final BehaviorSubject<List<ListRowYKND>> headerRowData =
      BehaviorSubject<List<ListRowYKND>>();

  final BehaviorSubject<ChiTietYKienNguoiDanRow> rowDataChiTietYKienNguoiDan =
      BehaviorSubject<ChiTietYKienNguoiDanRow>();

  final BehaviorSubject<ChiTietYKNDModel> chiTietYKNDSubject =
      BehaviorSubject<ChiTietYKNDModel>();

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
    if(ketQuaXuLyRowData.hasValue) {
      ketQuaXuLyRowData.value.clear();
    } else {

    }
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

  Future<void> getThongTinNguoiPhanAnh(String kienNghiId,
      String taskId,) async {

    showLoading();
    final result = await YKNDRepo.chiTietYKienNguoiDan(
      kienNghiId,
      taskId,
    );
    showContent();
    result.when(
      success: (res) {
        final data = res.chiTietYKNDModel;
        final NguoiPhanAnhModel nguoiPhanAnhModel = NguoiPhanAnhModel(
          doiTuong: data.doiTuongId,
          tenCaNhan: data.tenNguoiPhanAnh,
          cmnd: data.cMTND,
          diaChiChiTiet: data.diaChiChiTiet,
          diaChiEmail: data.email,
          soDienthoai: data.soDienThoai,
        );
        final List<DataRowChiTietKienNghi> dataRowThongTinNguoiXuLy =
        getMapDataNguoiPhananh(nguoiPhanAnhModel);
        rowDataChiTietYKienNguoiDan.sink.add(
          ChiTietYKienNguoiDanRow(
            dataRowThongTinNguoiXuLy,
          ),
        );
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> getThongTinPAKN(
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
        final NguoiPhanAnhModel nguoiPhanAnhModel = NguoiPhanAnhModel(
          doiTuong: data.doiTuongId,
          tenCaNhan: data.tenNguoiPhanAnh,
          cmnd: data.cMTND,
          diaChiChiTiet: data.diaChiChiTiet,
          diaChiEmail: data.email,
          soDienthoai: data.soDienThoai,
        );
        final List<DataRowChiTietKienNghi> dataRowThongTinNguoiXuLy =
            getMapDataNguoiPhananh(nguoiPhanAnhModel);
        headerRowData.sink.add(listRowHeaderData);
        rowDataChiTietYKienNguoiDan.sink.add(
          ChiTietYKienNguoiDanRow(
            dataRowThongTinNguoiXuLy,
          ),
        );
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
          title: S.current.ten_ca_nhan_tc,
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
    return listData;
  }
}
