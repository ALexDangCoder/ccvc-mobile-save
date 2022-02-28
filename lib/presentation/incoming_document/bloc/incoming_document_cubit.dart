import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/model/document/incoming_document.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

enum LoadMoreType {
  CAN_LOAD_MORE,
  LOAD_MORE_FAIL,
  NOT_CAN_LOAD_MORE,
}

class IncomingDocumentCubit extends BaseCubit<BaseState> {
  IncomingDocumentCubit() : super(IncomingDocumentStateIntial());
  int nextPage = 1;
  int totalPage = 1;
  final BehaviorSubject<LoadMoreType> canLoadMoreSubject =
      BehaviorSubject<LoadMoreType>();

  Stream<LoadMoreType> get canLoadMoreStream => canLoadMoreSubject.stream;

  final BehaviorSubject<List<VanBanModel>> _getListVBDen =
      BehaviorSubject<List<VanBanModel>>();

  Stream<List<VanBanModel>> get getListVbDen => _getListVBDen.stream;

  Future<void> callAPi({int? nextPage}) async {
    final queue = Queue(parallel: 2);
    unawaited(
      queue.add(
        () => listDataVBDen(),
      ),
    );
    unawaited(
      queue.add(
        () => listDataDanhSachVBDen(
          startDate: '2022-02-01',
          endDate: '2022-02-28',
          page: nextPage ?? 1,
          size: 10,
        ),
      ),
    );
    await queue.onComplete;
    showContent();
    queue.dispose();
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
    required String startDate,
    required String endDate,
    required int page,
    required int size,
  }) async {
    if (page == ApiConstants.PAGE_BEGIN) {
      showLoading();
    }
    loadMorePage = page;
    final result =
        await _QLVBRepo.getDanhSachVbDen(startDate, endDate, page, size);
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
        showError();
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
