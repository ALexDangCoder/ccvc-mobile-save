import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/van_ban_model.dart';
import 'package:ccvc_mobile/domain/repository/qlvb_repository/qlvb_repository.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class OutgoingDocumentCubit extends BaseCubit<IncomingDocumentState> {
  OutgoingDocumentCubit() : super(IncomingDocumentStateIntial());

  final BehaviorSubject<List<VanBanModel>> _getListVBDi =
      BehaviorSubject<List<VanBanModel>>();

  Stream<List<VanBanModel>> get getListVbDi => _getListVBDi.stream;

  final BehaviorSubject<List<VanBanModel>> _getDanhSachVBDi =
      BehaviorSubject<List<VanBanModel>>();

  Stream<List<VanBanModel>> get getDanhSachVbDi => _getDanhSachVBDi.stream;

  void callAPi() async {
    final queue = Queue(parallel: 1);
    showLoading();
    unawaited(
      queue.add(
        () => listDataDanhSachVBDi(
          startDate: '2022-02-01',
          endDate: '2022-02-28',
          index: 1,
          size: 10,
        ),
      ),
    );
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  final QLVBRepository _QLVBRepo = Get.find();

  Future<void> listDataDanhSachVBDi({
    required String startDate,
    required String endDate,
    required int index,
    required int size,
  }) async {
    List<VanBanModel> listVbDi = [];
    final result = await _QLVBRepo.getDanhSachVbDi(
      startDate: startDate,
      endDate: endDate,
      index: index,
      size: size,
    );
    result.when(
      success: (res) {
        listVbDi = res.pageData ?? [];

        _getDanhSachVBDi.sink.add(listVbDi);
      },
      error: (err) {
        return err;
      },
    );
  }
}
