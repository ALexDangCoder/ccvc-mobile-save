import 'dart:async';
import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/chi_tiet_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_don_doc.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/y_kien_su_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nv_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class ChiTietNVCubit extends BaseCubit<ChiTietNVState> {
  ChiTietNVCubit() : super(ChiTietNVInitial());

  NhiemVuRepository get nhiemVuRepo => Get.find();

  BehaviorSubject<ChiTietNhiemVuModel> chiTietHeaderSubject = BehaviorSubject();

  BehaviorSubject<VanBanLienQuanModel> vanBanLienQuanSubject =
      BehaviorSubject();

  BehaviorSubject<List<DanhSachCongViecChiTietNhiemVuModel>>
      danhsachCongViecSubject = BehaviorSubject();

  BehaviorSubject<List<LichSuPhanXuLyNhiemVuModel>> lichSuPhanXuLySubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuThuHoiNhiemVuModel>> lichSuThuHoiSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuCapNhatTHTHModel>> lichSuCapNhatTHTHSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuTraLaiNhiemVuModel>> lichSuTraLaiSubject =
      BehaviorSubject();

  BehaviorSubject<List<LichSuDonDocNhiemVuModel>> lichSuDonDocSubject =
      BehaviorSubject();
  BehaviorSubject<List<YKienSuLyNhiemVuModel>> yKienXuLyNhiemVuSubject =
      BehaviorSubject();

  Stream<VanBanLienQuanModel> get vanBanLienQuanStream =>
      vanBanLienQuanSubject.stream;

  Stream<List<LichSuThuHoiNhiemVuModel>> get lichSuThuHoiStream =>
      lichSuThuHoiSubject.stream;

  Stream<List<LichSuDonDocNhiemVuModel>> get lichSuDonDocStream =>
      lichSuDonDocSubject.stream;

  Stream<List<DanhSachCongViecChiTietNhiemVuModel>>
      get danhSachCongViecStream => danhsachCongViecSubject.stream;

  Stream<List<LichSuTraLaiNhiemVuModel>> get lichSuTraLaiStream =>
      lichSuTraLaiSubject.stream;

  Stream<List<LichSuPhanXuLyNhiemVuModel>> get lichSuPhanXuLyModelStream =>
      lichSuPhanXuLySubject.stream;

  Stream<List<LichSuCapNhatTHTHModel>> get lichSuCapNhatTHTHModelStream =>
      lichSuCapNhatTHTHSubject.stream;

  Stream<List<YKienSuLyNhiemVuModel>> get yKienXuLyNhiemVuStream =>
      yKienXuLyNhiemVuSubject.stream;

  Stream<ChiTietNhiemVuModel> get chiTietHeaderStream =>
      chiTietHeaderSubject.stream;

  Future<void> loadDataNhiemVuCaNhan({
    required String nhiemVuId,
  }) async {
    final queue = Queue(parallel: 8);
    unawaited(queue.add(() => getChiTietNhiemVuCaNhan(nhiemVuId)));
    unawaited(queue.add(() => getLichSuPhanXuLy(nhiemVuId)));
    unawaited(queue.add(() => getYKienXuLyNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getDanhSachCongViecChiTietNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getLichSuTraLaiNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getLichSuCapNhatThth(nhiemVuId)));
    unawaited(queue.add(() => getLichSuThuHoiNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getLichSuDonDocNhiemVu(nhiemVuId)));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> getChiTietNhiemVuCaNhan(String nhiemVuId) async {
    final result = await nhiemVuRepo.getChiTietNhiemVu(nhiemVuId, true);
    result.when(
        success: (res) {
          chiTietHeaderSubject.add(res);
        },
        error: (error) {});
  }

  Future<void> getLichSuPhanXuLy(String nhiemVuId) async {
    final result = await nhiemVuRepo.getLichSuPhanXuLy(nhiemVuId);
    result.when(
        success: (res) {
          lichSuPhanXuLySubject.add(res);
        },
        error: (error) {});
  }

  Future<void> getYKienXuLyNhiemVu(String nhiemVuId) async {
    final result = await nhiemVuRepo.getYKienXuLyNhiemVu(nhiemVuId);
    result.when(
        success: (res) {
          yKienXuLyNhiemVuSubject.add(res);
        },
        error: (error) {});
  }

  Future<void> getDanhSachCongViecChiTietNhiemVu(String nhiemVuId) async {
    final result =
        await nhiemVuRepo.getDanhSachCongViecChiTietNhiemVu(nhiemVuId, true);
    result.when(
        success: (res) {
          danhsachCongViecSubject.add(res);
        },
        error: (error) {});
  }

  Future<void> getLichSuTraLaiNhiemVu(String nhiemVuId) async {
    final result = await nhiemVuRepo.getLichSuTraLaiNhiemVu(nhiemVuId);
    result.when(
      success: (res) {
        lichSuTraLaiSubject.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuCapNhatThth(String nhiemVuId) async {
    final result = await nhiemVuRepo.getLichSuCapNhatThth(nhiemVuId);
    result.when(
      success: (res) {
        lichSuCapNhatTHTHSubject.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuThuHoiNhiemVu(String nhiemVuId) async {
    final result = await nhiemVuRepo.getLichSuThuHoiNhiemVu(nhiemVuId);
    result.when(
      success: (res) {
        lichSuThuHoiSubject.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getLichSuDonDocNhiemVu(String nhiemVuId) async {
    final result = await nhiemVuRepo.getLichSuDonDocNhiemVu(nhiemVuId);
    result.when(
      success: (res) {
        lichSuDonDocSubject.add(res);
      },
      error: (error) {},
    );
  }

  VanBanLienQuanModel fakeVBLQ = VanBanLienQuanModel(
    id: '',
    vanBanGiaoNV: [
      // ItemVanBanLienQuanModel(
      //     id: '',
      //     ngayVB: '25/08/2021',
      //     fileDinhKem: File('Mô tả dự án.docx'),
      //     soKyHieu: '1',
      //     trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
      // ItemVanBanLienQuanModel(
      //     id: '',
      //     ngayVB: '25/08/2021',
      //     fileDinhKem: ['Mô tả dự án.docx'],
      //     soKyHieu: '1',
      //     trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
      // ItemVanBanLienQuanModel(
      //     id: '',
      //     ngayVB: '25/08/2021',
      //     fileDinhKem: File('Mô tả dự án.docx'),
      //     soKyHieu: '1',
      //     trichYeu: 'Thi hành khảo sát tình hình hộ nghèo năm 2021'),
    ],
    vanBanKhac: [],
  );

  void initChiTietNV() {
    vanBanLienQuanSubject.add(fakeVBLQ);
    // lichSuThuHoiSubject.add(fakeLSTH);
    // lichSuDonDocSubject.add(fakeLSDD);
  }
}
