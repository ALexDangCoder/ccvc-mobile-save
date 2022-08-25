import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';

extension DocumentInCubit on QLVBCCubit {
  Future<void> getDashBoardIncomeDocument({
    String? startDate,
    String? endDate,
  }) async {
    final codeChucVu =
        HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.maChucVu ??
            '';
    final result = await qLVBRepo.getVBDen(
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
    result.when(
      success: (res) {
        chartDataVbDen.clear();
        final DocumentDashboardModel dataVbDen = res;
        chartDataVbDen.add(
          ChartData(
            S.current.cho_xu_ly,
            dataVbDen.soLuongChoXuLy?.toDouble() ?? 0,
            color5A8DEE,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.dang_xu_ly,
            dataVbDen.soLuongDangXuLy?.toDouble() ?? 0,
            dangXyLyColor,
          ),
        );
        chartDataVbDen.add(
          ChartData(
            S.current.da_xu_ly,
            dataVbDen.soLuongDaXuLy?.toDouble() ?? 0,
            daXuLyColor,
          ),
        );
        if (codeChucVu == ChucVu.VT) {
          chartDataVbDen.add(
            ChartData(
              S.current.cho_vao_so,
              dataVbDen.soLuongChoVaoSo?.toDouble() ?? 0,
              choVaoSoColor,
            ),
          );
        }
        getVbDen.sink.add(dataVbDen);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<List<VanBanModel>> getListIncomeDocument({
    String? startDate,
    String? endDate,
    int? page,
  }) async {
    List<VanBanModel> listVbDen = [];
    final result = await qLVBRepo.getDanhSachVbDen(
      DanhSachVBRequest(
        maTrangThai: statusSearchDocumentInCode(documentInStatusCode),
        index: page ?? ApiConstants.PAGE_BEGIN,
        thoiGianStartFilter: startDate ?? this.startDate,
        thoiGianEndFilter: endDate ?? this.endDate,
        size: ApiConstants.DEFAULT_PAGE_SIZE,
        trichYeu: keySearch.trim(),
        trangThaiXuLy: statusSearchDocumentInSubCode(documentInSubStatusCode),
        isDanhSachDaXuLy: documentInSubStatusCode.isNotEmpty ? false : null,
        isSortByTrangThai: true,
      ),
    );
    result.when(
      success: (res) {
        listVbDen = res.pageData ?? [];
      },
      error: (error) {
      },
    );
    return listVbDen;
  }

  Future<void> fetchIncomeDocumentCustom({
    bool initLoad = false,
    bool loadingCircle = true,
  }) async {
    if (initLoad) {
      vbDenLoadMore = true;
      listVBDen.clear();
    }
    final currentPage = listVBDen.length ~/ ApiConstants.DEFAULT_PAGE_SIZE;
    if (!vbDenLoading && vbDenLoadMore) {
      if (loadingCircle) {
        showLoading();
      }
      vbDenLoading = true;
      final newItems = await getListIncomeDocument(
        page: currentPage + 1,
      );
      vbDenLoadMore = newItems.length >= ApiConstants.DEFAULT_PAGE_SIZE;
      vbDenLoading = false;
      listVBDen.addAll(newItems);
      danhSachVBDen.sink.add(listVBDen);
      if (loadingCircle) {
        showContent();
      }
    }
  }
}
