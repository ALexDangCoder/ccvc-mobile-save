import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_header.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nv_state.dart';
import 'package:rxdart/rxdart.dart';

class ChiTietNVCubit extends BaseCubit<ChiTietNVState> {
  ChiTietNVCubit() : super(ChiTietNVInitial());

  BehaviorSubject<ChiTietNhiemVuHeader> chiTietHeaderSubject =
      BehaviorSubject();

  BehaviorSubject<VanBanLienQuanModel> vanBanLienQuanSubject =
      BehaviorSubject();

  BehaviorSubject<List<DanhSachCongViecModel>> danhsachCongViecSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuPhanXuLyModel>> lichSuPhanXuLySubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuThuHoiModel>> lichSuThuHoiSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuCapNhatTHTHModel>> lichSuCapNhatTHTHSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuTraLaiModel>> lichSuTraLaiSubject =
      BehaviorSubject();

 BehaviorSubject<List<LichSuDonDocModel>> lichSuDonDocSubject =
      BehaviorSubject();

  Stream<VanBanLienQuanModel> get vanBanLienQuanStream =>
      vanBanLienQuanSubject.stream;

  Stream<List<LichSuThuHoiModel>> get lichSuThuHoiStream =>
      lichSuThuHoiSubject.stream;

 Stream<List<LichSuDonDocModel>> get lichSuDonDocStream =>
     lichSuDonDocSubject.stream;

  Stream<List<DanhSachCongViecModel>> get danhSachCongViecStream =>
      danhsachCongViecSubject.stream;

  Stream<List<LichSuTraLaiModel>> get lichSuTraLaiStream =>
      lichSuTraLaiSubject.stream;

  Stream<List<LichSuPhanXuLyModel>> get lichSuPhanXuLyModelStream =>
      lichSuPhanXuLySubject.stream;

  Stream<List<LichSuCapNhatTHTHModel>> get lichSuCapNhatTHTHModelStream =>
      lichSuCapNhatTHTHSubject.stream;

  Stream<ChiTietNhiemVuHeader> get chiTietHeaderStream =>
      chiTietHeaderSubject.stream;

  List<LichSuThuHoiModel> fakeLSTH = [
    LichSuThuHoiModel(
      id: '',
      noiDungTraLai: 'Chưa có',
      thoiGian: '27/07/2021 | 17:02:22',
      donViBiThuHoi: 'UBND Đồng Nai',
      donViThuHoi: 'UBND Đồng Nai',
      nguoiBiThuHoi: 'Hà Kiều Anh',
      nguoiThuHoi: 'Hà Kiều Anh',
    ),
    LichSuThuHoiModel(
      id: '',
      noiDungTraLai: 'Chưa có',
      thoiGian: '27/07/2021 | 17:02:22',
      donViBiThuHoi: 'UBND Đồng Nai',
      donViThuHoi: 'UBND Đồng Nai',
      nguoiBiThuHoi: 'Hà Kiều Anh',
      nguoiThuHoi: 'Hà Kiều Anh',
    ),
  ];

  List<LichSuDonDocModel> fakeLSDD = [
    LichSuDonDocModel(
      id: '',
      noiDungDonDoc: 'Chưa có',
      thoiGian: '27/07/2021 | 17:02:22',
      donViDonDoc: 'UBND Đồng Nai',
       donViBiDonDoc: 'UBND Đồng Nai',
      nguoiBiDonDoc:  'Hà Kiều Anh',
      nguoiDonDoc:  'Hà Kiều Anh',
    ),
   LichSuDonDocModel(
      id: '',
      noiDungDonDoc: 'Chưa có',
      thoiGian: '27/07/2021 | 17:02:22',
      donViDonDoc: 'UBND Đồng Nai',
       donViBiDonDoc: 'UBND Đồng Nai',
      nguoiBiDonDoc:  'Hà Kiều Anh',
      nguoiDonDoc:  'Hà Kiều Anh',
    ),
    LichSuDonDocModel(
      id: '',
      noiDungDonDoc: 'Chưa có',
      thoiGian: '27/07/2021 | 17:02:22',
      donViDonDoc: 'UBND Đồng Nai',
      donViBiDonDoc: 'UBND Đồng Nai',
      nguoiBiDonDoc: 'Hà Kiều Anh',
      nguoiDonDoc: 'Hà Kiều Anh',
    ),
  ];

  List<LichSuCapNhatTHTHModel> fakeLSCNTHTH = [
    LichSuCapNhatTHTHModel(
      id: '',
      thoiGian: '27/07/2021 | 17:02:22',
      trangThai: 'DANG_THUC_HIEN',
      donViCapNhat: 'UBND Đồng Nai',
      dvBiTraLai: 'UBND Đồng Nai',
      nguoiCapNhat: 'chanhvpboqlvb',
      noiDungCapNhat: 'chanhvpboqlvb',
    ),
    LichSuCapNhatTHTHModel(
      id: '',
      thoiGian: '27/07/2021 | 17:02:22',
      trangThai: 'DANG_THUC_HIEN',
      donViCapNhat: 'UBND Đồng Nai',
      dvBiTraLai: 'UBND Đồng Nai',
      nguoiCapNhat: 'chanhvpboqlvb',
      noiDungCapNhat: 'chanhvpboqlvb',
    ),
  ];

