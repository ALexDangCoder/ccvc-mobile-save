import 'package:ccvc_mobile/bao_cao_module/domain/model/htcs_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_common_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:get/get.dart' as get_dart;
import 'package:rxdart/rxdart.dart';

part 'bao_cao_thong_ke_state.dart';

class BaoCaoThongKeCubit extends BaseCubit<BaoCaoThongKeState> {
  BaoCaoThongKeCubit() : super(BaoCaoThongKeInitial());

  NhiemVuRepository get nhiemVuRepo => get_dart.Get.find();

  ThanhPhanThamGiaReponsitory get hopRp => get_dart.Get.find();

  ReportRepository get _repo => get_dart.Get.find();

  ReportCommonRepository get _reportCommonService => get_dart.Get.find();

  Stream<List<Node<DonViModel>>> get getTreeDonVi => _getTreeDonVi.stream;
  final BehaviorSubject<List<Node<DonViModel>>> _getTreeDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();
  BehaviorSubject<List<NhiemVuDonVi>> listBangThongKe = BehaviorSubject();
  BehaviorSubject<bool> isShowDonVi = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isShowCaNhan = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textDonViXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');
  BehaviorSubject<String> textCaNhanXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');
  BehaviorSubject<List<DonViModel>?> listCaNhanXuLy =
      BehaviorSubject.seeded(null);
  List<ChartData> listStatusData = [];

  String appId = '';
  String donViId = '';
  String caNhanXuLyId = '';
  String ngayDauTien = '';
  String ngayKetThuc = '';
  static const String CODE = 'QLNV';
  List<List<ChartData>> listData = [];
  List<String> titleNhiemVu = [];

  void initTimeRange() {
    final dataDateTime = DateTime.now();
    ngayDauTien =
        DateTime(dataDateTime.year, dataDateTime.month, dataDateTime.day - 30)
            .formatApi;
    ngayKetThuc = dataDateTime.formatApi;
  }

  void getTree() {
    hopRp.getTreeDonVi().then((value) {
      value.when(
        success: (res) {
          _getTreeDonVi.sink.add(res);
        },
        error: (err) {
          showError();
        },
      );
    });
  }

  Future<void> getAppID() async {
    showLoading();
    final Result<List<HTCSModel>> result = await _reportCommonService.getHTCS(
      CODE,
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          appId = res.first.id ?? '';
        }
      },
      error: (error) {},
    );
  }

  Future<void> getCaNhanXuLy() async {
    final data = await _repo.getUserPagingNhiemVu(
      donViId: donViId,
      appId: appId,
    );
    data.when(
      success: (res) {
        listCaNhanXuLy.add(res);
      },
      error: (err) {},
    );
  }

  void onChangeCaNhanXuLy(DonViModel value) {
    isShowCaNhan.add(false);
    caNhanXuLyId = value.id;
    textCaNhanXuLyFilter.add(
      value.name,
    );
  }

  void onChangeDonVi(DonViModel value) {
    isShowDonVi.add(false);
    donViId = value.id;
    textDonViXuLyFilter.add(
      value.name,
    );
    textCaNhanXuLyFilter.add('---${S.current.chon}---');
  }

  Future<void> getDataTheoDonVi({
    String? donviId,
    String? startDate,
    String? endDate,
    String? userId,
  }) async {
    final Result<List<NhiemVuDonVi>> result =
        await nhiemVuRepo.getDataNhiemVuTheoDonVi(
      donviId: donviId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
    result.when(
      success: (success) {
        listBangThongKe.add(success);
      },
      error: (error) {},
    );
  }
}
