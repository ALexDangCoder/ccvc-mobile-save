import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';
import 'package:ccvc_mobile/presentation/thong_bao/bloc/thong_bao_state.dart';
import 'package:ccvc_mobile/presentation/thong_bao/ui/thong_bao_type.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ThongBaoCubit extends BaseCubit<ThongBaoState> {
  ThongBaoCubit() : super(ThongBaoStateInitial());

  ThongBaoRepository get _service => Get.find();
  bool isSwitch = false;
  List<ThongBaoModel> fakeData = [
    ThongBaoModel(
      id: 'id',
      name: 'Báo cáo',
      code: 'code',
      description: 'description',
      unreadCount: 20,
      total: 10,
    ),
    ThongBaoModel(
      id: 'id',
      name: 'Báo cáo',
      code: 'code',
      description: 'description',
      unreadCount: 20,
      total: 10,
    ),
    ThongBaoModel(
      id: 'id',
      name: 'Báo cáo',
      code: 'code',
      description: 'description',
      unreadCount: 200,
      total: 10,
    ),
  ];

  ThongBaoQuanTrongModel fakeData1 = ThongBaoQuanTrongModel(
    items: [
      Item(
        active: true,
        confirmAction: 'confirmAction',
        createAt: 'createAt',
        icon: 'icon',
        id: 'id',
        message: 'COMMON demo noti 5',
        needConfirmation: false,
        pin: false,
        receiceId: '39227131-3db7-48f8-a1b2-57697430cc69',
        redirectUrl: 'redirectUrl',
        rejectReason: 'rejectReason',
        seen: true,
        seenDate: '2022-04-15T14:36:55.0866667',
        sentId: '3f2124a0-d74d-435f-3ed9-08d8a64939ff',
        status: 1,
        subSystem: 'COMMON',
        timeSent: '2022-01-24T16:35:23.06',
        title: 'common',
      ),
      Item(
        active: true,
        confirmAction: 'confirmAction',
        createAt: 'createAt',
        icon: 'icon',
        id: 'id',
        message: 'COMMON demo noti 5',
        needConfirmation: false,
        pin: false,
        receiceId: '39227131-3db7-48f8-a1b2-57697430cc69',
        redirectUrl: 'redirectUrl',
        rejectReason: 'rejectReason',
        seen: false,
        seenDate: '2022-04-15T14:36:55.0866667',
        sentId: '3f2124a0-d74d-435f-3ed9-08d8a64939ff',
        status: 1,
        subSystem: 'COMMON',
        timeSent: '2022-01-24T16:35:23.06',
        title: 'common',
      ),
    ],
    paging: Paging(
      currentPage: 1,
      pageSize: 2,
      pagesCount: 3,
      rowsCount: 4,
      startRowIndex: 5,
    ),
  );

  BehaviorSubject<ThongBaoQuanTrongModel> thongBaoQuanTrongSubject =
      BehaviorSubject();

  Stream<ThongBaoQuanTrongModel> get thongBaoQuanTrongStream =>
      thongBaoQuanTrongSubject.stream;

  BehaviorSubject<List<ThongBaoModel>> thongBaoSubject = BehaviorSubject();

  Stream<List<ThongBaoModel>> get thongBaoStream => thongBaoSubject.stream;

  void initData() {
    thongBaoSubject.add(fakeData);
    thongBaoQuanTrongSubject.add(fakeData1);
    // getNotifyAppCodes();
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
