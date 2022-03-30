import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/domain/repository/y_kien_nguoi_dan/y_kien_nguoi_dan_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import 'chi_tiet_y_kien_nguoidan_state.dart';

class ChiTietYKienNguoiDanCubit extends BaseCubit<ChiTietYKienNguoiDanState> {
  ChiTietYKienNguoiDanCubit() : super(CHiTietYKienNguoiDanStateInitial());

  final BehaviorSubject<List<DataRowChiTietKienNghi>> _headerChiTiet =
      BehaviorSubject<List<DataRowChiTietKienNghi>>();

  final BehaviorSubject<ChiTietYKNDModel> _chiTietYKND =
      BehaviorSubject<ChiTietYKNDModel>();

  final BehaviorSubject<ChiTietYKienNguoiDanRow> _rowDataChiTietYKienNguoiDan =
      BehaviorSubject<ChiTietYKienNguoiDanRow>();

  Stream<ChiTietYKienNguoiDanRow> get rowDataChiTietYKienNguoiDan =>
      _rowDataChiTietYKienNguoiDan.stream;

  Stream<List<DataRowChiTietKienNghi>> get headerChiTiet =>
      _headerChiTiet.stream;
  int checkIndex = -1;

  Stream<ChiTietYKNDModel> get chiTietYKND => _chiTietYKND.stream;

  Map<String, String> mapData = {};
  final List<DataRowChiTietKienNghi> listData = [];

  List<DataRowChiTietKienNghi> dataRowHeader = [];

  String yKienXuLy = '';
  final fakeDataHeadler = HeaderChiTietYKNDModel(
    tieuDe:
        'Làm nhân viên văn phòng thất nghiệp gần 4 tháng nhưng chưa được nhận hỗ trợ do dịch Covid19',
    noiDung:
        'Làm nhân viên văn phòng thất nghiệp gần 4 tháng nhưng chưa được nhận hỗ trợ do dịch Covid19',
    nguonPAKN: 'App người dân',
    phanLoaiPAKN: 'Cơ chế của chính sách',
    ngayPhanAnh: '22/10/2021',
    hanXuLy: '22/10/2021',
    quyDinhLuat: 'Luật Tổ chức Chính phủ',
    taiLieuCongDan: '',
  );
  final fakeDataNguoiPhanAnh = NguoiPhanAnhModel(
    doiTuong: 0,
    tenCaNhan: 'PAKN 2',
    cmnd: '017496898',
    diaChiEmail: 'chuyenviendonvi@gmail.com',
    soDienthoai: '0964950763',
    diaChiChiTiet:
        'Khu phố 6, Phường Trung Dũng, Thành phố Biên Hòa - Đồng Nai',
  );
  final fakeThongTinXuLY = ThongTinXuLy(
    tenDonVi: 'UBND Đồng Nai',
    vaiTro: 'Chuyên viên',
  );
  final fakeKetQuaXuLy = KetQuaXuLy(
    yKienXuLy: 'Giám sát tiến độ',
    thoiGianThaoTac: '23:27 16/09/2021',
    donViThaoTac: 'UBND Đồng Nai',
    taiKhoanThaoTac: 'Chuyên viên',
    trangThaiXuLy: 'Đã tạo PAKN',
    noiDungXuLy: 'Không có',
    fileDinhKem: 'file.pdf',
  );

