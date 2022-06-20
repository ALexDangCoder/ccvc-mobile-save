import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_state.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/folder_model.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/htcs_model.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/domain/repository/bao_cao/report_common_repository.dart';
import 'package:ccvc_mobile/domain/repository/bao_cao/report_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class ReportListCubit extends BaseCubit<BaseState> {
  ReportListCubit() : super(ReportListStateInitial()) {
    getAppID();
  }

  String appId = '';
  String folderId = '';
  int sort = A_Z_SORT;
  static const String CODE = 'HTCS';
  static const int ALL = 0;
  static const int A_Z_SORT = 4;
  static const int Z_A_SORT = 5;
  static const int NEW_SORT = 6;
  static const int OLDEST_SORT = 7;
  static const int FOLDER_SORT = 12;
  static const int REPORT_SORT = 13;

  BehaviorSubject<String> textFilter = BehaviorSubject.seeded(S.current.tu_a_z);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textFilterBox = BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<bool> isCheckList = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isStatusSearch = BehaviorSubject.seeded(true);
  BehaviorSubject<List<ReportItem>> listReportFavorite =
      BehaviorSubject.seeded([]);

  ReportRepository get _reportService => Get.find();

  ReportCommonRepository get _reportCommonService => Get.find();

  void getStatus(String title) {
    if (S.current.all == title) {
      sort = ALL;
    } else if (S.current.bac_cao == title) {
      sort = REPORT_SORT;
    } else if (S.current.thu_muc == title) {
      sort = FOLDER_SORT;
    } else if (S.current.tu_a_z == title) {
      sort = A_Z_SORT;
    } else if (S.current.tu_z_a == title) {
      sort = Z_A_SORT;
    } else if (S.current.sap_xep_theo_moi_nhat == title) {
      sort = NEW_SORT;
    } else if (S.current.sap_xep_theo_cu_nhat == title) {
      sort = OLDEST_SORT;
    } else {
      sort = ALL;
    }
  }

  Future<void> getAppID() async {
    showLoading();
    final Result<List<HTCSModel>> result = await _reportCommonService.getHTCS(
      CODE,
    );
    result.when(
      success: (res) {
        appId = res.first.id ?? '';
        if (appId.isNotEmpty) {
          getFolderID();
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getFolderID() async {
    final Result<FolderModel> result = await _reportService.getFolderID(appId);
    result.when(
      success: (res) {
        folderId = res.id ?? '';
        if (folderId.isNotEmpty) {
          getListReport();
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<bool> postFavorite({required List<String> idReport}) async {
    showLoading();
    bool isStatus = false;
    final Result result = await _reportService.postLikeReportFavorite(
      idReport,
      appId,
    );
    result.when(
      success: (res) {
        showContent();
        isStatus = res;
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
        isStatus = false;
      },
    );
    return isStatus;
  }

  Future<bool> putDislikeFavorite({required List<String> idReport}) async {
    showLoading();
    bool isStatus = false;
    final Result result = await _reportService.putDislikeReportFavorite(
      idReport,
      appId,
    );
    result.when(
      success: (res) {
        showContent();
        isStatus = res;
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
        isStatus = false;
      },
    );
    return isStatus;
  }

  void clearSearch() {
    isStatusSearch.add(true);
    textSearch.add('');
  }

  void filterBox(String value) {
    textFilterBox.add(value);
    getStatus(value);
    getListReport();
  }

  Future<void> getListReport() async {
    showLoading();
    final Result<List<ReportItem>> result = await _reportService.getListReport(
      folderId,
      sort,
      textSearch.value,
      appId,
    );
    result.when(
      success: (res) {
        final List<ReportItem> listFavorite = [];
        final List<ReportItem> list = [];
        for (final value in res) {
          if (value.isPin ?? false) {
            listFavorite.add(value);
          } else {
            list.add(value);
          }
        }
        listReportFavorite.sink.add(listFavorite);
        if (!res.isNotEmpty) {
          showEmpty();
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: list));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }
}
