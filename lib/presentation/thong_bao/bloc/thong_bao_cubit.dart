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
  String appCode = 'COMMON';
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

  void initDataSetting() {
    List<ThongBaoModel> listData = [
      ThongBaoModel(
        id: 'f554cc20-fd71-4bca-b59a-2b2e860a993a',
        name: 'Quản lý cán bộ',
        code: 'QLHSCB',
        description: '',
        unreadCount: 0,
        total: 0,
      ),
      ThongBaoModel(
        id: 'f554cc20-fd71-4bca-b59a-2b2e860a993a',
        name: 'Hệ thống quản lý common',
        code: 'COMMON',
        description: '',
        unreadCount: 0,
        total: 0,
      ),
      ThongBaoModel(
        id: 'f554cc20-fd71-4bca-b59a-2b2e860a993a',
        name: 'VMS',
        code: 'VMS',
        description: '',
        unreadCount: 0,
        total: 0,
      ),
      ThongBaoModel(
        id: 'f554cc20-fd71-4bca-b59a-2b2e860a993a',
        name: 'Phản ánh kiến nghị',
        code: 'PAKN',
        description: '',
        unreadCount: 0,
        total: 0,
      ),
    ];

    settingSubject.add(listData);
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