  List<DataRowChiTietKienNghi> getMapDataKetQuaXuLy(KetQuaXuLy ketQuaXuLy) {
    yKienXuLy = fakeKetQuaXuLy.yKienXuLy ?? '';
    final List<DataRowChiTietKienNghi> listData = [];
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.thoi_gian_thao_tac,
        content: ketQuaXuLy.thoiGianThaoTac ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.don_vi_thao_tac,
        content: ketQuaXuLy.donViThaoTac ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.tai_khoan_thao_tac,
        content: ketQuaXuLy.taiKhoanThaoTac ?? '',
      ),
    );
    listData.add(
      DataRowChiTietKienNghi(
        title: S.current.trang_thai_xu_ly,
        content: ketQuaXuLy.trangThaiXuLy ?? '',
      ),
    );
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
        checkIndex = res.chiTietYKNDModel.doiTuongId;
        final data = res.chiTietYKNDModel;
        String listFile='';
        if(data.fileDinhKem.isNotEmpty){
           final List<String>listFileName=[];
           for (final element in data.fileDinhKem) {
             listFileName.add(element.tenFile);
           }
           listFile = listFileName.join('\n');
        }
        final HeaderChiTietYKNDModel headerChiTietYKNDModel =
            HeaderChiTietYKNDModel(
          tieuDe: data.tieuDe,
          noiDung: data.noiDung,
          nguonPAKN: data.tenNguonPAKN,
          phanLoaiPAKN: data.phanLoaiPAKN,
          ngayPhanAnh: data.ngayPhanAnh,
          hanXuLy: data.hanXuLy,
          quyDinhLuat: data.tenLuat,
          taiLieuCongDan: listFile,
        );
        dataRowHeader = getMapDataHeader(headerChiTietYKNDModel);
        final NguoiPhanAnhModel nguoiPhanAnhModel = NguoiPhanAnhModel(
          doiTuong: data.doiTuongId,
          tenCaNhan: data.tenNguoiPhanAnh,
          cmnd: data.cMTND,
          diaChiChiTiet: data.diaChiChiTiet,
          diaChiEmail: data.email,
          soDienthoai: data.soDienThoai,
        );
        List<DataRowChiTietKienNghi> dataRowThongTinNguoiXuLy =
            getMapDataNguoiPhananh(nguoiPhanAnhModel);

        final ThongTinXuLy thongTinXuLy = ThongTinXuLy(
          tenDonVi: data.donViDuocPhanXuLy,
          vaiTro: data.donViDuocPhanXuLy,
        );
        List<DataRowChiTietKienNghi> dataRowThongTinXuLy =
            getMapDataThongTinXuLy(thongTinXuLy);

        final KetQuaXuLy ketQuaXuLy = KetQuaXuLy(
          yKienXuLy: data.yKienChiDao,
          thoiGianThaoTac: data.donViDuocPhanXuLy,
          donViThaoTac: data.donViDuocPhanXuLy,
          taiKhoanThaoTac: data.donViDuocPhanXuLy,
          trangThaiXuLy: data.donViDuocPhanXuLy,
          noiDungXuLy: data.donViDuocPhanXuLy,
          fileDinhKem: data.donViDuocPhanXuLy,
        );
        List<DataRowChiTietKienNghi> dataRowKetQuaXuLy =
            getMapDataKetQuaXuLy(ketQuaXuLy);

        final KetQuaXuLy tienTrinhXuLy = KetQuaXuLy(
          yKienXuLy: data.yKienChiDao,
          thoiGianThaoTac: data.donViDuocPhanXuLy,
          donViThaoTac: data.donViDuocPhanXuLy,
          taiKhoanThaoTac: data.donViDuocPhanXuLy,
          trangThaiXuLy: data.donViDuocPhanXuLy,
          noiDungXuLy: data.donViDuocPhanXuLy,
          fileDinhKem: data.donViDuocPhanXuLy,
        );
        List<DataRowChiTietKienNghi> dataRowTienTrinhXuLy =
            getMapDataKetQuaXuLy(tienTrinhXuLy);

        _rowDataChiTietYKienNguoiDan.sink.add(
          ChiTietYKienNguoiDanRow(
            dataRowHeader,
            dataRowThongTinNguoiXuLy,
            dataRowThongTinXuLy,
            dataRowKetQuaXuLy,
            dataRowTienTrinhXuLy,
          ),
        );
      },
      error: (err) {
        return;
      },
    );
  }
}
