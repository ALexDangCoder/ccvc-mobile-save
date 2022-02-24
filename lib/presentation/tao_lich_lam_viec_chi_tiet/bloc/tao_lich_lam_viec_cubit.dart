import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_chu_tri_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/tao_moi_ban_ghi_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/tao_lich_lam_viec_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class TaoLichLamViecCubit extends BaseCubit<TaoLichLamViecState> {
  TaoLichLamViecCubit() : super(TaoLichLVStateInitial());

  LichLamViecRepository get _lichLamViec => Get.find();

  TaoMoiBanGhiRequest requestBanGhi = TaoMoiBanGhiRequest(
      content: '<p>ưq</p>',
      phienHopId: null,
      scheduleId: '7765603d-4493-4f7c-8a06-2d2b7511eedb',
      scheduleOpinionId: null,);

  BehaviorSubject<DateTime> startDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );

  BehaviorSubject<MessageModel> taoMoiBanGhiSubject = BehaviorSubject();

  BehaviorSubject<DateTime> endDateSubject = BehaviorSubject.seeded(
    DateTime.now(),
  );

  BehaviorSubject<List<String>> listItemPersonSubject =
      BehaviorSubject.seeded(listPerson);

  Stream<MessageModel> get taoMoiBanGhiStream => taoMoiBanGhiSubject.stream;

  Stream<DateTime> get startDateStream => startDateSubject.stream;

  Stream<DateTime> get endDateStream => endDateSubject.stream;

  Stream<List<String>> get listItemPersonStream => listItemPersonSubject.stream;
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich = BehaviorSubject();

  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();
  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich.stream;
  LoaiSelectModel? selectLoaiLich;
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;

  void listeningStartDataTime(DateTime dateAndTime) {
    startDateSubject.add(dateAndTime);
  }

  void listeningEndDataTime(DateTime dateAndTime) {
    endDateSubject.add(dateAndTime);
  }

  Future<void> taoMoiBanGhi(TaoMoiBanGhiRequest request) async {
    final result = await _lichLamViec.postTaoMoiBanGhi(request);

    result.when(
      success: (value) {
        taoMoiBanGhiSubject.add(value);
      },
      error: (error) {},
    );
  }

  bool checkValidateTime() {
    if (endDateSubject.value.isBefore(startDateSubject.value)) {
      return false;
    }
    return true;
  }

  String? validateInputText(String inputText) {
    if (inputText.isEmpty) {
      return S.current.khong_the_bo_trong;
    }
    return null;
  }

  Future<void> deleteFile(File deleteFile, List<File> list) async {
    list.remove(deleteFile);
  }

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;

  Future<void> loadData() async {
    final queue = Queue(parallel: 3);
    unawaited(queue.add(() => _getLinhVuc()));
    unawaited(queue.add(() => _getLoaiLich()));
    unawaited(queue.add(() => _getNguoiChuTri()));
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> _getLoaiLich() async {
    final result = await _lichLamViec
        .getLoaiLich(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectLoaiLich = res.first;
          }
          _loaiLich.sink.add(res);
        },
        error: (err) {});
  }

  Future<void> _getLinhVuc() async {
    final result = await _lichLamViec
        .getLinhVuc(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectLinhVuc = res.first;
          }
          _linhVuc.sink.add(res);
        },
        error: (err) {});
  }

  Future<void> _getNguoiChuTri() async {
    final dataUser = HiveLocal.getDataUser();

    final result = await _lichLamViec.getNguoiChuTri(
      NguoiChuTriRequest(
        isTaoHo: true,
        pageIndex: 1,
        pageSize: 100,
        userId: dataUser?.userId ?? '',
      ),
    );
    result.when(
        success: (res) {
          if (res.isNotEmpty) {
            selectNguoiChuTri = res.first;
          }
          _nguoiChuTri.sink.add(res);
        },
        error: (err) {});
  }

  void dispose() {
    _loaiLich.close();
    _nguoiChuTri.close();
  }

  void showDialog(WidgetType type) {
    if (_showDialogSetting.hasValue) {
      if (_showDialogSetting.value == type) {
        closeDialog();
      } else {
        _showDialogSetting.add(type);
      }
    } else {
      _showDialogSetting.add(type);
    }
  }

  void closeDialog() {
    _showDialogSetting.add(null);
  }
}
