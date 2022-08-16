import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/thong_bao/setting_notify_request.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/background_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/setting_notify_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_state.dart';

import 'package:ccvc_mobile/presentation/thong_bao/ui/type_detail.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class ThongBaoCubit extends BaseCubit<ThongBaoState> {
  ThongBaoCubit() : super(ThongBaoStateInitial());

  ThongBaoRepository get _service => Get.find();
  bool isSwitch = false;
  String appCode = '';
  List<String> appCodes = [];
  bool modeSilent = false;
  List<String> stateAppCode = [];

  int page = 1;
  int totalPage = 1;
  List<String> listMenu = [
    ImageAssets.icDeleteRed,
  ];
  List<Item> listThongBao = [];

  BehaviorSubject<ThongBaoQuanTrongModel> getListNotiSubject =
      BehaviorSubject();

  Stream<ThongBaoQuanTrongModel> get getListNotiStream =>
      getListNotiSubject.stream;

  BehaviorSubject<ThongBaoQuanTrongModel> thongBaoQuanTrongSubject =
      BehaviorSubject();

  Stream<ThongBaoQuanTrongModel> get thongBaoQuanTrongStream =>
      thongBaoQuanTrongSubject.stream;

  BehaviorSubject<SettingNotifyModel> settingSubject = BehaviorSubject();

  BehaviorSubject<List<ThongBaoModel>> thongBaoSubject = BehaviorSubject();

  Stream<List<ThongBaoModel>> get thongBaoStream => thongBaoSubject.stream;

  Future<void> initData() async {
    await getNotifyAppCodes();
    await getThongBaoQuanTrong();
  }

  ThongBaoType typeContent(String typeNotify) {
    switch (typeNotify) {
      case ThongBaoTypeConstant.LICH_HOP_MOI:
        return ThongBaoType.LichHopMoi;
      case ThongBaoTypeConstant.TIN_NHAN_MOI:
        return ThongBaoType.TinNhanMoi;
      default:
        return ThongBaoType.LichHopMoi;
    }
  }

  void dispose() {
    thongBaoSubject.close();
    super.close();
  }
}

extension SettingScreen on ThongBaoCubit {
  Future<void> getSettingNoti() async {
    showLoading();
    final result = await _service.getSetting();

    result.when(
      success: (value) {
        if ((value.subSystem ?? []).isNotEmpty) {
          stateAppCode.addAll(value.subSystem ?? []);
          stateAppCode = stateAppCode.map((e) => e.trim()).toList();
          settingSubject.add(value);
        }
        modeSilent = value.modeSilent ?? false;
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> postSetting() async {
    showLoading();
    final result = await _service.postSetting(
      SettingNotifyRequest(
        createdBy: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
        messageShowNew: true,
        messageShowNotRead: true,
        messageShowPreview: true,
        modeSilent: modeSilent,
        noticeHideAuto: '',
        noticeLocation: '',
        sound: true,
        soundType: '',
        soundVolume: 0,
        subSystem: stateAppCode.toString().getAppCode(),
      ),
    );
    result.when(
      success: (success) {
        stateAppCode.clear();
        showContent();
        getSettingNoti();
      },
      error: (error) {},
    );
  }

  void isSilent() {
    if (modeSilent) {
      setSilentMode();
    } else {
      setNormalMode();
    }
  }

  void changeModeSilent() {
    modeSilent = !modeSilent;
    isSilent();
    postSetting();
  }

  Future<void> checkPermissionSilent() async {
    bool permissionStatus = false;
    try {
      permissionStatus = await PermissionHandler.permissionsGranted ?? false;

      if (!permissionStatus) {
        await PermissionHandler.openDoNotDisturbSetting();
      }
    } catch (_) {}
  }

  Future<void> setSilentMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    } catch (_) {}
  }

  Future<void> setNormalMode() async {
    try {
      await SoundMode.setSoundMode(RingerModeStatus.normal);
    } on PlatformException {}
  }

  void changeSwitch(String appCode, bool status) {
    if (!status) {
      stateAppCode.remove(appCode.trim());
    } else {
      stateAppCode.add(appCode.trim());
    }
    postSetting();
  }
}

extension ThongBaoScreen on ThongBaoCubit {
  Future<void> getNotifyAppCodes() async {
    showLoading();
    final result = await _service.getNotifyAppcodes();

    result.when(
      success: (value) {
        thongBaoSubject.add(value);
        appCodes.clear();
        value.forEach((element) {
          appCodes.add(element.code ?? '');
        });
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> readAllNoti(bool isQuanTrong) async {
    showLoading();
    appCodes = stateAppCode.map((e) => e).toList();
    final result = await _service.readAllNoti(
      appCodes.toString().getAppCode(),
    );

    result.when(
      success: (value) {
        if (isQuanTrong) {
          getThongBaoQuanTrong();
        } else {
          getListThongBao();
        }
      },
      error: (er) {},
    );
    showContent();
  }

  Future<void> getThongBaoQuanTrong() async {
    final result = await _service.getThongBaoQuanTrong(
      active: true,
      seen: -1,
      currentPage: page,
      pageSize: 10,
    );

    result.when(
      success: (value) {
        thongBaoQuanTrongSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> deleteNoti(String id) async {
    final result = await _service.deleteNotify(id);
    result.when(
      success: (success) {
        getThongBaoQuanTrong();
      },
      error: (error) {},
    );
  }

  Future<void> getListThongBao() async {
    showLoading();
    final result = await _service.getListThongBao(
      appCode: appCode,
      active: true,
      seen: -1,
      currentPage: page,
      pageSize: 10,
    );

    result.when(
      success: (value) {
        totalPage = value.paging?.pagesCount ?? 1;
        listThongBao.addAll(value.items ?? []);
        value.items = listThongBao;
        getListNotiSubject.add(value);
      },
      error: (error) {},
    );
    showContent();
  }

  void selectNotiAppCode(String appCode) {
    this.appCode = appCode;
  }
}

extension BackgroundNoti on ThongBaoCubit {
  void pushNoti(Map<String, dynamic> json, BuildContext context) {
    final BackgroundModel noti = BackgroundModel.fromJson(json);
    (noti.typeNoti ?? '').getEnumDetail.getScreenDetail(context);
  }
}

extension AppCodes on String {
  String getAppCode() {
    return substring(1, length - 1).trim();
  }
}
