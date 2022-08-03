import 'dart:async';

import 'package:ccvc_mobile/bao_cao_module/config/base/base_state.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/htcs_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_detail_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_common_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/report_repository.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_state.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/result/result.dart';
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
  int sortHome = A_Z_SORT;
  static const String CODE = 'HTCS';
  static const int ALL = 0;
  static const int A_Z_SORT = 4;
  static const int Z_A_SORT = 5;
  static const int NEW_SORT = 7;
  static const int OLDEST_SORT = 6;
  static const int FOLDER_SORT = 12;
  static const int REPORT_SORT = 13;
  static const int STATUS_DA_XUAT_BAN = 2;
  Timer? debounceTime;
  bool isListViewInit = true;
  BehaviorSubject<String> textFilter = BehaviorSubject.seeded(S.current.tu_a_z);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String?> urlReportWebView = BehaviorSubject();
  BehaviorSubject<String> textFilterBox = BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<bool> isListView = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isStatusSearch = BehaviorSubject.seeded(true);
  List<ReportItem>? listReportFavorite;

  BehaviorSubject<List<ReportItem>?> listReportTree =
      BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReportItem>?> listReportTreeUpdate =
      BehaviorSubject.seeded(null);
  BehaviorSubject<bool> isCheckDataDetailScreen = BehaviorSubject.seeded(false);
  List<ReportItem>? listReport;
  List<ReportItem>? listReportSearch;
  bool isCheckPostFavorite = false;

  ReportRepository get _reportService => Get.find();

  ReportCommonRepository get _reportCommonService => Get.find();

  void clickIconSearch() {
    sort = ALL;
    textSearch.add('');
    textFilterBox.sink.add(S.current.all);
    getListReport(
      isSearch: true,
    );
    isStatusSearch.add(false);
  }

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

  void searchReport(String value) {
    textSearch.add(value.trim());
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    debounceTime = Timer(const Duration(milliseconds: 500), () {
      getListReport(
        isSearch: true,
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
          getFolderID();
        } else {
          emit(const CompletedLoadMore(CompleteType.ERROR));
          showError();
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getReportDetail({
    required String idReport,
  }) async {
    showLoading();
    urlReportWebView.add(null);
    final Result<ReportDetailModel> result =
        await _reportService.getReportDetail(
      appId,
      idReport,
    );
    result.when(
      success: (res) {
        if (res.urls?.desktop?.isNotEmpty ?? false) {
          urlReportWebView.add(res.urls?.desktop ?? '');
          emit(const CompletedLoadMore(CompleteType.SUCCESS));
          showContent();
        } else {
          urlReportWebView.add('');
          emit(const CompletedLoadMore(CompleteType.ERROR));
          showContent();
        }
      },
      error: (error) {
        urlReportWebView.add(null);
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getFolderID() async {
    final Result<ReportItem> result = await _reportService.getFolderID(appId);
    result.when(
      success: (res) {
        folderId = res.id ?? '';
        if (folderId.isNotEmpty) {
          getListReport();
        } else {
          emit(const CompletedLoadMore(CompleteType.ERROR));
          showError();
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<bool> postFavorite({
    required List<String> idReport,
  }) async {
    showLoading();
    bool isStatus = false;
    final Result<bool> result = await _reportService.postLikeReportFavorite(
      idReport,
      appId,
    );
    result.when(
      success: (res) {
        isStatus = res;
      },
      error: (error) {
        isStatus = false;
      },
    );
    isCheckPostFavorite = isStatus;
    showContent();
    return isStatus;
  }

  Future<bool> putDislikeFavorite({
    required List<String> idReport,
  }) async {
    showLoading();
    bool isStatus = false;
    final Result<bool> result = await _reportService.putDislikeReportFavorite(
      idReport,
      appId,
    );
    result.when(
      success: (res) {
        isStatus = res;
      },
      error: (error) {
        isStatus = false;
      },
    );
    isCheckPostFavorite = isStatus;
    showContent();
    return isStatus;
  }

  void clearSearch() {
    isStatusSearch.add(true);
    sort=sortHome;
    getListReport();
  }

  bool checkHideIcMore({
    required int typeReport,
    required bool isReportShareToMe,
  }) {
    if (typeReport == REPORT || !isReportShareToMe) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> reloadDataWhenFavorite({
    String idFolder = '',
    bool isTree = false,
    bool isSearch = false,
  }) async {
    if (isCheckPostFavorite) {
      if (isTree) {
        await getListReport(
          isTree: isTree,
          idFolder: idFolder,
        );
        listReportTreeUpdate.add(listReportTree.value);
      } else if (isSearch) {
        await getListReport(
          isSearch: isSearch,
        );
      } else {
        await getListReport();
      }
    }
  }

  void filterBox(String value) {
    textFilterBox.add(value);
    getStatus(value);
    getListReport(
      isSearch: true,
    );
  }

  Future<void> getListFavorite() async {
    listReportFavorite = null;
    final Result<List<ReportItem>> result =
        await _reportService.getListReportFavorite(
      appId,
      folderId,
      sort,
    );
    result.when(
      success: (res) {
        listReportFavorite = checkListReportStatus(res);
      },
      error: (error) {},
    );
  }

  int checkFilterBox(int sort) {
    switch (sort) {
      case REPORT_SORT:
        return REPORT;
      case FOLDER_SORT:
        return FOLDER;
      default:
        return All;
    }
  }

  Future<void> getListReport({
    String idFolder = '',
    bool isTree = false,
    bool isSearch = false,
  }) async {
    showLoading();
    emit(const CompletedLoadMore(CompleteType.ERROR));
    if (isTree) {
      textSearch.add('');
      isCheckDataDetailScreen.add(false);
      listReportTree.add(null);
    } else if (isSearch) {
      listReportSearch = null;
    } else {
      sortHome = sort;
      listReport = null;
      await getListFavorite();
    }
    final Result<List<ReportItem>> result = await _reportService.getListReport(
      idFolder.isNotEmpty ? idFolder : folderId,
      isTree ? A_Z_SORT : sort,
      textSearch.value,
      appId,
    );
    result.when(
      success: (res) {
        isCheckDataDetailScreen.add(true);
        if (res.isEmpty) {
          if (isSearch) {
            listReportSearch = [];
          } else if (isTree) {
            listReportTree.add([]);
          } else {
            listReport = [];
          }
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          final listRes = checkListReport(res);
          final listStatus = checkListReportStatus(res);
          if (!isTree) {
            if (!isSearch) {
              listReport = listRes;
            } else {
              if (sort == ALL) {
                listReportSearch = listStatus;
              } else {
                listReportSearch = checkListSearch(listStatus);
              }
            }
          } else {
            listReportTree.add(listStatus);
          }
          emit(
            CompletedLoadMore(CompleteType.SUCCESS, posts: listRes),
          );
        }
        showContent();
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  List<ReportItem> checkListSearch(List<ReportItem> listStatus) {
    final List<ReportItem> listSearch = [];
    for (final value in listStatus) {
      if (value.type == checkFilterBox(sort)) {
        listSearch.add(value);
      }
    }
    return listSearch;
  }

  bool checkStatusReport(ReportItem reportItem) {
    if (reportItem.status == STATUS_DA_XUAT_BAN) {
      return true;
    }
    return false;
  }

  List<ReportItem> checkListReportStatus(List<ReportItem> listRes) {
    final List<ReportItem> list = [];
    for (final value in listRes) {
      if (value.type == REPORT) {
        if (checkStatusReport(value)) {
          list.add(value);
        }
      } else {
        list.add(value);
      }
    }
    return list;
  }

  List<ReportItem> checkListReport(List<ReportItem> listRes) {
    final List<ReportItem> list = [];
    for (final value in listRes) {
      if (value.isPin == false) {
        if (value.type == REPORT) {
          if (checkStatusReport(value)) {
            list.add(value);
          }
        } else {
          list.add(value);
        }
      }
    }
    return list;
  }
}
