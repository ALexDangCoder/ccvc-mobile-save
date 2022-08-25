import 'dart:async';
import 'dart:core';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/views/show_loading_screen.dart';

extension DocumentOutCubit on QLVBCCubit {
  Future<void> getDashBoardOutcomeDocument({
    String? startDate,
    String? endDate,
  }) async {
    final result = await qLVBRepo.getVBDi(
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
    result.when(
      success: (res) {
        chartDataVbDi.clear();
        final dataVbDi = DocumentDashboardModel(
          soLuongChoTrinhKy: res.soLuongChoTrinhKy,
          soLuongChoXuLy: res.soLuongChoXuLy,
          soLuongDaXuLy: res.soLuongDaXuLy,
          soLuongThuongKhan: res.soLuongThuongKhan,
          soLuongChoBanHanh: res.soLuongChoBanHanh,
          soLuongChoCapSo: res.soLuongChoCapSo,
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_trinh_ky,
            dataVbDi.soLuongChoTrinhKy?.toDouble() ?? 0,
            choTrinhKyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDi.soLuongChoXuLy?.toDouble() ?? 0,
            color5A8DEE,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDi.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_cap_so,
            dataVbDi.soLuongChoCapSo?.toDouble() ?? 0,
            choCapSoColor,
          ),
        );
        chartDataVbDi.add(
          ChartData(
            S.current.cho_ban_hanh,
            dataVbDi.soLuongChoBanHanh?.toDouble() ?? 0,
            choBanHanhColor,
          ),
        );
        getVbDi.sink.add(dataVbDi);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<List<VanBanModel>> getListOutcomeDocument({
    String? startDate,
    String? endDate,
    int? page,
  }) async {
    List<VanBanModel> listVbDi = [];
    final result = await qLVBRepo.getDanhSachVbDi(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      index: page ?? ApiConstants.PAGE_BEGIN,
      size: ApiConstants.DEFAULT_PAGE_SIZE,
      isDanhSachChoTrinhKy: getStatus(DocumentState.CHO_TRINH_KY),
      isDanhSachChoXuLy: getStatus(DocumentState.CHO_XU_LY),
      isDanhSachDaXuLy: getStatus(DocumentState.DA_XU_LY),
      isDanhSachChoBanHanh: getStatus(DocumentState.CHO_BAN_HANH),
      isDanhSachChoCapSo: getStatus(DocumentState.CHO_CAP_SO),
      trangThaiFilter: statusSearchDocumentOutCode(documentOutStatusCode),
      searchTitle: keySearch.trim(),
    );
    result.when(
      success: (res) {
        listVbDi = res.pageData ?? [];
      },
      error: (err) {
        return err;
      },
    );
    return listVbDi;
  }

  Future<void> fetchOutcomeDocumentCustom({
    bool initLoad = false,
    bool loadingCircle = true,
  }) async {
    if (loadingCircle) {
    ShowLoadingScreen.show();
    }
    if (initLoad) {
      vbDiLoadMore = true;
      listVBDi.clear();
      danhSachVBDi.sink.add(null);
    }
    final currentPage = listVBDi.length ~/ ApiConstants.DEFAULT_PAGE_SIZE;
    if (!vbDiLoading && vbDiLoadMore) {
      vbDiLoading = true;
      final newItems = await getListOutcomeDocument(
        page: currentPage + 1,
      );
      vbDiLoadMore = newItems.length >= ApiConstants.DEFAULT_PAGE_SIZE;
      vbDiLoading = false;
      listVBDi.addAll(newItems);
      danhSachVBDi.sink.add(listVBDi);
    }
    if (loadingCircle) {
    ShowLoadingScreen.dismiss();
    }
  }
}
