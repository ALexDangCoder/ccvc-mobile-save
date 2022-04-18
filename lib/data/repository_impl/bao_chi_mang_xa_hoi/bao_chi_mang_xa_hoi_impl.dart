import 'dart:convert';
import 'dart:ffi';

import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke/tong_quan_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/bao_cao_thong_ke_resopnse.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/dash_board_tat_ca_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/list_chu_de_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/menu_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/search_tin_tuc_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/theo_doi_bai_viet_response.dart';
import 'package:ccvc_mobile/data/response/bao_chi_mang_xa_hoi/tin_tuc_thoi_su_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_service.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bao_cao_tong_quan_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tin_tuc_thoi_su/tin_tuc_thoi_su_model.dart';
import 'package:ccvc_mobile/domain/repository/bao_chi_mang_xa_hoi/bao_chi_mang_xa_hoi_repository.dart';

class BaoChiMangXaHoiImpl implements BaoChiMangXaHoiRepository {
  final BaoChiMangXaHoiService _baoChiMangXaHoiService;

  BaoChiMangXaHoiImpl(this._baoChiMangXaHoiService);

  @override
  Future<Result<DashBoardModel>> getDashBoardTatCaChuDe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<List<DashBoardTatCaChuDeResponse>, DashBoardModel>(
        () => _baoChiMangXaHoiService.getDashBoardTatCaChuDe(
              pageIndex,
              pageSize,
              total,
              hasNextPage,
              fromDate,
              toDate,
            ), (res) {
      final data = res.map((e) => e.toDomain()).toList();
      final List<ItemInfomationModel> lisDataItem = [];
      for (int i = 0; i < data.length; i++) {
        lisDataItem.add(
          ItemInfomationModel(
            title: data[i].sourceTitle,
            index: data[i].total.toString(),
            image: listIconDashBoard[i],
            color: listColorsItemDashBoard[i],
          ),
        );
      }
      return DashBoardModel(listItemDashBoard: lisDataItem);
    });
  }

  @override
  Future<Result<ListChuDeModel>> getDashListChuDe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<ListChuDeResponse, ListChuDeModel>(
      () => _baoChiMangXaHoiService.getListTatCaChuDe(
        pageIndex,
        pageSize,
        total,
        hasNextPage,
        fromDate,
        toDate,
      ),
      (res) => res.toDomain(),
    );
  }

  Future<Result<TuongTacThongKeResponseModel>> getTuongTacThongKe(
    int pageIndex,
    int pageSize,
    int total,
    bool hasNextPage,
    String fromDate,
    String toDate,
  ) {
    return runCatchingAsync<String, TuongTacThongKeResponseModel>(
      () => _baoChiMangXaHoiService.getBaoCaoThongKe(
        pageIndex,
        pageSize,
        total,
        hasNextPage,
        fromDate,
        toDate,
      ),
      (res) => TuongTacThongKeResponse.fromJson(json.decode(res)).toDomain(),
    );
  }

  @override
  Future<Result<List<ListMenuItemModel>>> getMenuBCMXH() {
    return runCatchingAsync<List<MenuBCMXHResponse>, List<ListMenuItemModel>>(
      () => _baoChiMangXaHoiService.getMenuBCMXH(),
      (res) => res.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<TinTucRadioResponseModel>> getTinTucThoiSu(
      int pageIndex, int pageSize, String fromDate, String toDate, int topic) {
    return runCatchingAsync<String, TinTucRadioResponseModel>(
      () => _baoChiMangXaHoiService.getTinTucThoiSu(
        pageIndex,
        pageSize,
        fromDate,
        toDate,
        topic,
      ),
      (res) => TinTucThoiSuResponse.fromJson(json.decode(res)).toDomain(),
    );
  }

  @override
  Future<Result<TheoDoiBaiVietModel>> getBaiVietTheoDoi(
      int pageIndex, int pageSize, String fromDate, String toDate, int topic) {
    return runCatchingAsync<String, TheoDoiBaiVietModel>(
        () => _baoChiMangXaHoiService.getTheoDoiBaiViet(
              pageIndex,
              pageSize,
              fromDate,
              toDate,
              topic,
            ), (res) {
      return TheoDoiBaiVietResponse.fromJson(json.decode(res)).toDomain();
    });
  }

  @override
  Future<Result<TinTucModel>> searchTinTuc(
    int pageIndex,
    int pageSize,
    String fromDate,
    String toDate,
    String keyword,
  ) {
    return runCatchingAsync<SearchTinTucResponse, TinTucModel>(
        () => _baoChiMangXaHoiService.searchTinTuc(
              pageIndex,
              pageSize,
              fromDate,
              toDate,
              keyword,
            ), (res) {
      return res.toDomain();
    });
  }

  @override
  Future<Result<BaoCaoTongQuanModel>> tongQuanBaoCaoThongKe(
    String fromDate,
    String enddDate,
    int treeNode,
  ) {
    return runCatchingAsync<TongQuanDeResponse, BaoCaoTongQuanModel>(
        () => _baoChiMangXaHoiService.baoCaoTongQuan(
              fromDate,
              enddDate,
              treeNode,
            ), (res) {
      return res.toDomain();
    });
  }
}

