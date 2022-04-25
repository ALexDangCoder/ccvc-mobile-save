import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/nhiem_vu_chi_tiet_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_nhiem_vu_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
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
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
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
  String? startTime;
  String? endTime;
  String? tenBieuQuyet;
  bool? loaiBieuQuyet;
  String? dateBieuQuyet;
  String getPhienHopId = '';
  String idPerson = '';
  BehaviorSubject<List<StatusKetLuanHopModel>> dataTinhTrangKetLuanHop =
      BehaviorSubject.seeded([]);
  BehaviorSubject<ChonBienBanCuocHopModel> dataMauBienBan = BehaviorSubject();
  List<String> dataThuhoi = ['thu hoi', 'thu hồi'];
  List<String> dataBocBang = ['boc bang', 'boc bang2'];
  BehaviorSubject<List<PhienhopModel>> phienHop = BehaviorSubject();
  List<String> dataDropdown = ['1', '2', '3'];
  BehaviorSubject<String> noiDung = BehaviorSubject();
  List<CanBoModel> dataThanhPhanThamGia = [];
  List<String?> data = [];
  HtmlEditorController? controller = keyEditKetLuanHop.currentState?.controller;

  BehaviorSubject<List<DanhSachLoaiNhiemVuLichHopModel>>
      danhSachLoaiNhiemVuLichHopModel = BehaviorSubject();

  BehaviorSubject<List<VBGiaoNhiemVuModel>> listVBGiaoNhiemVu =
      BehaviorSubject();

  List<VBGiaoNhiemVuModel> vBGiaoNhiemVuModel = [];

  BehaviorSubject<List<ListPhienHopModel>> danhSachChuongTrinhHop =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listNguoiCHuTriModel =
      BehaviorSubject();

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

  final BehaviorSubject<String> chonThuKy = BehaviorSubject<String>();

  Stream<ChiTietLichHopModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;

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

  List<String> thuKy = [];

  String id = '';
  List<LoaiSelectModel> listLoaiHop = [];
  String? ngaySinhs;
  String chonNgay = '';
  List<File>? listFile = [];

  TimerData subStringTime(String time) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final dateTime = dateFormat.parse(time);
    return TimerData(hour: dateTime.hour, minutes: dateTime.minute);
  }

  // Future<void> selectBirthdayEvent(String birthday) async {
  //   ngaySinhs = birthday;
  // }

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
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd 00:00:00');
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
  String date = '';

  String timer(String time) {
    final dateTime = DateTime.parse(time).toStringWithListFormat;
    return dateTime;
  }

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
      dateStart: timer(date),
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

  Future<void> initData({
    required String id,
  }) async {
    showLoading();
    await getChiTietLichHop(id);
    final queue = Queue(parallel: 5);
    // unawaited(queue.add(() => getThongTinPhongHopApi()));
    // unawaited(queue.add(() => getDanhSachThietBi()));

    // await queue.onComplete.catchError((er) {});
    // await getDanhSachPhatBieuLichHop(typeStatus.value, id);
    // unawaited(queue.add(() => soLuongPhatBieuData(id: id)));
    await danhSachCanBoTPTG(id: id);

    ///bieu quyet
    await callApi(id);

    ///chuong trinh hop
    unawaited(queue.add(() => getDanhSachNguoiChuTriPhienHop(id)));
    unawaited(queue.add(() => getListPhienHop(id)));
    await getListPhienHop(id);

    ///kết luận họp
    unawaited(queue.add(() => getDanhSachNhiemVu(id)));
    unawaited(queue.add(() => getXemKetLuanHop(id)));
    unawaited(queue.add(() => getDanhSachLoaiNhiemVu()));
    // await ListStatusKetLuanHop();
    // await postChonMauHop();
    ///ý kiến
    // unawaited(queue.add(() => getDanhSachYKien(id, ' ')));
    unawaited(queue.add(() => getDanhSachPhienHop(id)));
    showContent();
    queue.dispose();
  }

  BehaviorSubject<List<CanBoModel>> thanhPhanThamGia =
      BehaviorSubject<List<CanBoModel>>();

  Stream<List<CanBoModel>> get streamthanhPhanThamGia =>
      thanhPhanThamGia.stream;

  final BehaviorSubject<bool> checkBoxCheck = BehaviorSubject();

  List<String> selectedIds = [];

  BehaviorSubject<List<PhatBieuModel>> streamPhatBieu =
      BehaviorSubject<List<PhatBieuModel>>();

  BehaviorSubject<List<DanhSachBietQuyetModel>> streamBieuQuyet =
      BehaviorSubject();

  final BehaviorSubject<int> typeStatus = BehaviorSubject.seeded(0);

  Stream<int> get getTypeStatus => typeStatus.stream;

  SoLuongPhatBieuModel dataSoLuongPhatBieu = SoLuongPhatBieuModel();

  List<PhatBieuModel> listPhatBieu = [];

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  TaoPhienHopRepuest taoPhienHopRepuest = TaoPhienHopRepuest();

  List<MoiHopRequest> moiHopRequest = [];

  bool phuongThucNhan = false;

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
        error: (err) {});
  }

  LoaiSelectModel? _findLoaiHop(String id) {
    final loaiHopType =
        listLoaiHop.where((element) => element.id == id).toList();
    if (loaiHopType.isNotEmpty) {
      return loaiHopType.first;
    }
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

  void addThuKyToList(String value) {
    thuKy.add(value);
  }

  void removeThuKy(String value) {
    thuKy.remove(value);
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
    required String idLichHop,
    required String canBoId,
    required String idPhienHop,
  }) async {
    final result =
        await hopRp.getDanhSachBieuQuyetLichHop(idLichHop, canBoId, idPhienHop);
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
  Future<void> getDanhSachPhatBieuLichHop(int status, String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(status, lichHopId);
    result.when(
      success: (res) {
        final List<PhatBieuModel> phatBieu = res.toList();
        streamPhatBieu.sink.add(phatBieu);
      },
      error: (err) {},
    );
  }

  void getValueStatus(int value) {
    if (value == DANHSACHPHATBIEU) {
      typeStatus.sink.add(value);
      getDanhSachPhatBieuLichHopNoStatus(id);
    } else {
      typeStatus.sink.add(value);
      getDanhSachPhatBieuLichHop(value, id);
    }
  }

// danh cho duyet, da duyet, huy duyet
  Future<void> getDanhSachPhatBieuLichHopNoStatus(String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHopNoStatus(lichHopId);
    result.when(
      success: (res) {
        final List<PhatBieuModel> phatBieu = res.toList();
        streamPhatBieu.sink.add(phatBieu);
      },
      error: (err) {},
    );
  }

  Future<void> soLuongPhatBieuData({required String id}) async {
    final result = await hopRp.getSoLuongPhatBieu(id);
    result.when(
        success: (res) {
          dataSoLuongPhatBieu.danhSachPhatBieu = res.danhSachPhatBieu;
          dataSoLuongPhatBieu.choDuyet = res.choDuyet;
          dataSoLuongPhatBieu.daDuyet = res.daDuyet;
          dataSoLuongPhatBieu.huyDuyet = res.huyDuyet;
        },
        error: (err) {});
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
      },
      error: (error) {},
    );
  }

  Future<void> ThemPhienHop(String id) async {
    final result = await hopRp.getThemPhienHop(
      id,
      taoPhienHopRepuest.canBoId ?? '',
      taoPhienHopRepuest.donViId ?? '',
      taoPhienHopRepuest.thoiGian_BatDau ?? '',
      taoPhienHopRepuest.thoiGian_KetThuc ?? '',
      taoPhienHopRepuest.noiDung ?? '',
      taoPhienHopRepuest.tieuDe ?? '',
      taoPhienHopRepuest.hoTen ?? '',
      taoPhienHopRepuest.IsMultipe,
      [],
    );
    result.when(success: (res) {}, error: (error) {});
  }
}

///thành phần tham gia
extension ThanhPhanThamGia on DetailMeetCalenderCubit {
  Future<void> ThemThanhPhanThamGia(String id) async {
    final result =
        await hopRp.postMoiHop('', false, phuongThucNhan, moiHopRequest);
    result.when(success: (res) {}, error: (error) {});
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
    checkBoxCheck.sink.add(check);
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
      selectedIds = dataThanhPhanThamGia.map((e) => e.id ?? '').toList();
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
    check = selectedIds.length == dataThanhPhanThamGia.length;
    checkBoxCheck.sink.add(check);
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
