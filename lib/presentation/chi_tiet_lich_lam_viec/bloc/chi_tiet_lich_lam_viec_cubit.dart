import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/request/them_y_kien_repuest/them_y_kien_request.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/share_key.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/trang_thai_lv.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/tinh_trang_bao_cao_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChiTietLichLamViecCubit extends BaseCubit<BaseState> {
  BehaviorSubject<ChiTietLichLamViecModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  // chi tiet lich lam viec

  ChiTietLichLamViecCubit() : super(DetailDocumentInitial());
  List<TinhTrangBaoCaoModel> listTinhTrang = [];

  Stream<ChiTietLichLamViecModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;
  ChiTietLichLamViecModel chiTietLichLamViecModel = ChiTietLichLamViecModel();
  final BehaviorSubject<List<BaoCaoModel>> _listBaoCaoKetQua =
      BehaviorSubject<List<BaoCaoModel>>();
  final BehaviorSubject<List<YKienModel>> _listYKien =
      BehaviorSubject<List<YKienModel>>();

  Stream<List<YKienModel>> get listYKien => _listYKien.stream;

  Stream<List<BaoCaoModel>> get listBaoCaoKetQua => _listBaoCaoKetQua.stream;

  LichLamViecRepository get detailLichLamViec => Get.find();
  String idLichLamViec = '';

  Future<void> data(String id) async {
    final rs = await detailLichLamViec.detailCalenderWork(id);
    rs.when(
      success: (data) {
        chiTietLichLamViecModel = data;
        chiTietLichLamViecSubject.sink.add(chiTietLichLamViecModel);
      },
      error: (error) {},
    );
  }

  BehaviorSubject<List<TrangThaiLvModel>> listTrangThaiSubject =
      BehaviorSubject();

  Stream<List<TrangThaiLvModel>> get streamListTrangThai =>
      listTrangThaiSubject.stream;
  List<TrangThaiLvModel> listTrangThai = [];

  List<String> nameTrangThai = [];

  Future<void> dataTrangThai() async {
    final rs = await detailLichLamViec.trangThaiLV();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    rs.when(
      success: (data) {
        listTrangThai = data;
        listTrangThaiSubject.sink.add(listTrangThai);
        for (final name in listTrangThai) {
          nameTrangThai.add(name.displayName ?? '');
        }
        prefs.setStringList(ShareKey.shareKey, nameTrangThai);
      },
      error: (error) {},
    );
  }

  // xoa lich lam viec
  LichLamViecRepository get deleteLichLamViec => Get.find();

  Future dataDelete(String id) async {
    final rs = await detailLichLamViec.deleteCalenderWork(id);
    rs.when(success: (data) {}, error: (error) {});
  }

  // huy lich lam viec
  LichLamViecRepository get cancelLichLamViec => Get.find();

  Future<void> cancel(String id) async {
    final rs = await detailLichLamViec.cancelCalenderWork(id);
    rs.when(
        success: (data) {
          print('trang thai huy: $data');
        },
        error: (error) {});
  }

  Future<void> getListTinhTrang() async {
    await detailLichLamViec.getListTinhTrangBaoCao().then((value) {
      value.when(
          success: (res) {
            listTinhTrang = res;
          },
          error: (err) {});
    });
  }

  Future<void> loadApi(String id) async {
    final queue = Queue(parallel: 4);
    showLoading();
    idLichLamViec = id;
    unawaited(queue.add(() => data(id)));
    unawaited(queue.add(() => getDanhSachBaoCaoKetQua(id)));
    unawaited(queue.add(() => getDanhSachYKien(id)));
    unawaited(queue.add(() => getListTinhTrang()));
    dataTrangThai();
    await queue.onComplete;
    showContent();
  }

  Future<void> getDanhSachBaoCaoKetQua(String id) async {
    final result = await detailLichLamViec.getDanhSachBaoCao(id);
    result.when(
        success: (res) {
          _listBaoCaoKetQua.sink.add(res);
        },
        error: (err) {});
  }

  Future<void> getDanhSachYKien(String id) async {
    final result = await detailLichLamViec.getDanhSachYKien(id);
    result.when(
      success: (res) {
        _listYKien.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> xoaBaoCaoKetQua(String id) async {
    showLoading();
    final result = await detailLichLamViec.deleteBaoCaoKetQua(id);
    result.when(
        success: (res) {
          if (res.succeeded ?? false) {
            getDanhSachBaoCaoKetQua(idLichLamViec).whenComplete(() {
              showContent();
              MessageConfig.show(title: S.current.xoa_thanh_cong);
            });
          } else {
            showContent();
          }
        },
        error: (err) {});
  }

  String parseDate(String ngay) {
    final dateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(ngay);

    return '${dateTime.day} ${S.current.thang} ${dateTime.month},${dateTime.year}';
  }

  Future<void> updateBaoCaoKetQua({
    required String reportStatusId,
    required String scheduleId,
    required String content,
    required List<File> files,
    required List<String> filesDelete,
    required String id,
  }) async {
    showLoading();
    await detailLichLamViec
        .updateBaoCaoKetQua(
            reportStatusId, scheduleId, content, files, filesDelete, id)
        .then((value) {
      value.when(
        success: (res) {
          if (res.succeeded ?? false) {
            getDanhSachBaoCaoKetQua(idLichLamViec).whenComplete(() {
              showContent();
              MessageConfig.show(title: S.current.sua_thanh_cong);
            });
          } else {
            showContent();
          }
        },
        error: (err) {},
      );
    });
  }

  Future<void> themYKien({
    required String content,
    required String? phienHopId,
    required String scheduleId,
    required String? scheduleOpinionId,
  }) async {
    showLoading();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: content,
      phienHopId: phienHopId,
      scheduleId: scheduleId,
      scheduleOpinionId: scheduleOpinionId,
    );
    final result = await detailLichLamViec.themYKien(themYKienRequest);
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  void dispose() {
    _listBaoCaoKetQua.close();
    chiTietLichLamViecSubject.close();
    _listYKien.close();
  }
}
