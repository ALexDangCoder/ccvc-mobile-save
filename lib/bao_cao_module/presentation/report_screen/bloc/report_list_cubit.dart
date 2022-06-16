import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_state.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/domain/repository/bao_cao/report_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class ReportListCubit extends BaseCubit<BaseState> {
  ReportListCubit() : super(ReportListStateInitial());

  BehaviorSubject<String> textFilter = BehaviorSubject.seeded(S.current.tu_a_z);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textFilterBox = BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<bool> isCheckList = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isStatusSearch = BehaviorSubject.seeded(true);
  BehaviorSubject<List<ReportItem>> listReportFavorite =
      BehaviorSubject.seeded([]);

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
        listReportFavorite.sink.add(res);
        if (!res.isNotEmpty) {
          showEmpty();
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }
}
