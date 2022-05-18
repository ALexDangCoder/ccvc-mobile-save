import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nguoi_theo_doi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/phan_cong_thu_ky_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/user_infomation.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/can_bo_tham_gia_str.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

const DANHSACHPHATBIEU = 0;
const CHODUYET = 1;
const DADUYET = 2;
const HUYDUYET = 3;

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  HopRepository get hopRp => Get.find();
  bool check = false;
  String startTime = '00:00';
  String endTime = '00:00';
  String? tenBieuQuyet;
  bool? loaiBieuQuyet;
  String? dateBieuQuyet;
  String getPhienHopId = '';
  List<CanBoModel> dataThanhPhanThamGia = [];
  List<String?> data = [];
  List<String> selectPhatBieu = [];

  List<ButtonStatePhatBieu> buttonStatePhatBieu = [
    ButtonStatePhatBieu(
      key: S.current.danh_sach_phat_bieu,
      value: 0,
      color: choXuLyColor,
    ),
    ButtonStatePhatBieu(
      key: S.current.cho_duyet,
      value: 0,
      color: itemWidgetNotUse,
    ),
    ButtonStatePhatBieu(
      key: S.current.da_duyet,
      value: 0,
      color: itemWidgetUsing,
    ),
    ButtonStatePhatBieu(
      key: S.current.huy_duyet,
      value: 0,
      color: statusCalenderRed,
    ),
  ];

  BehaviorSubject<ButtonStatePhatBieu> buttonStatePhatBieuSubject =
      BehaviorSubject();

  String idPerson = '';

  final DataUser? dataUser = HiveLocal.getDataUser();

  List<PERMISSION_DETAIL> listButton = [];

  List<CanBoThamGiaStr> scheduleCoperatives = [];

  BehaviorSubject<List<StatusKetLuanHopModel>> dataTinhTrangKetLuanHop =
      BehaviorSubject.seeded([]);
  BehaviorSubject<ChonBienBanCuocHopModel> dataMauBienBan = BehaviorSubject();

  BehaviorSubject<List<PhienhopModel>> phienHop = BehaviorSubject();
  BehaviorSubject<List<PERMISSION_DETAIL>> listButtonSubject =
      BehaviorSubject();
  BehaviorSubject<String> noiDung = BehaviorSubject();

  HtmlEditorController? controller = keyEditKetLuanHop.currentState?.controller;

  BehaviorSubject<List<DanhSachLoaiNhiemVuLichHopModel>>
      danhSachLoaiNhiemVuLichHopModel = BehaviorSubject();

  BehaviorSubject<List<VBGiaoNhiemVuModel>> listVBGiaoNhiemVu =
      BehaviorSubject();

  BehaviorSubject<bool> checkTuyChinh = BehaviorSubject();

  List<VBGiaoNhiemVuModel> vBGiaoNhiemVuModel = [];

  BehaviorSubject<List<ListPhienHopModel>> danhSachChuongTrinhHop =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listNguoiCHuTriModel =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listThuHoi = BehaviorSubject();

  BehaviorSubject<List<MoiHopModel>> listMoiHopSubject = BehaviorSubject();

  Stream<List<MoiHopModel>> get listMoiHopStream => listMoiHopSubject.stream;

  BehaviorSubject<ChiTietLichHopModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  BehaviorSubject<List<YkienCuocHopModel>> listYKienCuocHop = BehaviorSubject();

  BehaviorSubject<DanhSachPhatBieuLichHopModel>
      danhSachPhatbieuLichHopModelSubject = BehaviorSubject();

  Stream<DanhSachPhatBieuLichHopModel> get danhSachPhatbieuLichHopStream =>
      danhSachPhatbieuLichHopModelSubject.stream;

  final BehaviorSubject<String> themBieuQuyet = BehaviorSubject<String>();

  final BehaviorSubject<ThongTinPhongHopModel?> _getThongTinPhongHop =
      BehaviorSubject<ThongTinPhongHopModel?>();

  Stream<ThongTinPhongHopModel?> get getThongTinPhongHop =>
      _getThongTinPhongHop.stream;
  final BehaviorSubject<List<ThietBiPhongHopModel>> _getListThietBiPhongHop =
      BehaviorSubject<List<ThietBiPhongHopModel>>();

  Stream<List<ThietBiPhongHopModel>> get getListThietBi =>
      _getListThietBiPhongHop.stream;

  XemKetLuanHopModel xemKetLuanHopModel = XemKetLuanHopModel.emty();

  BehaviorSubject<KetLuanHopModel> ketLuanHopSubject = BehaviorSubject();

  BehaviorSubject<List<DanhSachNhiemVuLichHopModel>>
      danhSachNhiemVuLichHopSubject = BehaviorSubject();

  List<String> cacLuaChonBieuQuyet = [];

  List<NguoiChutriModel> dataThuKyOrThuHoiDeFault = [];

  List<NguoiChutriModel> dataThuHoi = [];

  String id = '';
  List<LoaiSelectModel> listLoaiHop = [];
  String? ngaySinhs;
  String chonNgay = '';
  List<File>? listFile = [];

  Future<void> initData({
    required String id,
  }) async {
    showLoading();
    await getChiTietLichHop(id);

    final queue = Queue(parallel: 15);
    unawaited(queue.add(() => getDanhSachThuHoiLichHop(id)));

    ///Công tác chuẩn bị
    unawaited(queue.add(() => getThongTinPhongHopApi()));
    unawaited(queue.add(() => getDanhSachThietBi()));

    ///Chương trình họp
    unawaited(queue.add(() => getDanhSachNguoiChuTriPhienHop(id)));
    unawaited(queue.add(() => getListPhienHop(id)));

    ///Phát biểu
    unawaited(
        queue.add(() => getDanhSachPhatBieuLichHop(status: 0, lichHopId: id)));
    unawaited(queue.add(() => soLuongPhatBieuData(id: id)));

    ///Biểu quyết

    unawaited(queue.add(() => callApi(id)));
    // unawaited(queue.add(() => getDanhSachBieuQuyetLichHop(id)));

    ///Thành phần tham gia
    unawaited(queue.add(() => danhSachCanBoTPTG(id: id)));
    unawaited(queue.add(() => themThanhPhanThamGia()));

    ///kết luận họp
    unawaited(queue.add(() => getDanhSachNhiemVu(id)));
    unawaited(queue.add(() => getXemKetLuanHop(id)));
    unawaited(queue.add(() => getDanhSachLoaiNhiemVu()));
    unawaited(queue.add(() => ListStatusKetLuanHop()));
    unawaited(queue.add(() => postChonMauHop()));

    ///ý kiến
    unawaited(queue.add(() => getDanhSachYKien(id, ' ')));
    unawaited(queue.add(() => getDanhSachPhienHop(id)));

    ///nguoi theo doi
    unawaited(queue.add(() => getNguoiChuTri(id)));

    ///check permission button
    initDataButton();
    await queue.onComplete.catchError((er) {});
    queue.dispose();
  }

  TimerData subStringTime(String time) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final dateTime = dateFormat.parse(time);
    return TimerData(hour: dateTime.hour, minutes: dateTime.minute);
  }

  TimerData start = TimerData(hour: 0, minutes: 0);
  TimerData end = TimerData(hour: 0, minutes: 0);

  String chonNgayStr(String date) {
    final DateFormat paserDate = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final paserDates = paserDate.parse(date).formatApiFix;
    return paserDates;
  }

  String plus(String? date, TimerData time) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd 00:00:00');
    final dateTime = dateFormat.parse(date ?? chonNgayStr(chonNgay));
    final times = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minutes,
    );
    return times.formatApiSuaPhienHop;
  }

  String plusTaoBieuQuyet(String date, TimerData time) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final dateTime = dateFormat.parse(date);

    final times = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minutes,
    );
    return times.formatApiTaoBieuQuyet;
  }

  Future<void> suaChuongTrinhHop({
    required String id,
    required String lichHopId,
    required String tieuDe,
    required String thoiGianBatDau,
    required String thoiGianKetThuc,
    required String canBoId,
    required String donViId,
    required String noiDung,
    required String? hoTen,
    required bool isMultipe,
    required List<File>? file,
  }) async {
    showLoading();

    final result = await hopRp.suaChuongTrinhHop(
      id,
      lichHopId,
      tieuDe,
      thoiGianBatDau,
      thoiGianKetThuc,
      canBoId,
      donViId,
      noiDung,
      hoTen ?? '',
      isMultipe,
      file ?? [],
    );

    result.when(
      success: (value) {},
      error: (error) {},
    );

    showContent();
  }

  Future<void> xoaChuongTrinhHop({
    required String id,
  }) async {
    showLoading();

    final result = await hopRp.xoaChuongTrinhHop(id);

    result.when(
      success: (value) {},
      error: (error) {},
    );

    showContent();
  }

  BehaviorSubject<List<DanhSachNguoiThamGiaModel>> nguoiThamGiaSubject =
      BehaviorSubject();
  List<DanhSachNguoiThamGiaModel> listData = [];

  Future<void> getDanhSachNTGChuongTrinhHop({
    required String id,
  }) async {
    showLoading();

    final result = await hopRp.getDanhSachNTGChuongTrinhHop(id);

    result.when(
      success: (res) {
        listData = res;
        nguoiThamGiaSubject.sink.add(listData);
      },
      error: (error) {},
    );

    showContent();
  }

  bool? loaiBieuQ = false;
  String date = DateTime.now().toStringWithListFormat;

  List<DanhSachNguoiThamGiaModel> listDanhSach = [];
  List<String> listLuaChon = [];

  Future<void> callApi(String id) async {
    await getDanhSachBieuQuyetLichHop(
      idLichHop: id,
      canBoId: HiveLocal.getDataUser()?.userId ?? '',
      idPhienHop: '',
    );
  }

  Future<void> postThemBieuQuyetHop(String id, String noidung) async {
    await themBieuQuyetHop(
      dateStart: date,
      thoiGianBatDau: plusTaoBieuQuyet(
        date,
        start,
      ),
      thoiGianKetThuc: plusTaoBieuQuyet(
        date,
        end,
      ),
      loaiBieuQuyet: loaiBieuQ,
      danhSachLuaChon: listLuaChon
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: 'primary'))
          .toList(),
      noiDung: noidung,
      lichHopId: id,
      trangThai: 0,
      quyenBieuQuyet: true,
      danhSachThanhPhanThamGia: listDanhSach
          .map(
            (e) => DanhSachThanhPhanThamGia(
              canBoId: e.canBoId,
              donViId: e.donViId,
              idPhienhopCanbo: e.id,
            ),
          )
          .toList(),
    );
  }

  Future<void> themBieuQuyetHop({
    required String? dateStart,
    required String? thoiGianBatDau,
    required String? thoiGianKetThuc,
    required bool? loaiBieuQuyet,
    required List<DanhSachLuaChon>? danhSachLuaChon,
    required String? noiDung,
    required String? lichHopId,
    required int? trangThai,
    required bool? quyenBieuQuyet,
    required List<DanhSachThanhPhanThamGia>? danhSachThanhPhanThamGia,
  }) async {
    showLoading();
    final BieuQuyetRequest bieuQuyetRequest = BieuQuyetRequest(
      dateStart: dateStart,
      thoiGianBatDau: thoiGianBatDau,
      thoiGianKetThuc: thoiGianKetThuc,
      loaiBieuQuyet: loaiBieuQuyet,
      danhSachLuaChon: danhSachLuaChon,
      noiDung: noiDung,
      lichHopId: lichHopId,
      trangThai: trangThai,
      quyenBieuQuyet: quyenBieuQuyet,
      danhSachThanhPhanThamGia: danhSachThanhPhanThamGia,
    );
    final result = await hopRp.themBieuQuyet(bieuQuyetRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  void getTimeHour({required TimerData startT, required TimerData endT}) {
    final int hourStart = startT.hour;
    final int minuteStart = startT.minutes;
    final int hourEnd = endT.hour;
    final int minuteEnd = endT.minutes;
    String hStart = hourStart.toString();
    String mStart = minuteStart.toString();
    String hEnd = hourEnd.toString();
    String mEnd = minuteEnd.toString();
    if (hourStart < 10) {
      hStart = '0$hStart';
    }
    if (minuteStart < 10) {
      mStart = '0$mStart';
    }
    if (hourEnd < 10) {
      hEnd = '0$hEnd';
    }
    if (minuteEnd < 10) {
      mEnd = '0$mEnd';
    }
    startTime = '$hStart:$mStart';
    endTime = '$hEnd:$mEnd';
  }

  BehaviorSubject<List<CanBoModel>> thanhPhanThamGia =
      BehaviorSubject<List<CanBoModel>>();

  BehaviorSubject<bool> checkBoxCheckAllTPTG = BehaviorSubject();

  List<String> selectedIds = [];

  BehaviorSubject<List<PhatBieuModel>> streamPhatBieu =
      BehaviorSubject<List<PhatBieuModel>>();

  BehaviorSubject<List<DanhSachBietQuyetModel>> streamBieuQuyet =
      BehaviorSubject();

  final BehaviorSubject<int> typeStatus = BehaviorSubject.seeded(0);

  SoLuongPhatBieuModel dataSoLuongPhatBieu = SoLuongPhatBieuModel();

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  TaoPhienHopRepuest taoPhienHopRepuest = TaoPhienHopRepuest();

  List<MoiHopRequest> moiHopRequest = [];

  bool phuongThucNhan = false;

  List<ThuHoiHopRequest> thuHoiHopRequest = [];

  void dispose() {}
}

///chi tiết lịch họp
extension ChiTietLichHop on DetailMeetCalenderCubit {
  Future<void> deleteChiTietLichHop(String id) async {
    final result = await hopRp.deleteChiTietLichHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> huyChiTietLichHop(String scheduleId) async {
    final result = await hopRp.huyChiTietLichHop(scheduleId, 8, false);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> postSuaLichHop() async {
    showLoading();

    final result = await hopRp.postSuaLichHop(taoLichHopRequest);

    result.when(
      success: (value) {},
      error: (error) {},
    );

    showContent();
  }

  Future<void> getDanhSachThuHoiLichHop(String id) async {
    final result = await hopRp.getDanhSachThuHoi(id, true);
    result.when(
      success: (res) {
        dataThuHoi = res.where((element) => element.trangThai != 4).toList();
        listThuHoi.sink.add(dataThuHoi);
      },
      error: (error) {},
    );
  }

  Future<void> getChiTietLichHop(String id) async {
    this.id = id;
    final loaiHop = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    loaiHop.when(
      success: (res) {
        listLoaiHop = res;
      },
      error: (err) {},
    );
    final result = await hopRp.getChiTietLichHop(id);
    result.when(
      success: (res) {
        res.loaiHop = _findLoaiHop(res.typeScheduleId)?.name ?? '';
        chiTietLichLamViecSubject.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> postThuHoiHop(String scheduleId) async {
    final idPost =
        dataThuHoi.where((element) => element.trangThai == 4).toList();
    for (int i = 0; i < idPost.length; i++) {
      thuHoiHopRequest.add(
        ThuHoiHopRequest(
          id: idPost[i].id,
          scheduleId: scheduleId,
          status: 4,
        ),
      );
    }
    final result = await hopRp.postThuHoiHop(false, thuHoiHopRequest);

    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachThuHoiLichHop(scheduleId);
          thuHoiHopRequest.clear();
        }
      },
      error: (error) {},
    );
  }

  Future<void> postPhanCongThuKy(String id) async {
    final List<String> dataIdPost = dataThuKyOrThuHoiDeFault
        .where((e) => e.isThuKy ?? false)
        .map((e) => e.id ?? '')
        .toList();
    final result = await hopRp.postPhanCongThuKy(
      PhanCongThuKyRequest(
        content: '',
        ids: dataIdPost,
        lichHopId: id,
      ),
    );

    result.when(
      success: (value) {},
      error: (error) {},
    );
  }

  LoaiSelectModel? _findLoaiHop(String id) {
    final loaiHopType =
        listLoaiHop.where((element) => element.id == id).toList();
    if (loaiHopType.isNotEmpty) {
      return loaiHopType.first;
    }
  }

  List<int> listNgayChonTuan(String vl) {
    final List<String> lSt = vl.replaceAll(',', '').split('');
    final List<int> numbers = lSt.map(int.parse).toList();
    return numbers;
  }

  int nhacLai(int nhacLai) {
    switch (nhacLai) {
      case 0:
        return 1;
      case 1:
        return 0;
      case 2:
        return 5;
      case 3:
        return 10;
      case 4:
        return 15;
      case 5:
        return 30;
      case 6:
        return 60;
      case 7:
        return 120;
      case 8:
        return 720;
      case 9:
        return 1140;
      case 10:
        return 10080;
    }
    return 0;
  }
}

///Công tác chuẩn bị
extension CongTacChuanBi on DetailMeetCalenderCubit {
  Future<void> getThongTinPhongHopApi() async {
    showLoading();
    final result = await hopRp.getListThongTinPhongHop(id);
    result.when(
      success: (res) {
        _getThongTinPhongHop.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> getDanhSachThietBi() async {
    showLoading();
    final result = await hopRp.getListThietBiPhongHop(id);
    result.when(
      success: (res) {
        _getListThietBiPhongHop.sink.add(res);
      },
      error: (err) {},
    );
  }
}

///Biẻu quyết
extension BieuQuyet on DetailMeetCalenderCubit {
  // danh sach bieu quyet
  Future<void> getDanhSachBieuQuyetLichHop({
    String? idLichHop,
    String? canBoId,
    String? idPhienHop,
  }) async {
    final result = await hopRp.getDanhSachBieuQuyetLichHop(
      idLichHop ?? '',
      canBoId ?? '',
      idPhienHop ?? '',
    );
    result.when(
      success: (res) {
        streamBieuQuyet.sink.add(res);
      },
      error: (err) {},
    );
  }

  void getTimeHour({required TimerData startT, required TimerData endT}) {
    final int hourStart = startT.hour;
    final int minuteStart = startT.minutes;
    final int hourEnd = endT.hour;
    final int minuteEnd = endT.minutes;
    startTime = '${hourStart.toString()}:${minuteStart.toString()}';
    endTime = '${hourEnd.toString()}:${minuteEnd.toString()}';
  }

  Future<void> themBieuQuyetHop(
      {required String id, required String tenBieuQuyet}) async {
    showLoading();
    final BieuQuyetRequest bieuQuyetRequest = BieuQuyetRequest(
      dateStart: dateBieuQuyet,
      lichHopId: id,
      loaiBieuQuyet: loaiBieuQuyet,
      noiDung: tenBieuQuyet,
      quyenBieuQuyet: true,
      thoiGianBatDau: startTime,
      thoiGianKetThuc: endTime,
      trangThai: 0,
      danhSachLuaChon: cacLuaChonBieuQuyet
          .map((e) => DanhSachLuaChon(tenLuaChon: e, mauBieuQuyet: 'primary'))
          .toList(),
      danhSachThanhPhanThamGia: [],
    );
    final result = await hopRp.themBieuQuyet(bieuQuyetRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  void getDate(String value) {
    dateBieuQuyet = value;
  }

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
    if (_index == 1) {
      loaiBieuQuyet = true;
    } else {
      loaiBieuQuyet = false;
    }
  }

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }
}

///phat Bieu
extension PhatBieu on DetailMeetCalenderCubit {
  Future<void> getDanhSachPhatBieuLichHop(
      {int? status, String? lichHopId, String? phienHop}) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(
      status ?? 0,
      lichHopId ?? '',
      phienHop ?? '',
    );
    result.when(
      success: (res) {
        streamPhatBieu.sink.add(res);
      },
      error: (err) {},
    );
  }

  void getValueStatus(int value) {
    typeStatus.sink.add(value);
    getDanhSachPhatBieuLichHop(status: value, lichHopId: id);
  }

  Future<void> soLuongPhatBieuData({required String id}) async {
    final result = await hopRp.getSoLuongPhatBieu(id);
    result.when(
      success: (res) {
        buttonStatePhatBieu[DANHSACHPHATBIEU].value = res.danhSachPhatBieu;
        buttonStatePhatBieu[CHODUYET].value = res.choDuyet;
        buttonStatePhatBieu[DADUYET].value = res.daDuyet;
        buttonStatePhatBieu[HUYDUYET].value = res.huyDuyet;
      },
      error: (err) {},
    );
  }

  Future<void> taoPhatBieu(TaoBieuQuyetRequest taoBieuQuyetRequest) async {
    final result = await hopRp.postTaoPhatBieu(taoBieuQuyetRequest);

    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachPhatBieuLichHop(
              status: 1, lichHopId: taoBieuQuyetRequest.lichHopId ?? '');

          soLuongPhatBieuData(id: taoBieuQuyetRequest.lichHopId ?? '');
        }
      },
      error: (error) {},
    );
  }

  Future<void> duyetOrHuyDuyetPhatBieu({
    required String lichHopId,
    required int type,
  }) async {
    final result = await hopRp.postDuyetOrHuyDuyetPhatBieu(
      selectPhatBieu,
      lichHopId,
      type,
    );
    result.when(
      success: (value) {
        if (value.succeeded == true) {}
      },
      error: (error) {},
    );
  }

  Color bgrColorButton(int vl) {
    switch (vl) {
      case DANHSACHPHATBIEU:
        return choXuLyColor;
      case CHODUYET:
        return itemWidgetNotUse;
      case DADUYET:
        return itemWidgetUsing;
      case HUYDUYET:
        return statusCalenderRed;
    }
    return backgroundColorApp;
  }
}

///Chương Trình họp
extension ChuongTrinhHop on DetailMeetCalenderCubit {
  Future<void> getListPhienHop(String id) async {
    final result = await hopRp.getDanhSachPhienHop(id);
    result.when(
      success: (res) {
        danhSachChuongTrinhHop.sink.add(res);
      },
      error: (error) {},
    );
  }

  Future<void> getDanhSachNguoiChuTriPhienHop(String id) async {
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(id);
    result.when(
      success: (res) {
        listNguoiCHuTriModel.sink.add(res);
        dataThuKyOrThuHoiDeFault = res;
      },
      error: (error) {},
    );
  }

  Future<void> ThemPhienHop(String id) async {
    final result = await hopRp.getThemPhienHop(
      id,
      taoPhienHopRepuest.canBoId ?? '',
      taoPhienHopRepuest.donViId ?? '',
      taoPhienHopRepuest.vaiTroThamGia ?? 0,
      '${taoPhienHopRepuest.thoiGian_BatDau ?? DateTime.parse(DateTime.now().toString()).formatApi} $startTime',
      '${taoPhienHopRepuest.thoiGian_KetThuc ?? DateTime.parse(DateTime.now().toString()).formatApi} $endTime',
      taoPhienHopRepuest.noiDung ?? '',
      taoPhienHopRepuest.tieuDe ?? '',
      taoPhienHopRepuest.hoTen ?? '',
      taoPhienHopRepuest.IsMultipe,
      [],
    );
    result.when(
      success: (res) {
        getListPhienHop(id);
      },
      error: (error) {},
    );
  }
}

///thành phần tham gia
extension ThanhPhanThamGia on DetailMeetCalenderCubit {
  Future<void> getDanhSachCuocHopTPTH() async {
    final result = await hopRp.getDanhSachCuocHopTPTH(id);

    result.when(
      success: (success) {
        thanhPhanThamGia.add(success.listCanBo ?? []);
        // dataThaGiaDefault = success.listCanBo ?? [];
      },
      error: (error) {},
    );
  }

  Future<void> themThanhPhanThamGia() async {
    final result =
        await hopRp.postMoiHop(id, false, phuongThucNhan, moiHopRequest);
    result.when(
      success: (res) {
        getDanhSachCuocHopTPTH();
        moiHopRequest.clear();
      },
      error: (error) {},
    );
  }

  Future<void> danhSachCanBoTPTG({required String id}) async {
    final result = await hopRp.getDanhSachCanBoTPTG(id);
    result.when(
      success: (value) {
        dataThanhPhanThamGia = value.listCanBo ?? [];
        thanhPhanThamGia.sink.add(value.listCanBo ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> postDiemDanh() async {
    final result = await hopRp.postDiemDanh(selectedIds);
    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachCuocHopTPTH();
        }
        selectedIds.clear();
      },
      error: (error) {},
    );
  }

  Future<void> postHuyDiemDanh(String id) async {
    final result = await hopRp.postHuyDiemDanh(id);
    result.when(
      success: (value) {
        if (value.succeeded == true) {
          getDanhSachCuocHopTPTH();
        }
      },
      error: (error) {},
    );
  }

  void search(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(CanBoModel canBo) {
      return canBo.tenCanBo!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value =
        dataThanhPhanThamGia.where((element) => isListCanBo(element)).toList();
    thanhPhanThamGia.sink.add(value);
  }

  void checkBoxButton() {
    checkBoxCheckAllTPTG.sink.add(check);
  }

  bool checkIsSelected(String id) {
    bool vl = false;
    if (selectedIds.contains(id)) {
      vl = true;
    }
    validateCheckAll();
    return vl;
  }

  void addOrRemoveId({
    required bool isSelected,
    required String id,
  }) {
    if (isSelected) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
      final temp = selectedIds.toSet();
      selectedIds = temp.toList();
    }
    validateCheckAll();
  }

  void checkAll() {
    selectedIds.clear();
    if (check) {
      selectedIds = dataThanhPhanThamGia
          .where((element) => element.showCheckBox())
          .map((e) => e.id ?? '')
          .toList();
    }
    List<CanBoModel> _tempList = [];
    if (thanhPhanThamGia.hasValue) {
      _tempList = thanhPhanThamGia.value;
    } else {
      _tempList = dataThanhPhanThamGia;
    }
    thanhPhanThamGia.sink.add(_tempList);
  }

  void validateCheckAll() {
    check = selectedIds.length ==
        dataThanhPhanThamGia.where((element) => element.showCheckBox()).length;
    checkBoxCheckAllTPTG.sink.add(check);
  }
}

///kết luận hop
extension KetLuanHop on DetailMeetCalenderCubit {
  Future<void> getXemKetLuanHop(String id) async {
    final result = await hopRp.getXemKetLuanHop(id);
    result.when(
      success: (res) {
        ketLuanHopSubject.sink.add(
          KetLuanHopModel(
            id: res.id ?? '',
            thoiGian: '',
            trangThai: typeTrangthai(res.status ?? 0),
            tinhTrang: typeTinhTrang(res.reportStatusCode ?? ''),
            file: res.files?.map((e) => e.Name ?? '').toList() ?? [],
            title: res.title,
          ),
        );
        xemKetLuanHopModel = res;
        noiDung.sink.add(res.content ?? '');
      },
      error: (err) {
        print('lỗi kết luận họp');
      },
    );
  }

  Future<void> getDanhSachNhiemVu(String idCuocHop) async {
    showLoading();
    final result = await hopRp.getNhiemVuCHiTietHop(
      NhiemVuChiTietHopRequest(
        idCuocHop: idCuocHop,
        index: 1,
        isNhiemVuCaNhan: false,
        size: 1000,
      ),
    );
    result.when(
      success: (res) {
        final List<DanhSachNhiemVuLichHopModel> danhSachNhiemVuLichHopModel =
            [];
        for (final e in res) {
          danhSachNhiemVuLichHopModel.add(
            DanhSachNhiemVuLichHopModel(
              soNhiemVu: e.soNhiemVu,
              noiDungTheoDoi: e.noiDungTheoDoi,
              tinhHinhThucHienNoiBo: e.tinhHinhThucHienNoiBo,
              hanXuLy: e.hanXuLy,
              loaiNhiemVu: e.loaiNhiemVu,
              trangThai: trangThaiNhiemVu(e.maTrangThai),
            ),
          );
          danhSachNhiemVuLichHopSubject.sink.add(danhSachNhiemVuLichHopModel);
        }
      },
      error: (err) {
        return;
      },
    );
  }

  TrangThai typeTrangthai(int value) {
    switch (value) {
      case 1:
        return TrangThai.ChoDuyet;
      case 2:
        return TrangThai.DaDuyet;
      case 3:
        return TrangThai.ChuaGuiDuyet;
      case 4:
        return TrangThai.HuyDuyet;
      default:
        return TrangThai.ChoDuyet;
    }
  }

  TinhTrang typeTinhTrang(String value) {
    switch (value) {
      case 'trung-binh':
        return TinhTrang.TrungBinh;
      case 'dat':
        return TinhTrang.Dat;
      case 'chua-dat':
        return TinhTrang.ChuaDat;
      default:
        return TinhTrang.TrungBinh;
    }
  }

  Future<void> suaKetLuan({
    required String scheduleId,
    required String reportStatusId,
    required String reportTemplateId,
    List<File>? files,
  }) async {
    final result = await hopRp.suaKetLuan(
      scheduleId,
      noiDung.value,
      reportStatusId,
      reportTemplateId,
      [],
    );

    result.when(
      success: (value) {},
      error: (error) {},
    );
  }

  Future<void> postChonMauHop() async {
    showLoading();
    final ChonBienBanHopRequest chonBienBanHopRequest =
        ChonBienBanHopRequest(1, 10);
    final result = await hopRp.postChonMauBienBanHop(chonBienBanHopRequest);

    result.when(
      success: (value) {
        dataMauBienBan.sink.add(value);
        data = value.items.map((e) => e.content).toList();
      },
      error: (error) {},
    );

    showContent();
  }

  Future<void> ListStatusKetLuanHop() async {
    showLoading();
    final result = await hopRp.getListStatusKetLuanHop();

    result.when(
      success: (success) {
        dataTinhTrangKetLuanHop.sink.add(success);
      },
      error: (error) {},
    );
  }

  void getValueMauBienBan(int value) {
    noiDung.sink.add(data[value] ?? '');
  }

  String getTextAfterEdit(String value) {
    noiDung.sink.add(value);
    return value;
  }

  String getValueMauBienBanWithId(String id) {
    final dataBienBan = dataMauBienBan.value;
    for (final e in dataBienBan.items) {
      if (e.id == id) {
        return e.name;
      }
    }
    return '';
  }

  Future<void> deleteKetLuanHop(String id) async {
    final result = await hopRp.deleteKetLuanHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> sendMailKetLuatHop(String idSendmail) async {
    showLoading();
    final result = await hopRp.sendMailKetLuanHop(idSendmail);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> getDanhSachLoaiNhiemVu() async {
    final result = await hopRp.getDanhSachLoaiNhiemVu();
    result.when(
      success: (res) {
        danhSachLoaiNhiemVuLichHopModel.sink.add(res);
      },
      error: (err) {
        return;
      },
    );
  }

  Future<void> ThemNhiemVu(ThemNhiemVuRequest themNhiemVuRequest) async {
    final result = await hopRp.postThemNhiemVu(themNhiemVuRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }
}

///Y kien cuoc hop
extension YKienCuocHop on DetailMeetCalenderCubit {
  Future<void> getDanhSachYKien(String id, String phienHopId) async {
    final result = await hopRp.getDanhSachYKien(id, phienHopId);
    result.when(
      success: (res) {
        listYKienCuocHop.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> themYKien({
    required String yKien,
    required String idLichHop,
    required String scheduleOpinionId,
    required String phienHopId,
  }) async {
    showLoading();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: yKien != '' ? yKien : '',
      scheduleId: idLichHop,
      scheduleOpinionId: scheduleOpinionId != '' ? scheduleOpinionId : null,
      phienHopId: phienHopId != '' ? phienHopId : null,
    );
    final result = await hopRp.themYKienHop(themYKienRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  // danh sách phiên họp - ý kiến cuộc họp
  Future<void> getDanhSachPhienHop(String id) async {
    showLoading();
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {
        phienHop.sink.add(res.danhSachPhienHop ?? []);
      },
      error: (err) {
        return;
      },
    );
  }

  TrangThaiNhiemVu trangThaiNhiemVu(String tt) {
    switch (tt) {
      case 'CHO_PHAN_XU_LY':
        return TrangThaiNhiemVu.ChoPhanXuLy;
      case 'DANG_THUC_HIEN':
        return TrangThaiNhiemVu.DangThucHien;
      case 'DA_THUC_HIEN':
        return TrangThaiNhiemVu.DaThucHien;
    }
    return TrangThaiNhiemVu.ChoPhanXuLy;
  }
}

///Nguoi theo doi
extension NguoiTheoDoi on DetailMeetCalenderCubit {
  Future<void> getNguoiChuTri(String id) async {
    final dataUser = HiveLocal.getDataUser();

    final result = await hopRp.getNguoiTheoDoi(
      NguoiTheoDoiRequest(
        isTheoDoi: true,
        pageIndex: 1,
        pageSize: 1000,
        userId: id,
      ),
    );
    result.when(success: (res) {}, error: (err) {});
  }
}

///permission
extension PermissionLichHop on DetailMeetCalenderCubit {
  List<CanBoThamGiaStr> dataListStr(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => CanBoThamGiaStr.fromJson(e)).toList();
  }

  List<CanBoThamGiaStr> canBoThamGia() {
    return scheduleCoperatives
        .where((e) => e.CanBoId?.toUpperCase() == getIdCurrentUser())
        .toList();
  }

  String getIdCurrentUser() {
    return (dataUser?.userId ?? '').replaceAll('"', '');
  }

  List<CanBoThamGiaStr> donViThamGia() {
    final UserInformation? dataUserIf = dataUser?.userInformation;
    final DonViTrucThuoc? dataDviTrucThuoc = dataUserIf?.donViTrucThuoc;
    return scheduleCoperatives
        .where(
          (e) =>
              (dataDviTrucThuoc?.id ?? '').isEmpty &&
              e.DonViId == (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.CanBoId ?? '').isNotEmpty,
        )
        .toList();
  }

  List<CanBoThamGiaStr> thamGia() {
    if (canBoThamGia().isNotEmpty) return canBoThamGia();
    if (donViThamGia().isNotEmpty) return donViThamGia();
    return [];
  }

  bool isThuKy() {
    if (thamGia().isEmpty) return false;

    for (final i in thamGia()) {
      if (i.IsThuKy != null) {
        return i.IsThuKy ?? false;
      }
    }
    return false;
  }

  bool isLichThuHoi() {
    if (thamGia().isEmpty) return false;

    for (final i in thamGia()) {
      if (i.TrangThai != null) {
        return i.TrangThai == 4;
      }
    }
    return false;
  }

  List<CanBoThamGiaStr> dataXacNhanThamGia() {
    final List<CanBoThamGiaStr> value = [];

    value.addAll(
      scheduleCoperatives
          .where((e) =>
              (e.CanBoId ?? '').isNotEmpty &&
              e.CanBoId?.toUpperCase() ==
                  (dataUser?.userId ?? '').toUpperCase())
          .toList(),
    );

    value.addAll(
      scheduleCoperatives
          .where(
            (e) =>
                HiveLocal.checkPermissionApp(
                  permissionType: PermissionType.VPDT,
                  permissionTxt: 'quyen-cu-can-bo',
                ) &&
                (e.CanBoId ?? '').isEmpty &&
                e.DonViId?.toUpperCase() ==
                    ((dataUser?.userInformation?.donViTrucThuoc?.id ?? '')
                        .replaceAll(
                          '"',
                          '',
                        )
                        .toUpperCase()),
          )
          .toList(),
    );

    return value;
  }

  bool isCuCanBo() {
    if (scheduleCoperatives.isEmpty) return false;

    final UserInformation? dataUserIf = dataUser?.userInformation;
    final DonViTrucThuoc? dataDviTrucThuoc = dataUserIf?.donViTrucThuoc;

    final isCuCanBo = scheduleCoperatives
        .map(
          (e) =>
              e.DonViId == (dataDviTrucThuoc?.id ?? '').toUpperCase() &&
              (e.CanBoId ?? '').isEmpty,
        )
        .toList();

    return isCuCanBo.isNotEmpty;
  }

  bool isDaCuCanBo() {
    String id = '';

    for (final i in thamGia()) {
      if ((i.Id ?? '').isNotEmpty) {
        id = i.Id ?? '';
        break;
      }
    }
    return scheduleCoperatives
        .where(
          (e) => (e.ParentId ?? '').toUpperCase() == id.toUpperCase(),
        )
        .toList()
        .isNotEmpty;
  }

  int classThamDu() {
    if (dataXacNhanThamGia().isNotEmpty) {
      return dataXacNhanThamGia()[0].TrangThai ?? 0;
    }

    return 0;
  }

  String showTextThamGia() {
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].TrangThai == 0 || isDaCuCanBo()) {
        return S.current.xac_nhan_tham_gia;
      }

      String idValue = '';

      for (final i in thamGia()) {
        if ((i.Id ?? '').isNotEmpty) {
          idValue = i.Id ?? '';
          break;
        }
      }

      if (dataXacNhanThamGia()[0].TrangThai == 1 && isDaCuCanBo()) {
        return S.current.huy_xac_nhan;
      }

      if (dataXacNhanThamGia()[0].TrangThai == 2) {
        return S.current.xac_nhan_lai;
      }
    }

    return '';
  }

  bool activeChuTri() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
        (dataUser?.userId ?? '')) {
      return true;
    }
    return false;
  }

  bool isDuyetLich() {
    return chiTietLichLamViecSubject.value.status == 2;
  }

  bool isLichHuy() {
    return chiTietLichLamViecSubject.value.status == 8;
  }

  bool isNguoiTao() {
    if (dataUser?.userId == chiTietLichLamViecSubject.value.createdBy) {
      return true;
    }
    return false;
  }

  bool isOwner() {
    if (activeChuTri() && isNguoiTao()) {
      return true;
    }
    return false;
  }

  bool trangThaiHuy() {
    if (chiTietLichLamViecSubject.value.status == STATUS_SCHEDULE.HUY) {
      return true;
    }
    return false;
  }

  void initDataButton() {
    listButton.clear();
    scheduleCoperatives =
        dataListStr(chiTietLichLamViecSubject.value.canBoThamGiaStr);

    ///check quyen sua lich
    if (chiTietLichLamViecSubject.value.thoiGianKetThuc.isEmpty &&
        (activeChuTri() || isNguoiTao() || isThuKy()) &&
        chiTietLichLamViecSubject.value.status != 8 &&
        !isLichHuy() &&
        !isLichThuHoi()) {
      listButton.add(PERMISSION_DETAIL.SUA);
    }

    ///check quyen xoa
    if (chiTietLichLamViecSubject.value.thoiGianKetThuc.isEmpty &&
        (activeChuTri() || isNguoiTao() || isThuKy()) &&
        !isLichHuy() &&
        !isLichThuHoi()) {
      listButton.add(PERMISSION_DETAIL.XOA);
    }

    ///check quyen button thu hoi
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy()) {
      listButton.add(PERMISSION_DETAIL.THU_HOI);
    }

    ///check quyen tu choi va huy duyet
    if (!isLichHuy() &&
        chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        (chiTietLichLamViecSubject.value.status == 1 ||
            chiTietLichLamViecSubject.value.status == 2)) {
      if (chiTietLichLamViecSubject.value.status == 1) {
        listButton.add(PERMISSION_DETAIL.TU_CHOI);
      } else {
        listButton.add(PERMISSION_DETAIL.HUY_DUYET);
      }
    }

    ///check quyen button cu can bo
    if (chiTietLichLamViecSubject.value.status != 8 &&
        isLichThuHoi() &&
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-cu-can-bo',
        ) &&
        isCuCanBo() &&
        classThamDu() != 2) {
      listButton.add(PERMISSION_DETAIL.CU_CAN_BO);
    }

    ///check quyen button tu choi tham gia
    if (dataXacNhanThamGia().isNotEmpty &&
        showTextThamGia().isNotEmpty &&
        classThamDu() == 0) {
      listButton.add(PERMISSION_DETAIL.TU_CHOI_THAM_GIA);
    }

    ///check quyen button duyet lich
    if (!isDuyetLich() &&
        chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') &&
        chiTietLichLamViecSubject.value.bit_YeuCauDuyet) {
      listButton.add(PERMISSION_DETAIL.DUYET_LICH);
    }

    ///check quyen phan cong thu ky
    if (activeChuTri() && !trangThaiHuy()) {
      listButton.add(PERMISSION_DETAIL.PHAN_CONG_THU_KY);
    }

    ///check quyen cu can bo di thay
    if (!isLichHuy() &&
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'cu-can-bo-di-thay',
        ) &&
        !activeChuTri() &&
        canBoThamGia().isNotEmpty &&
        classThamDu() != 2) {
      listButton.add(PERMISSION_DETAIL.CU_CAN_BO_DI_THAY);
    }

    ///check quyen tao boc bang cuoc hop
    if (chiTietLichLamViecSubject.value.isTaoTaoBocBang) {
      listButton.add(PERMISSION_DETAIL.TAO_BOC_BANG_CUOC_HOP);
    }

    ///check quyen huy lich
    if ((isOwner() || isThuKy() && !trangThaiHuy()) && !trangThaiHuy()) {
      listButton.add(PERMISSION_DETAIL.HUY_LICH);
    }

    ///check quyen xac nhan tham gia
    if (dataXacNhanThamGia().isNotEmpty) {
      if (dataXacNhanThamGia()[0].TrangThai == 0 || isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_THAM_GIA);
      }

      String idValue = '';

      for (final i in thamGia()) {
        if ((i.Id ?? '').isNotEmpty) {
          idValue = i.Id ?? '';
          break;
        }
      }

      ///check quyen huy xac nhan
      if (dataXacNhanThamGia()[0].TrangThai == 1 && isDaCuCanBo()) {
        listButton.add(PERMISSION_DETAIL.HUY_XAC_NHAN);
      }

      ///check quyen xac nhan lai
      if (dataXacNhanThamGia()[0].TrangThai == 2) {
        listButton.add(PERMISSION_DETAIL.XAC_NHAN_LAI);
      }
    }

    listButtonSubject.add(listButton);
  }

  int trangThaiPhong() {
    return _getThongTinPhongHop.value?.trangThai ?? 0;
  }

  ///======================= check quyen tab cong tac chuan bi =======================
  ///1. check phong hop

  ///check button duyet phong
  bool checkDuyetPhong() {
    return trangThaiPhong() == 0 || trangThaiPhong() == 2;
  }

  bool checkPermission() {
    if (HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-duyet-phong',
        ) &&
        chiTietLichLamViecSubject.value.isDuyetPhong) {
      return true;
    }
    return false;
  }

  bool checkHuyDuyet() {
    return trangThaiPhong() == 0 || trangThaiPhong() == 1;
  }

  ///check button tu choi va huy duyet
  PERMISSION_TAB isHuyDuyet() {
    return trangThaiPhong() == 0
        ? PERMISSION_TAB.TU_CHOI
        : PERMISSION_TAB.HUY_DUYET;
  }

  ///2.check quyen yeu cau thiet bi (btn duyet va btn tu choi)
  bool isButtonYeuCauThietBi() {
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'quyen-duyet-thiet-bi',
        ) &&
        (chiTietLichLamViecSubject.value.isDuyetThietBi ?? false);
  }

  ///3.check quyen duyet ky thuat
  bool checkPermissionDKT() {
    if (trangThaiPhong() != 1) return false;
    if (chiTietLichLamViecSubject.value.bit_PhongTrungTamDieuHanh ?? false) {
      return HiveLocal.checkPermissionApp(
        permissionType: PermissionType.VPDT,
        permissionTxt: 'duyet-ky-thuat-ttdh',
      );
    }
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat',
        ) ||
        HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat-ttdh',
        );
  }

  ///check quyen btn tu choi dkt va huy dkt
  bool checkDuyetKyThuat() {
    return HiveLocal.checkPermissionApp(
          permissionType: PermissionType.VPDT,
          permissionTxt: 'duyet-ky-thuat',
        ) ||
        HiveLocal.checkPermissionApp(
              permissionType: PermissionType.VPDT,
              permissionTxt: 'duyet-ky-thuat-ttdh',
            ) &&
            ([
              TRANG_THAI_DUYET_KY_THUAT.CHO_DUYET,
              TRANG_THAI_DUYET_KY_THUAT.KHONG_DUYET
            ].contains(
              chiTietLichLamViecSubject.value.trangThaiDuyetKyThuat,
            ));
  }

  ///======================= check tab chuong trinh hop ==============================

  ///btn them phien hop
  bool isBtnThemPhienHop() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy()) {
      return true;
    }

    return false;
  }

  ///======================= check tab thanh phan tham gia =======================

  bool isTaoLich() {
    return chiTietLichLamViecSubject.value.createdBy ==
        (dataUser?.userId ?? '');
  }

  ///btn moi nguoi tham gia
  bool isBtnMoiNguoiThamGia() {
    if (chiTietLichLamViecSubject.value.chuTriModel.canBoId ==
            (dataUser?.userId ?? '') ||
        isThuKy() ||
        isTaoLich()) {
      return true;
    }
    return false;
  }

  ///======================= phat bieu =======================

  List<NguoiTaoStr> converStringToNguoiTao(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => NguoiTaoStr.fromJson(e)).toList();
  }

  List<PhienHopModel> converStringToPhienHop(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    final data = jsonDecode(jsonString);

    return data.map((e) => PhienHopModel.fromJson(e)).toList();
  }

  List<PhienHopModel> phienHop() {
    return converStringToPhienHop(
        chiTietLichLamViecSubject.value.lichHop_PhienHopStr ?? '');
  }

  List<NguoiTaoStr> nguoiTao() {
    return converStringToNguoiTao(
        chiTietLichLamViecSubject.value.nguoiTao_str ?? '');
  }

  bool isNguoiTaoPhatBieu() {
    return (nguoiTao()[0].UserId ?? '').toLowerCase() ==
        (dataUser?.userId ?? '');
  }

  bool isChuTri() {
    return chiTietLichLamViecSubject.value.chuTriModel.canBoId.toLowerCase() ==
        (dataUser?.userId ?? '');
  }

  List<CanBoThamGiaStr> donViThamGiaPhatBieu() {
    if (HiveLocal.checkPermissionApp(
      permissionType: PermissionType.VPDT,
      permissionTxt: 'quyen-cu-can-bo',
    )) {
      return canBoThamGia()
          .where(
            (e) =>
                (e.CanBoId ?? '').isEmpty &&
                (e.DonViId ?? '').toLowerCase() ==
                    dataUser?.userInformation?.donViTrucThuoc?.id,
          )
          .toList();
    }
    return [];
  }

  bool isThanhPhanThamGia() {
    if (isChuTri() ||
        isNguoiTaoPhatBieu() ||
        canBoThamGia().isNotEmpty ||
        donViThamGiaPhatBieu().isNotEmpty) {
      return true;
    }
    return false;
  }

  ///check btn dang ky phat bieu
  bool isDangKyPhatBieu() {
    if (isThanhPhanThamGia()) {
      return true;
    }
    return false;
  }

  // ///check btn duyet, tu choi hoac huy duyet
  // bool checkPermissionAction() {
  //   return isChuTri() || isNguoiTaoPhatBieu() || isThuKy() || isChuTriPhien();
  // }

  ///======================= bieu quyet =======================

  ///btn them duyet bieu quyet
  bool isThemDuyetBieuQuyet() {
    if (isChuTri() || isThuKy()) {
      return true;
    }
    return false;
  }

  ///======================= ket luan hop =======================

  ///btn soan ket luan hop
  bool isSoanKetLuanHop() {
    if (xemKetLuanHopModel == KetLuanHopModel.empty() &&
        chiTietLichLamViecSubject.value.status == 2) {
      return true;
    }
    return false;
  }
}
