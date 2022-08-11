import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_y_kien_nguoi_dan/pick_image_file_model.dart';
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
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class ChiTietNVCubit extends BaseCubit<ChiTietNVState> {
  ChiTietNVCubit() : super(ChiTietNVInitial());

  NhiemVuRepository get nhiemVuRepo => Get.find();

  BehaviorSubject<ChiTietNhiemVuModel> chiTietHeaderSubject = BehaviorSubject();

  BehaviorSubject<VanBanLienQuanNhiemVuModel> vanBanLienQuanSubject =
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
  BehaviorSubject<List<VanBanLienQuanNhiemVuModel>> vanBanGiaoNhiemVuSubject =
      BehaviorSubject();
  BehaviorSubject<List<VanBanLienQuanNhiemVuModel>> vanBanKhacNhiemVuSubject =
      BehaviorSubject();

  Stream<VanBanLienQuanNhiemVuModel> get vanBanLienQuanStream =>
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

  Stream<List<VanBanLienQuanNhiemVuModel>> get vanBanGiaoNhiemvuStream =>
      vanBanGiaoNhiemVuSubject.stream;

  Stream<List<VanBanLienQuanNhiemVuModel>> get vanBanKhacNhiemvuStream =>
      vanBanKhacNhiemVuSubject.stream;

  String? donViId;

  Future<void> loadDataNhiemVuCaNhan(
      {required String nhiemVuId, required bool isCheck}) async {
    final queue = Queue(parallel: 9);
    unawaited(queue.add(() => getChiTietNhiemVuCaNhan(nhiemVuId, isCheck)));
    unawaited(queue.add(() => getLichSuPhanXuLy(nhiemVuId)));
    unawaited(queue.add(() => getYKienXuLyNhiemVu(nhiemVuId)));
    unawaited(
        queue.add(() => getDanhSachCongViecChiTietNhiemVu(nhiemVuId, isCheck)));
    unawaited(queue.add(() => getLichSuTraLaiNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getLichSuCapNhatThth(nhiemVuId)));
    unawaited(queue.add(() => getLichSuThuHoiNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getLichSuDonDocNhiemVu(nhiemVuId)));
    unawaited(queue.add(() => getVanBanLienQuanNhiemVu(nhiemVuId)));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> getChiTietNhiemVuCaNhan(String nhiemVuId, bool isCheck) async {
    final result =
        await nhiemVuRepo.getChiTietNhiemVu(nhiemVuId, isCheck, donViId);
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

  Future<void> getDanhSachCongViecChiTietNhiemVu(
      String nhiemVuId, bool isCheck) async {
    final result =
        await nhiemVuRepo.getDanhSachCongViecChiTietNhiemVu(nhiemVuId, isCheck);
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

  Future<void> getVanBanLienQuanNhiemVu(String id) async {
    final result = await nhiemVuRepo.getVanBanLienQuanNhiemVu(id);
    result.when(
        success: (res) {
          getListVanBanLienQuanNhiemVu(res);
        },
        error: (error) {});
  }

  void getListVanBanLienQuanNhiemVu(List<VanBanLienQuanNhiemVuModel> list) {
    vanBanGiaoNhiemVuSubject.sink.add(
        list.where((element) => element.hinhThucVanBan == 'lienquan').toList());
    vanBanKhacNhiemVuSubject.sink.add(
        list.where((element) => element.hinhThucVanBan == 'khac').toList());
  }

  /// Xin ý kiến

  final BehaviorSubject<String> validateNhapYkien = BehaviorSubject.seeded('');
  final List<PickImageFileModel> listPickFileMain = [];
  int size = 0;
  String idNhiemVu = '';
  List<Map<String, String>> listFileId = [];

  bool checkFile(int size) {
    if (size / BYTE_TO_MB > 30) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> uploadFile({
    required List<File> path,
  }) async {
    final result = await nhiemVuRepo.postFile(
      path: path,
    );
    result.when(
      success: (res) {
        if (res != 'false') {
          listFileId.add(
            {
              'FileDinhKemId': res,
            },
          );
        }
      },
      error: (error) {
        showContent();
      },
    );
  }

  Future<String> postYKienXuLy({
    required String nhiemvuId,
    required String noiDung,
    required List<Map<String, String>> fileId,
  }) async {
    String status = '';
    showLoading();
    final Map<String, dynamic> map = {
      'NhiemVuId': nhiemvuId,
      'HashValue': '',
      'IsSign': 'false',
      'NoiDung': noiDung,
      'YKienXuLyFileDinhKem': fileId,
    };
    final result = await nhiemVuRepo.postYKienXuLy(
      map: map,
    );
    result.when(
      success: (res) {
        status = res;
        getYKienXuLyNhiemVu(idNhiemVu);
        showContent();
      },
      error: (error) {
        status = '';
        showContent();
      },
    );
    return status;
  }
}
