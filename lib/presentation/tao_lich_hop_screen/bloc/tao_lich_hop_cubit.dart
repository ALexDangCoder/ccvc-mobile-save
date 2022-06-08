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
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

List<DropDownModel> danhSachThoiGianNhacLich = [
  DropDownModel(label: 'Không bao giờ', id: 1),
  DropDownModel(label: 'Sau khi tạo lịch', id: 0),
  DropDownModel(label: 'Trước 5 phút', id: 5),
  DropDownModel(label: 'Trước 10 phút', id: 10),
  DropDownModel(label: 'Trước 15 phút', id: 15),
  DropDownModel(label: 'Trước 30 phút', id: 30),
  DropDownModel(label: 'Trước 1 giờ', id: 60),
  DropDownModel(label: 'Trước 2 giờ', id: 120),
  DropDownModel(label: 'Trước 12 giờ', id: 720),
  DropDownModel(label: 'Trước 1 ngày', id: 1140),
  DropDownModel(label: 'Trước 1 tuần', id: 10080),
];

List<DropDownModel> danhSachLichLap = [
  DropDownModel(label: 'Không lặp lại', id: 1),
  DropDownModel(label: 'Lặp lại hàng ngày', id: 2),
  DropDownModel(label: 'Thứ 2 đên thứ 6 hàng tuần', id: 3),
  DropDownModel(label: 'Lặp lại hàng tuần', id: 4),
  DropDownModel(label: 'Lặp lại hàng tháng', id: 5),
  DropDownModel(label: 'Lặp lại hàng năm', id: 6),
  DropDownModel(label: 'Tùy chỉnh', id: 7),
];

List<DropDownModel> daysOfWeek = [
  DropDownModel(label: 'CN', id: 0),
  DropDownModel(label: 'T2', id: 1),
  DropDownModel(label: 'T3', id: 2),
  DropDownModel(label: 'T4', id: 3),
  DropDownModel(label: 'T5', id: 4),
  DropDownModel(label: 'T6', id: 5),
  DropDownModel(label: 'T7', id: 6),
];

List<DropDownModel> mucDoHop = [
  DropDownModel(label: 'Bình thường', id: 1),
  DropDownModel(label: 'Đột xuất', id: 2),
];

class TaoLichHopCubit extends BaseCubit<TaoLichHopState> {
  TaoLichHopCubit() : super(MainStateInitial()) {
    showContent();
  }

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

  final BehaviorSubject<String> loaiLichLap = BehaviorSubject();

  Stream<List<NguoiChutriModel>> get nguoiChuTri => _nguoiChuTri.stream;

  BehaviorSubject<List<DsDiemCau>> dsDiemCauSubject =
      BehaviorSubject.seeded([]);

  BehaviorSubject<bool> isLichTrung = BehaviorSubject();

  LoaiSelectModel? selectLoaiHop;
  LoaiSelectModel? selectLinhVuc;
  NguoiChutriModel? selectNguoiChuTri;
  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest(
    ngayBatDau: DateTime.now().dateTimeFormatter(
      pattern: DateTimeFormat.DOB_FORMAT,
    ),
    ngayKetThuc: DateTime.now().dateTimeFormatter(
      pattern: DateTimeFormat.DOB_FORMAT,
    ),
    timeStart: DateTime.now().dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
    timeTo: DateTime.now()
        .add(const Duration(hours: 1))
        .dateTimeFormatter(pattern: HOUR_MINUTE_FORMAT),
    isAllDay: false,
    bitTrongDonVi: false,
    chuTri: ChuTri(),
    dsDiemCau: <DsDiemCau>[],
    lichDonVi: false,
    typeReminder: danhSachThoiGianNhacLich.first.id,
    typeRepeat: danhSachLichLap.first.id,
    mucDo: mucDoHop.first.id,
    isLichLap: false,
    isNhacLich: false,
    congKhai: false,
    bitHopTrucTuyen: false,
    bitYeuCauDuyet: false,
    bitLinkTrongHeThong: false,
  );

  String donViId = '';

  List<String> fileIds = [];

  List<File> listThuMoi = [];
  List<File> listTaiLieu = [];

  Future<void> createMeeting() async {
    showLoading();
    if (listThuMoi.isNotEmpty) {
      await postFileTaoLichHop(files: listThuMoi);
      taoLichHopRequest.thuMoiFiles = fileIds.join(',');
    }
    final result = await hopRp.taoLichHop(taoLichHopRequest);
    result.when(
      success: (res) {
        final Queue queue = Queue(parallel: 3);
        queue.add(
          () => postFileTaoLichHop(
            files: listTaiLieu,
            entityId: res.id,
            entityName: ENTITY_TAI_LIEU_HOP,
          ),
        );
        MessageConfig.show(
          title: S.current.tao_thanh_cong,
        );
      },
      error: (error) {
        MessageConfig.show(
          messState: MessState.error,
          title: S.current.tao_that_bai,
        );
      },
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

  Future<void> checkLichTrung() async {
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

    /// check tùy chỉnh lịch lặp
    if (taoLichHopRequest.typeRepeat != danhSachLichLap.last.id) {
      taoLichHopRequest.days = '';
    } else {
      taoLichHopRequest.days ??= '1';
    }
    if (taoLichHopRequest.bitTrongDonVi ?? false) {
      showLoading();
      final rs = await hopRp.checkLichHopTrung(
        null,
        taoLichHopRequest.chuTri?.donViId ?? '',
        taoLichHopRequest.chuTri?.canBoId ?? '',
        taoLichHopRequest.timeStart ?? '',
        taoLichHopRequest.timeTo ?? '',
        taoLichHopRequest.ngayBatDau ?? '',
        taoLichHopRequest.ngayKetThuc ?? '',
      );
      rs.when(
        success: (res) {
          if (res.isNotEmpty) {
            isLichTrung.add(true);
          } else {
            createMeeting();
          }
        },
        error: (error) {
          MessageConfig.show(
            messState: MessState.error,
            title: S.current.tao_that_bai,
          );
        },
      );
      showContent();
    } else {
      await createMeeting();
    }
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

  void dispose() {
    _loaiLich.close();
    _linhVuc.close();
    _nguoiChuTri.close();
    danhSachCB.close();
  }
}

class DropDownModel {
  String label;
  int id;

  DropDownModel({required this.label, required this.id});
}