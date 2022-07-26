import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/data/request/lich_hop/search_can_bo_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chon_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/calendar_work_repository.dart';
import 'package:ccvc_mobile/domain/repository/thanh_phan_tham_gia_reponsitory.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_state.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
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
];

List<DropDownModel> danhSachSuaThoiGianNhacLich = [
  DropDownModel(label: 'Không bao giờ', id: 1),
  DropDownModel(label: 'Trước 5 phút', id: 5),
  DropDownModel(label: 'Trước 10 phút', id: 10),
  DropDownModel(label: 'Trước 15 phút', id: 15),
  DropDownModel(label: 'Trước 30 phút', id: 30),
  DropDownModel(label: 'Trước 1 giờ', id: 60),
];

List<DropDownModel> danhSachLichLap = [
  DropDownModel(label: 'Không lặp lại', id: 1),
  DropDownModel(label: 'Lặp lại hàng ngày', id: 2),
  DropDownModel(label: 'Thứ 2 đến thứ 6 hàng tuần', id: 3),
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

  final BehaviorSubject<bool> isLichTrung = BehaviorSubject();

  BehaviorSubject<List<TaoPhienHopRequest>> listPhienHop =
      BehaviorSubject.seeded([]);

  bool isOverFileLength = false;

  LoaiSelectModel? selectLoaiHop;
  LoaiSelectModel? selectLinhVuc;
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
    chuTri: ChuTri(),
    dsDiemCau: <DsDiemCau>[],
    lichDonVi: false,
    typeReminder: danhSachThoiGianNhacLich.first.id,
    typeRepeat: danhSachLichLap.first.id,
    mucDo: mucDoHop.first.id,
    isLichLap: false,
    isNhacLich: false,
    congKhai: false,
    bitYeuCauDuyet: false,
    bitLinkTrongHeThong: false,
    isDuyetKyThuat: false,
  );

  String donViId = '';

  List<String> fileIds = [];

  List<File> listThuMoi = [];
  List<File> listTaiLieu = [];
  List<File> listTaiLieuPhienHop = [];

  bool isHopTrucTiep = false;

  Set<DonViModel> listThanhPhanThamGia = {};
  BehaviorSubject<bool> isSendEmail = BehaviorSubject.seeded(false);
  DonViModel? chuTri;

  void validateData() {
    taoLichHopRequest.dsDiemCau = dsDiemCauSubject.value;

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
    }
    if (taoLichHopRequest.phongHop?.phongHopId?.isEmpty ?? true) {
      taoLichHopRequest.phongHop = null;
    }

    /// check tùy chỉnh lịch lặp
    if (taoLichHopRequest.typeRepeat != danhSachLichLap.last.id) {
      taoLichHopRequest.days = '';
    }
    if (taoLichHopRequest.typeRepeat != danhSachLichLap.first.id) {
      if (taoLichHopRequest.dateRepeat?.isEmpty ?? true) {
        DateTime.now().dateTimeFormatter(
          pattern: DateTimeFormat.DOB_FORMAT,
        );
      }
    }

    /// Format date time:
    taoLichHopRequest.timeStart = taoLichHopRequest.timeStart?.formatTime();
    taoLichHopRequest.timeTo = taoLichHopRequest.timeTo?.formatTime();
    if (taoLichHopRequest.bitYeuCauDuyet ?? false) {
      taoLichHopRequest.status = 1;
    } else {
      taoLichHopRequest.status = 2;
    }
  }

  bool checkThoiGianPhienHop() {
    final dateTimeStart = getTime().convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );

    final dateTimeEnd = getTime(isGetDateStart: false).convertStringToDate(
      formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
    );
    bool isInvalid = true;
    final listHop = listPhienHop.value;
    for (int i = 0; i < listHop.length; i++) {
      final timeStart = listHop[i].thoiGian_BatDau.convertStringToDate(
            formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
          );
      final timeEnd = listHop[i].thoiGian_KetThuc.convertStringToDate(
            formatPattern: DateTimeFormat.DATE_TIME_PUT_EDIT,
          );
      if (timeStart.isBefore(dateTimeStart) || timeEnd.isAfter(dateTimeEnd)) {
        isInvalid = false;
        break;
      }
    }
    return isInvalid;
  }

  Future<bool> createMeeting() async {
    bool isCreateSuccess = false;
    validateData();
    showLoading();
    await postFileTaoLichHop(files: listThuMoi);
    taoLichHopRequest.thuMoiFiles = fileIds.join(',');
    final result = await hopRp.taoLichHop(taoLichHopRequest);
    await result.when(
      success: (res) async {
        if (res.id.isNotEmpty) {
          final Queue queue = Queue(parallel: 3);
          unawaited(
            queue.add(
              () => postFileTaoLichHop(
                files: listTaiLieu,
                entityId: res.id,
                entityName: ENTITY_TAI_LIEU_HOP,
              ),
            ),
          );
          unawaited(
            queue.add(
              () => themThanhPhanThamGia(
                isSendEmail: isSendEmail.value,
                idHop: res.id,
              ),
            ),
          );
          unawaited(
            queue.add(
              () => themPhienHop(
                res.id,
              ),
            ),
          );
          await queue.onComplete.then((value) {
            isCreateSuccess = true;
            queue.cancel();
            showContent();
          });
        }
      },
      error: (error) {
        isCreateSuccess = false;
        showContent();
      },
    );
    return isCreateSuccess;
  }

  Future<bool> editMeeting() async {
    bool isUpdateSuccess = false;
    validateData();
    showLoading();
    await postFileTaoLichHop(files: listThuMoi);
    taoLichHopRequest.thuMoiFiles = fileIds.join(',');
    final result = await hopRp.postSuaLichHop(taoLichHopRequest);
    result.when(
      success: (res) {
        isUpdateSuccess = true;
      },
      error: (error) {
        isUpdateSuccess = true;
      },
    );
    showContent();
    return isUpdateSuccess;
  }

  Future<void> themThanhPhanThamGia({
    required String idHop,
    required bool isSendEmail,
  }) async {
    if (listThanhPhanThamGia.isNotEmpty) {
      final List<MoiThamGiaHopRequest> listMoiHop =
          listThanhPhanThamGia.map((e) {
        return e.id.isNotEmpty || e.donViId.isNotEmpty
            ? e.convertTrongHeThong(idHop)
            : e.convertNgoaiHeThong(idHop);
      }).toList();
      await hopRp.moiHop(idHop, false, isSendEmail, listMoiHop);
    }
  }

  Future<void> themPhienHop(String lichHopId) async {
    final taoPhienHopRequest = listPhienHop.value;
    if (taoPhienHopRequest.isNotEmpty) {
      final result = await hopRp.themPhienHop(lichHopId, taoPhienHopRequest);
      result.when(
        success: (value) {},
        error: (error) {},
      );
    }
  }

  void loadData() {
    final dataUser = HiveLocal.getDataUser();
    donViId = dataUser?.userInformation?.donViTrucThuoc?.id ?? '';
    _getLoaiLich();
    _getPhamVi();
    getCanBo();
    getTimeConfig();
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

  Future<bool> checkLichTrung({
    required String donViId,
    required String canBoId,
  }) async {
    if (donViId.isEmpty) {
      return false;
    }
    bool isTrung = false;
    showLoading();
    final rs = await hopRp.checkLichHopTrung(
      null,
      donViId,
      canBoId,
      taoLichHopRequest.timeStart ?? '',
      taoLichHopRequest.timeTo ?? '',
      taoLichHopRequest.ngayBatDau ?? '',
      taoLichHopRequest.ngayKetThuc ?? '',
    );
    rs.when(
      success: (res) {
        if (res.isNotEmpty) {
          isTrung = true;
        } else {
          isTrung = false;
        }
      },
      error: (error) {
        isTrung = false;
      },
    );
    showContent();
    return isTrung;
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

  final BehaviorSubject<List<DonViModel>> danhSachCB =
      BehaviorSubject.seeded([]);

  void addThanhPhanThamGia(List<DonViModel> listDonVi) {
    listThanhPhanThamGia.addAll(listDonVi);
  }

  void removeThanhPhanThamGia(DonViModel donVi) {
    listPhienHop.value.removeWhere((element) => element.uuid == donVi.uuid);
    listPhienHop.sink.add(listPhienHop.value);
    listThanhPhanThamGia.remove(donVi);
  }

  Future<void> getCanBo() async {
    final result = await thanhPhanThamGiaRp.getSeachCanBo(
      SearchCanBoRequest(
        iDDonVi:
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
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
    if (files.isEmpty) {
      return;
    }
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
        .replaceAll(',', '')
        .toUpperCase();
    final random = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final String randomRes =
        List.generate(6, (index) => _chars[random.nextInt(_chars.length)])
            .join();
    return '$BASE_URL_MEETING$tenDonVi-$randomRes';
  }

  List<String> getListTenCanBo() {
    listThanhPhanThamGia.removeWhere((element) => element.vaiTroThamGia == 0);
    if (chuTri != null) {
      listThanhPhanThamGia.add(chuTri!);
    }
    return listThanhPhanThamGia
        .map(
          (e) => e.tenCanBo.isNotEmpty
              ? e.tenCanBo
              : e.name.isNotEmpty
                  ? e.name
                  : e.tenDonVi,
        )
        .toList();
  }

  String getTime({bool isGetDateStart = true}) {
    return isGetDateStart
        ? '${taoLichHopRequest.ngayBatDau} '
            '${taoLichHopRequest.timeStart}'
        : '${taoLichHopRequest.ngayKetThuc} '
            '${taoLichHopRequest.timeTo}';
  }

  /// chon phong hop api of tung
  Future<bool> chonPhongHopMetting(
    TaoLichHopRequest taoLichHopRequest,
    ChonPhongHopModel value,
  ) async {
    bool isUpdateSuccess = false;

    showLoading();
    if (value.phongHop?.phongHopId?.isNotEmpty ?? false) {
      taoLichHopRequest.phongHop = value.phongHop;
    }
    taoLichHopRequest.phongHop?.noiDungYeuCau = value.yeuCauKhac;
    taoLichHopRequest.phongHopThietBi = value.listThietBi
        .map(
          (e) => PhongHopThietBi(
            tenThietBi: e.tenThietBi,
            soLuong: e.soLuong.toString(),
          ),
        )
        .toList();

    final result = await hopRp.chonPhongHopMetting(taoLichHopRequest);

    result.when(
      success: (res) {
        isUpdateSuccess = true;
      },
      error: (error) {
        isUpdateSuccess = true;
      },
    );

    showContent();

    return isUpdateSuccess;
  }

  void handleChonPhongHop(ChonPhongHopModel value) {
    if (value.phongHop?.phongHopId?.isNotEmpty ?? false) {
      taoLichHopRequest.phongHop = value.phongHop;
    }
    taoLichHopRequest.phongHop?.noiDungYeuCau = value.yeuCauKhac;
    taoLichHopRequest.phongHopThietBi = value.listThietBi
        .map(
          (e) => PhongHopThietBi(
            tenThietBi: e.tenThietBi,
            soLuong: e.soLuong.toString(),
          ),
        )
        .toList();
  }

  CalendarWorkRepository get _workCal => Get.find();
  final timeConfigSubject = BehaviorSubject<Map<String, String>>();

  Future<void> getTimeConfig() async {
    showLoading();
    final result = await _workCal.getConfigTime();
    result.when(
      success: (res) {
        final timeStartConfigSystem = res.timeStart ?? '00:00';
        final timeEndConfigSystem = res.timeEnd ?? '00:00';
        timeConfigSubject.sink.add({
          'timeStart': timeStartConfigSystem,
          'timeEnd': timeEndConfigSystem,
        });
      },
      error: (error) {},
    );
    showContent();
  }

  void dispose() {
    _loaiLich.close();
    _linhVuc.close();
    _nguoiChuTri.close();
    danhSachCB.close();
    danhSachCB.close();
    isSendEmail.close();
    listPhienHop.close();
    isLichTrung.close();
    dsDiemCauSubject.close();
    loaiLichLap.close();
    chuongTrinhHopSubject.close();
  }
}

class DropDownModel {
  String label;
  int id;

  DropDownModel({required this.label, required this.id});
}
