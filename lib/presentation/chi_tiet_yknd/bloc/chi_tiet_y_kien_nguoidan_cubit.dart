import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'chi_tiet_y_kien_nguoidan_state.dart';

class ChiTietYKienNguoiDanCubit extends BaseCubit<ChiTietYKienNguoiDanState> {
  ChiTietYKienNguoiDanCubit() : super(CHiTietYKienNguoiDanStateInitial());

  final BehaviorSubject<List<DataRowChiTietKienNghi>> _headerChiTiet =
      BehaviorSubject<List<DataRowChiTietKienNghi>>();

  final BehaviorSubject<ChiTietYKNDModel> chiTietYKNDSubject =
      BehaviorSubject<ChiTietYKNDModel>();

  final BehaviorSubject<ChiTietYKienNguoiDanRow> _rowDataChiTietYKienNguoiDan =
      BehaviorSubject<ChiTietYKienNguoiDanRow>();

  Stream<ChiTietYKienNguoiDanRow> get rowDataChiTietYKienNguoiDan =>
      _rowDataChiTietYKienNguoiDan.stream;

  final BehaviorSubject<List<YKienXuLyYKNDModel>> _yKienXuLyYkndSubject =
      BehaviorSubject<List<YKienXuLyYKNDModel>>();

  final BehaviorSubject<List<ListRowYKND>> _headerRowData =
      BehaviorSubject<List<ListRowYKND>>();

  final BehaviorSubject<List<List<ListRowYKND>>> _tienTrinhXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

  final BehaviorSubject<List<List<ListRowYKND>>> _ketQuaXuLyRowData =
      BehaviorSubject<List<List<ListRowYKND>>>();

  Stream<List<List<ListRowYKND>>> get tienTrinhXuLyRowData =>
      _tienTrinhXuLyRowData.stream;

  Stream<List<List<ListRowYKND>>> get ketQuaXuLyRowData =>
      _ketQuaXuLyRowData.stream;

  Stream<List<ListRowYKND>> get headerRowData => _headerRowData.stream;

  Stream<List<YKienXuLyYKNDModel>> get yKienXuLyYkndStream =>
      _yKienXuLyYkndSubject.stream;

  Stream<List<DataRowChiTietKienNghi>> get headerChiTiet =>
      _headerChiTiet.stream;
  int checkIndex = -1;

  Stream<ChiTietYKNDModel> get chiTietYKND => chiTietYKNDSubject.stream;

  Map<String, String> mapData = {};
  final List<DataRowChiTietKienNghi> listData = [];

  List<DataRowChiTietKienNghi> dataRowHeader = [];
  String yKienXuLy = '';

  final List<ListRowYKND> listInitDataHeader = [
    ListRowYKND(title: S.current.tieu_de, content: []),
    ListRowYKND(title: S.current.noi_dung, content: []),
    ListRowYKND(title: S.current.nguon_pakn, content: []),
    ListRowYKND(title: S.current.phan_loai_pakn, content: []),
    ListRowYKND(title: S.current.ngay_phan_anh, content: []),
    ListRowYKND(title: S.current.lien_quan_quy_dinh, content: []),
    ListRowYKND(title: S.current.tai_lieu_dinh_kem_cong_dan, content: []),
  ];

  List<DataRowChiTietKienNghi> getMapDataKetQuaXuLy(KetQuaXuLy ketQuaXuLy) {
    final List<DataRowChiTietKienNghi> listData = [];
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.noi_dung_xu_ly,
        content: ketQuaXuLy.noiDungXuLy ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.file_dinh_kem,
        content: ketQuaXuLy.fileDinhKem ?? '',
      ),
    );
    return listData;
  }

  List<DataRowChiTietKienNghi> getMapDataThongTinXuLy(
      ThongTinXuLy thongTinXuLy) {
    final List<DataRowChiTietKienNghi> listData = [];
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.nhap_ten_don_vi_phong_ban,
        content: thongTinXuLy.tenDonVi ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.vai_tro,
        content: thongTinXuLy.vaiTro ?? '',
      ),
    );
    return listData;
  }

  List<DataRowChiTietKienNghi> getMapDataNguoiPhananh(
      NguoiPhanAnhModel nguoiPhanAnhModel) {
    final List<DataRowChiTietKienNghi> listData = [];
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
    return listData;
  }

  List<DataRowChiTietKienNghi> getMapDataHeader(
      HeaderChiTietYKNDModel dataHeader) {
    listData.add(
      DataRowChiTietKienNghi(
          title: S.current.tieu_de, content: dataHeader.tieuDe ?? ''),
    );
    listData.add(
      DataRowChiTietKienNghi(
          title: S.current.noidung, content: dataHeader.noiDung ?? ''),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.nguon_pakn,
        content: dataHeader.nguonPAKN ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.phan_loai_pakn,
        content: dataHeader.phanLoaiPAKN ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.ngay_phan_anh,
        content: dataHeader.ngayPhanAnh ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.han_xu_ly,
        content: dataHeader.hanXuLy ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.lien_quan_quy_dinh,
        content: dataHeader.quyDinhLuat ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.tai_lieu_dinh_kem_cong_dan,
        content: dataHeader.taiLieuCongDan ?? '',
      ),
    );
    return listData;
  }

  final YKienNguoiDanRepository _YKNDRepo = Get.find();

  Future<void> getchiTietYKienNguoiDan(
    String kienNghiId,
    String taskId,
  ) async {
    showLoading();
    final result = await _YKNDRepo.chiTietYKienNguoiDan(
      kienNghiId,
      taskId,
    );
    showContent();
    result.when(
      success: (res) {
        chiTietYKNDSubject.sink.add(res.chiTietYKNDModel);
        checkIndex = res.chiTietYKNDModel.doiTuongId;
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
        _headerRowData.sink.add(listRowHeaderData);
        _rowDataChiTietYKienNguoiDan.sink.add(
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

  Future<void> getDanhSachYKienXuLyPAKN(String kienNghiId) async {
    showLoading();
    final result = await _YKNDRepo.getDanhSachYKienPAKN(
      kienNghiId: kienNghiId,
      type: 2,
    );
    showContent();
    result.when(
        success: (res) {
          _yKienXuLyYkndSubject.sink.add(res.danhSachKetQua ?? []);
        },
        error: (error) {});
  }

  Future<void> getTienTrinhXyLy(String kienNghiId) async {
    showLoading();
    final result = await _YKNDRepo.tienTrinhXuLy(
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
            _tienTrinhXuLyRowData.sink.add(listData);
          }
        },
        error: (error) {});
  }

  Future<void> getKetQuaXuLy(String kienNghiId, String taskID) async {
    showLoading();
    final result = await _YKNDRepo.ketQuaXuLy(
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
            _ketQuaXuLyRowData.sink.add(listData);
          }
        },
        error: (error) {});
  }
}
