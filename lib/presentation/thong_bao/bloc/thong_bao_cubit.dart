import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_state.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/thong_bao_type.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ThongBaoCubit extends BaseCubit<ThongBaoState> {
  ThongBaoCubit() : super(ThongBaoStateInitial());

  ThongBaoRepository get _service => Get.find();
  bool isSwitch = false;
  List<String> appCodes = [
    'COMMON',
    'VPDT',
    'QLVB',
    'APPDIEUHANH',
    'VMS',
    'PAKN',
    'QLNV'
  ];

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

  BehaviorSubject<List<ThongBaoModel>> settingSubject = BehaviorSubject();

  BehaviorSubject<List<ThongBaoModel>> thongBaoSubject = BehaviorSubject();

  Stream<List<ThongBaoModel>> get thongBaoStream => thongBaoSubject.stream;

  Future<void> initData() async {
    await getNotifyAppCodes();
    await getThongBaoQuanTrong();
  }

  Future<void> getNotifyAppCodes() async {
    showLoading();
    final result = await _service.getNotifyAppcodes();

    result.when(
      success: (value) {
        thongBaoSubject.add(value);
        appCodes.clear();
        value.forEach((element) {
          appCodes.add(element.code ?? 'COMMON');
        });
        stateAppCode = appCodes;
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> readAllNoti(bool isQuanTrong) async {
    showLoading();
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
    showLoading();
    appCodes = stateAppCode;
    final result = await _service.getThongBaoQuanTrong(
      appCode: appCodes.toString().getAppCode(),
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
    showContent();
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
    final result = await _service.getThongBaoQuanTrong(
      appCode: appCodes.toString().getAppCode(),
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

  void changeSwitch(String appCode, bool status) {
    if(!status) {
      stateAppCode.remove(appCode);
    } else {
      stateAppCode.add(appCode);
    }
    appCodes = stateAppCode;
    getThongBaoQuanTrong();
  }

  bool isQuanTrong(String appCode) {
    return appCodes.contains(appCode);
  }

  void selectNotiAppCode(String appCode) {
    appCodes.clear();
    appCodes.add(appCode);
  }

  void dispose() {
    thongBaoSubject.close();
    super.close();
  }
}

extension AppCodes on String {
  String getAppCode() {
    return substring(1, length - 1);
  }
}
