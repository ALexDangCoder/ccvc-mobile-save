import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/data/request/home/danh_sach_van_ban_den_request.dart';
import 'package:ccvc_mobile/domain/model/document/incoming_document.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

enum TypeScreen { VAN_BAN_DEN, VAN_BAN_DI }
enum TypeScreenDashBoard { DASHBOARD }

class IncomingDocumentCubit extends BaseCubit<BaseState> {
  IncomingDocumentCubit() : super(IncomingDocumentStateIntial());
  int nextPage = 1;
  int totalPage = 1;
  List<String> maTrangThai = [];
  bool? isDanhSachChoXuLy;
  bool? isDanhSachDaXuLy;
  bool? isDanhSachChoTrinhKy;
  List<int> trangThaiFilter = [];

  final BehaviorSubject<List<VanBanModel>> _getListVBDen =
      BehaviorSubject<List<VanBanModel>>();

  Stream<List<VanBanModel>> get getListVbDen => _getListVBDen.stream;

  Future<void> callAPi() async {
    await listDataVBDen();
  }

  final QLVBRepository _QLVBRepo = Get.find();

  Future<void> listDataVBDen() async {
    List<VanBanModel> listVbDen = [];
    final result = await _QLVBRepo.getVanBanModel();
    result.when(
      success: (res) {
        listVbDen = res.pageData ?? [];
        _getListVBDen.sink.add(listVbDen);
      },
      error: (err) {
        return err;
      },
    );
  }

  Future<void> listDataDanhSachVBDen({
    required bool isDanhSachDaXuLy,
    required String startDate,
    required String endDate,
    required int page,
    required int size,
    required List<String> maTrangThai,
  }) async {
    loadMorePage = page;
    final result = await _QLVBRepo.getDanhSachVbDen(
      DanhSachVBRequest(
        isDanhSachDaXuLy: isDanhSachDaXuLy,
        maTrangThai: maTrangThai,
        index: page,
        isChoYKien: null,
        isSortByDoKhan: null,
        thoiGianStartFilter: startDate,
        thoiGianEndFilter: endDate,
        size: 10,
      ),
    );
    result.when(
      success: (res) {
        if (page == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
        }
      },
      error: (error) {
        emit(const CompletedLoadMore(CompleteType.ERROR));
        showError();
      },
    );
  }

  Future<void> listDataDanhSachVBDi({
    required String startDate,
    required String endDate,
    required int index,
    required int size,
  }) async {
    if (index == ApiConstants.PAGE_BEGIN) {}
    loadMorePage = index;
    final result = await _QLVBRepo.getDanhSachVbDi(
      startDate: startDate,
      endDate: endDate,
      index: index,
      size: size,
    );
    result.when(
      success: (res) {
        if (index == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
        }
      },
      error: (err) {
        return err;
      },
    );
  }

  Future<void> listDataDanhSachVBDiDashBoard({
    required String startDate,
    required String endDate,
    required bool isDanhSachChoXuLy,
    required bool isDanhSachDaXuLy,
    required bool isDanhSachChoTrinhKy,
    required List<int> trangThaiFilter,
    required int index,
    required int size,
  }) async {
    if (index == ApiConstants.PAGE_BEGIN) {}
    loadMorePage = index;
    final result = await _QLVBRepo.getDanhSachVbDiDashBoard(
        startDate,
        endDate,
        isDanhSachChoXuLy,
        isDanhSachDaXuLy,
        isDanhSachChoTrinhKy,
        trangThaiFilter,
        index,
        size);
    result.when(
      success: (res) {
        if (index == ApiConstants.PAGE_BEGIN) {
          if (res.pageData?.isEmpty ?? true) {
            showEmpty();
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
          }
        } else {
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res.pageData));
        }
      },
      error: (err) {
        return err;
      },
    );
  }

  List<IncomingDocument> listIncomingDocument = [
    IncomingDocument(
        'Thượng khẩn',
        'V/v kết nối, liên thông phần mềm QLVB drtgdfgdf',
        '2022-01-11T00:00:00',
        'Hà Kiều Anh'),
    IncomingDocument('Thượng khẩn', 'V/v kết nối, liên thông phần mềm QLVB',
        '2022-01-11T00:00:00', 'Hà Kiều Anh'),
    IncomingDocument('Thượng khẩn', 'V/v kết nối, liên thông phần mềm QLVB',
        '2022-01-11T00:00:00', 'Hà Kiều Anh'),
    IncomingDocument('Thượng khẩn', 'V/v kết nối, liên thông phần mềm QLVB',
        '2022-01-11T00:00:00', 'Hà Kiều Anh'),
    IncomingDocument('Thượng khẩn', 'V/v kết nối, liên thông phần mềm QLVB',
        '2022-01-11T00:00:00', 'Hà Kiều Anh'),
  ];
}
