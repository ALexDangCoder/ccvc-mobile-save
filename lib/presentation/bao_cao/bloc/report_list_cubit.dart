import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/domain/repository/bao_cao/report_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_cao/bloc/report_list_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class DanhSachBaoCaoCubit extends BaseCubit<DanhSachBaoCaoState> {
  DanhSachBaoCaoCubit() : super(DanhSachBaoCaoInitial());

  BehaviorSubject<String> textFilter = BehaviorSubject.seeded(S.current.tu_a_z);
  BehaviorSubject<bool> isCheckList = BehaviorSubject.seeded(true);

  List<ReportItem> listReport = [];

  ReportRepository get _reportService => Get.find();

  Future<void> getListReport({
    required String folderId,
    required int sort,
    required String keyWord,
  }) async {
    showLoading();
    final result = await _reportService.getListReport(
      folderId,
      sort,
      keyWord,
    );
    result.when(
      success: (res) {
        showContent();
        listReport.addAll(res);
      },
      error: (error) {},
    );
  }
}
