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
  List<ReportItem> listReportFavorite = [];
  BehaviorSubject<List<ReportItem>?> listReportTree =
      BehaviorSubject.seeded(null);
  BehaviorSubject<List<ReportItem>?> listReportTreeUpdate =
      BehaviorSubject.seeded(null);
  BehaviorSubject<bool> isCheckData = BehaviorSubject.seeded(false);
  List<ReportItem> listReport = [];
  List<ReportItem> listReportSearch = [];
  bool isCheckPostFavorite = false;

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
        showContent();
        isStatus = res;
      },
      error: (error) {
        isStatus = false;
      },
    );
    isCheckPostFavorite = isStatus;
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
        showContent();
        isStatus = res;
      },
      error: (error) {
        isStatus = false;
      },
    );
    isCheckPostFavorite = isStatus;
    return isStatus;
  }

  void clearSearch() {
    isStatusSearch.add(true);
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
  }) async {
    if (isCheckPostFavorite) {
      if (isTree) {
        await getListReport(
          isTree: isTree,
          idFolder: idFolder,
        );
        listReportTreeUpdate.add(listReportTree.value);
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
    listReportFavorite.clear();
    final Result<List<ReportItem>> result =
        await _reportService.getListReportFavorite(
      appId,
      folderId,
    );
    result.when(
      success: (res) {
        listReportFavorite.addAll(res);
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> getListReport({
    String idFolder = '',
    bool isTree = false,
    bool isSearch = false,
    bool isTreeShareToMe = false,
  }) async {
    showLoading();
    emit(const CompletedLoadMore(CompleteType.ERROR, posts: []));
    if (isTree) {
      isCheckData.add(false);
      listReportTree.add(null);
    } else if (isSearch) {
      // listReportSearch.clear();
    } else {
      listReport.clear();
      await getListFavorite();
    }
    await getListReportShareToMe(
      idFolder: idFolder,
      isSearch: isSearch,
      isTree: isTree,
    );
    final Result<List<ReportItem>> result = await _reportService.getListReport(
      idFolder.isNotEmpty ? idFolder : folderId,
      sort,
      textSearch.value,
      appId,
    );
    result.when(
      success: (res) {
        if (!isTreeShareToMe) {
          isCheckData.add(true);
        }
        if (res.isEmpty) {
          showContent();
          if (!isTreeShareToMe) {
            listReportTree.add([]);
          }
          if (isSearch) {
            listReportSearch.addAll([]);
          }
          emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
        } else {
          if (!isTreeShareToMe) {
            listReportTree.add(res);
          }
          final List<ReportItem> list = [];
          if (!isTree) {
            for (final value in res) {
              if (value.isPin == false) {
                list.add(value);
              }
            }
            if (!isSearch) {
              listReport.addAll(list);
            }
            listReportSearch.addAll(res);
          }
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

  Future<void> getListReportShareToMe({
    String idFolder = '',
    bool isTree = false,
    bool isSearch = false,
  }) async {
    final Result<List<ReportItem>> resultReportShareToMe =
        await _reportService.getListReportShareToMe(
      idFolder.isNotEmpty ? idFolder : folderId,
      sort,
      textSearch.value,
      appId,
    );
    resultReportShareToMe.when(
      success: (res) {
        final resultFinal = res
            .map(
              (e) => ReportItem(
                id: e.id,
                name: e.name,
                description: e.description,
                order: e.order,
                parentId: e.parentId,
                numberReport: e.numberReport,
                childrenTotal: e.childrenTotal,
                type: e.type,
                typeTitle: e.typeTitle,
                level: e.level,
                isOwner: e.isOwner,
                dateTime: e.createdAt,
                isPin: e.isPin,
                status: e.status,
                isShareToMe: true,
              ),
            )
            .toList();
        if (resultFinal.isEmpty) {
          listReportTree.add([]);
          if (isSearch) {
            listReportSearch.clear();
            listReportSearch.addAll([]);
          }
        } else {
          listReportTree.add(resultFinal);
          final List<ReportItem> list = [];
          if (!isTree) {
            for (final value in resultFinal) {
              if (value.isPin == false) {
                list.add(value);
              }
            }
            if (!isSearch) {
              listReport.addAll(list);
            }
            listReportSearch.clear();
            listReportSearch.addAll(resultFinal);
          }
          isCheckData.add(true);
        }
      },
      error: (error) {},
    );
  }
}
