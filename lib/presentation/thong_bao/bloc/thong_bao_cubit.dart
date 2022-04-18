import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';
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
  String appCode = 'COMMON';

  List<String> listMenu = [
    ImageAssets.icDeleteRed,
  ];

  BehaviorSubject<ThongBaoQuanTrongModel> getListNotiSubject = BehaviorSubject();

  Stream<ThongBaoQuanTrongModel> get getListNotiStream =>
      getListNotiSubject.stream;

  BehaviorSubject<ThongBaoQuanTrongModel> thongBaoQuanTrongSubject =
      BehaviorSubject();

  Stream<ThongBaoQuanTrongModel> get thongBaoQuanTrongStream =>
      thongBaoQuanTrongSubject.stream;

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
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> getThongBaoQuanTrong() async {
    showLoading();
    final result = await _service.getThongBaoQuanTrong(
      appCode: appCode,
      active: true,
      seen: -1,
      currentPage: 1,
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

  Future<void> getListThongBao() async {
    showLoading();
    final result = await _service.getThongBaoQuanTrong(
      appCode: appCode,
      active: true,
      seen: -1,
      currentPage: 1,
      pageSize: 10,
    );

    result.when(
      success: (value) {
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

  void dispose() {
    thongBaoSubject.close();
    super.close();
  }
}