  List<LichSuTraLaiModel> fakeLSTL = [
    LichSuTraLaiModel(
      id: '',
      nguoiCapNhat: 'chanhvpboqlvb',
      dvBiTraLai: 'UBND Đồng Nai',
      thoiGian: '27/07/2021 | 17:02:22',
      fileDinhKem: File('Mô tả dự án.docx'),
      donViTraLai: 'UBND Đồng Nai',
      nguoiBiTraLai: 'Hà Kiều Anh',
      noiDungTraLai: 'Chưa có',
    ),
  ];

  ChiTietNhiemVuHeader fakeHeader = ChiTietNhiemVuHeader(
      id: '',
      loaiNV: 'Nhiệm vụ cá nhân',
      soNhiemVu: 'NVBV8',
      tinhHinhTH: '13/10/2021',
      hanXuLy: 'NVBV8',
      nguoiGiao: 'Lương Minh Trang',
      noiDung: 'Nhiệm vụ hành chính giao');

  VanBanLienQuanModel fakeVBLQ = VanBanLienQuanModel(
    id: '',
    vanBanGiaoNV: [
      ItemVanBanLienQuanModel(
          id: '',
          ngayVB: '25/08/2021',
          fileDinhKem: File('Mô tả dự án.docx'),
          soKyHieu: '1',
          trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
      ItemVanBanLienQuanModel(
          id: '',
          ngayVB: '25/08/2021',
          fileDinhKem: File('Mô tả dự án.docx'),
          soKyHieu: '1',
          trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
      ItemVanBanLienQuanModel(
          id: '',
          ngayVB: '25/08/2021',
          fileDinhKem: File('Mô tả dự án.docx'),
          soKyHieu: '1',
          trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
    ],
    vanBanKhac: [],
  );

  List<LichSuPhanXuLyModel> fakeLSPXL = [
    LichSuPhanXuLyModel(
      id: '',
      stt: 1,
      donViNhan: 'Đơn vị nhận',
      nguoiGui: 'Lương Minh Trang',
      nguoiNhan: 'Nguyễn Như Sơn',
      thoiGian: '27/07/2021 | 17:02:22',
      vaiTroXuLy: 'Chủ trì',
      trangThai: 'QUA_HAN',
    ),
    LichSuPhanXuLyModel(
      id: '',
      stt: 1,
      donViNhan: 'Đơn vị nhận',
      nguoiGui: 'Lương Minh Trang',
      nguoiNhan: 'Nguyễn Như Sơn',
      thoiGian: '27/07/2021 | 17:02:22',
      vaiTroXuLy: 'Chủ trì',
      trangThai: 'QUA_HAN',
    ),
    LichSuPhanXuLyModel(
      id: '',
      stt: 1,
      donViNhan: 'Đơn vị nhận',
      nguoiGui: 'Lương Minh Trang',
      nguoiNhan: 'Nguyễn Như Sơn',
      thoiGian: '27/07/2021 | 17:02:22',
      vaiTroXuLy: 'Chủ trì',
      trangThai: 'QUA_HAN',
    ),
    LichSuPhanXuLyModel(
      id: '',
      stt: 1,
      donViNhan: 'Đơn vị nhận',
      nguoiGui: 'Lương Minh Trang',
      nguoiNhan: 'Nguyễn Như Sơn',
      thoiGian: '27/07/2021 | 17:02:22',
      vaiTroXuLy: 'Chủ trì',
      trangThai: 'QUA_HAN',
    ),
  ];

  List<DanhSachCongViecModel> fakeDSCV = [
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'QUA_HAN',
    ),
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'QUA_HAN',
    ),
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'QUA_HAN',
    ),
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'QUA_HAN',
    ),
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'CHUA_THUC_HIEN',
    ),
    DanhSachCongViecModel(
      id: '',
      donViXuLy: 'UBND Tỉnh Đồng Nai',
      hanXuLy: '25/08/2021',
      ndCongViec: 'Chưa có',
      nguoiGiaoViec: 'Nguyễn Kiều Oanh',
      nguoiXuLy: 'Lương Minh Trang',
      stt: 1,
      thoiGianGiaoViec: '25/08/2021',
      trangThai: 'QUA_HAN',
    ),
  ];

  void initChiTietNV() {
    chiTietHeaderSubject.add(fakeHeader);
    vanBanLienQuanSubject.add(fakeVBLQ);
    danhsachCongViecSubject.add(fakeDSCV);
    lichSuPhanXuLySubject.add(fakeLSPXL);
    lichSuCapNhatTHTHSubject.add(fakeLSCNTHTH);
    lichSuTraLaiSubject.add(fakeLSTL);
    lichSuThuHoiSubject.add(fakeLSTH);
    lichSuDonDocSubject.add(fakeLSDD);
  }
}
