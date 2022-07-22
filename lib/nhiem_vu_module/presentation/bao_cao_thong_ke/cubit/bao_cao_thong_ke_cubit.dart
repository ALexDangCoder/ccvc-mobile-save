import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/htcs_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_common_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'bao_cao_thong_ke_state.dart';

class BaoCaoThongKeCubit extends BaseCubit<BaoCaoThongKeState> {
  BaoCaoThongKeCubit() : super(BaoCaoThongKeInitial());

  ReportCommonRepository get _reportCommonService => Get.find();
  BehaviorSubject<String> textDonViXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');
  BehaviorSubject<String> textCaNhanXuLyFilter =
      BehaviorSubject.seeded('---${S.current.chon}---');

  ReportRepository get _repo => Get.find();
  String appId = '';
  String donViId = '';
  static const String CODE = 'QLNV';

  Future<void> getAppID() async {
    showLoading();
    final Result<List<HTCSModel>> result = await _reportCommonService.getHTCS(
      CODE,
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          appId = res.first.id ?? '';
        } else {
          //    emit(const CompletedLoadMore(CompleteType.ERROR));
          showError();
        }
      },
      error: (error) {
        //emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getCaNhanXuLy() async {
    showLoading();
    final data = await _repo.getUserPaging(
      donViId: donViId,
      appId: appId,
    );
    data.when(
      success: (res) {
        //todo
        showContent();
      },
      error: (err) {},
    );
  }
}
