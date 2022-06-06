import 'dart:io';
import 'dart:math';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TaoLichHopCubit extends BaseCubit<TaoLichHopState> {
  TaoLichHopCubit() : super(MainStateInitial());

  HopRepository get hopRp => Get.find();
  final BehaviorSubject<List<LoaiSelectModel>> _loaiLich = BehaviorSubject();
  final BehaviorSubject<ChuongTrinhHopModel> chuongTrinhHopSubject =
      BehaviorSubject();

  Stream<ChuongTrinhHopModel> get chuongTrinhHopStream =>
      chuongTrinhHopSubject.stream;

  Stream<List<LoaiSelectModel>> get loaiLich => _loaiLich.stream;
  final BehaviorSubject<List<LoaiSelectModel>> _linhVuc = BehaviorSubject();

  Stream<List<LoaiSelectModel>> get linhVuc => _linhVuc.stream;
  final BehaviorSubject<List<NguoiChutriModel>> _nguoiChuTri =
      BehaviorSubject();

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  BehaviorSubject<List<DsDiemCau>> dsDiemCauSubject =
      BehaviorSubject.seeded([]);

  LoaiSelectModel? selectLoaiHop;
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;
  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest(
    ngayBatDau: DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
    ngayKetThuc: DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date),
    timeStart: DateTime.now().dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
    timeTo: DateTime.now()
        .add(const Duration(hours: 1))
        .dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
    isAllDay: false,
    bitTrongDonVi: true,
    chuTri: ChuTri(),
    dsDiemCau: <DsDiemCau>[],
  );

  String donViId = '';

  List<String> fileIds = [];

  List<File> listFile = [];

  Future<void> createMeeting() async {
    /// check loại họp
    if (taoLichHopRequest.typeScheduleId?.isEmpty ?? true) {
      try {
        taoLichHopRequest.typeScheduleId = _loaiLich.value.first.id;
      } catch (e) {
        //
      }
    }

    /// check lĩnh vực
    if (taoLichHopRequest.linhVucId?.isEmpty ?? true) {
      try {
        taoLichHopRequest.linhVucId = _linhVuc.value.first.id;
      } catch (e) {
        //
      }
    }

    /// check cả ngày?
    if (taoLichHopRequest.isAllDay ?? false) {
      taoLichHopRequest.timeTo = '';
      taoLichHopRequest.timeStart = '';
    }

    /// check hình thức họp
    if (taoLichHopRequest.bitHopTrucTuyen != null) {
      if (taoLichHopRequest.bitHopTrucTuyen!) {
        taoLichHopRequest.diaDiemHop = '';
      } else {
        //
      }
    }

    /// check cơ quan chủ trì
    if (!(taoLichHopRequest.bitTrongDonVi ?? true)) {
      taoLichHopRequest.chuTri?.donViId = null;
      taoLichHopRequest.chuTri?.canBoId = null;
      taoLichHopRequest.chuTri?.tenCanBo = null;
    }
    showLoading();
    await postFileTaoLichHop(files: listFile);
    taoLichHopRequest.thuMoiFiles = fileIds.join(',');

    /// data hardcode mai hỏi BE
    taoLichHopRequest.mucDo = 0;
    taoLichHopRequest.isLichLap = false;
    taoLichHopRequest.congKhai = false;
    taoLichHopRequest.typeReminder = 1;

    ///cần hỏi BE xem là gì
    taoLichHopRequest.lichDonVi = false;
    final result = await hopRp.taoLichHop(taoLichHopRequest);
    result.when(
      success: (res) {
        MessageConfig.show();
      },
      error: (error) {},
    );
    showContent();
  }

  void loadData() {
    _getLoaiLich();
    _getPhamVi();
    getCanBo();
  }

  Future<void> _getLoaiLich() async {
    showLoading();
    final result = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLoaiHop = res.first;
        }
        _loaiLich.sink.add(res);
      },
      error: (err) {},
    );
    showContent();
  }

  Future<void> getChuongTrinhHop(String id) async {
    final result = await hopRp.getChuongTrinhHop(id);
    result.when(
      success: (value) {
        chuongTrinhHopSubject.add(value);
      },
      error: (error) {},
    );
  }

  Future<void> _getPhamVi() async {
    final result = await hopRp.getLinhVuc(
      CatogoryListRequest(
        pageIndex: 1,
        pageSize: 100,
        type: 1,
      ),
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          selectLinhVuc = res.first;
        }
        _linhVuc.sink.add(res);
      },
      error: (err) {},
    );
  }

  ThanhPhanThamGiaReponsitory get thanhPhanThamGiaRp => Get.find();

  final BehaviorSubject<List<DonViModel>> danhSachCB = BehaviorSubject();

  Future<void> getCanBo() async {
    final result = await thanhPhanThamGiaRp.getSeachCanBo(
      SearchCanBoRequest(
        iDDonVi: donViId,
        pageIndex: 1,
        pageSize: 100,
      ),
    );
    result.when(
      success: (res) {
        danhSachCB.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> postFileTaoLichHop({
    int? entityType = 1,
    String entityName = ENTITY_THU_MOI_HOP,
    String? entityId,
    bool isMutil = true,
    required List<File> files,
  }) async {
    showLoading();
    final result = await hopRp.postFileTaoLichHop(
      entityType,
      entityName,
      entityId,
      isMutil,
      files,
    );
    result.when(
      success: (res) {
        fileIds = res.map((e) => e.id).toList();
      },
      error: (err) {},
    );
  }

  String genLinkHop() {
    final tenDonVi = HiveLocal.getDataUser()
        ?.userInformation
        ?.donVi
        ?.vietNameseParse()
        .replaceAll(' ', '-')
        .toUpperCase();
    final random = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final String randomRes =
        List.generate(6, (index) => _chars[random.nextInt(_chars.length)])
            .join();
    return '$BASE_URL_MEETING$tenDonVi-$randomRes';
  }

  // Future<void> _getNguoiChuTri() async {
  //   final dataUser = HiveLocal.getDataUser();
  //
  //   final result = await hopRp.getNguoiChuTri(
  //     NguoiChuTriRequest(
  //       isTaoHo: true,
  //       pageIndex: 1,
  //       pageSize: 100,
  //       userId: dataUser?.userId ?? '',
  //     ),
  //   );
  //   result.when(
  //     success: (res) {
  //       if (res.isNotEmpty) {
  //         selectNguoiChuTri = res.first;
  //       }
  //       _nguoiChuTri.sink.add(res);
  //     },
  //     error: (err) {},
  //   );
  // }

  void dispose() {
    _loaiLich.close();
    _linhVuc.close();
    _nguoiChuTri.close();
    danhSachCB.close();
  }
}
