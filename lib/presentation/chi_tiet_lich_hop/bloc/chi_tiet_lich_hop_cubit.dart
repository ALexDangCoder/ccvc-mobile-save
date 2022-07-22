import 'dart:async';
import 'dart:core';

import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/sua_bieu_quyet_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/can_bo_tham_gia_str.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danhSachCanBoBieuQuyetModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lua_chon_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nguoi_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/file_upload_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_status_room_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:ccvc_mobile/widgets/views/show_loading_screen.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  /// hạn chế khởi tạo biến mới ở trong cubit, nếu biến đó không dung trong cubit thì khởi tao ngoài view
  /// đã có các file extension riêng, các hàm get và api để đúng mục extension
  HopRepository get hopRp => Get.find();
  KetLuanHopState ketLuanHopState = KetLuanHopState();
  String ngayBatDaus = '';
  String ngayKetThucs = '';
  bool check = false;
  String startTime = '00:00';
  String endTime = '00:00';
  String? tenBieuQuyet;
  String idPhienHop = '';
  bool? loaiBieuQuyet;
  DonViModel donViModel = DonViModel();
  String? dateBieuQuyet;
  String phienHopId = '';
  String tenPhienHop = '';
  List<CanBoModel> dataThanhPhanThamGia = [];
  List<String?> data = [];
  List<String> selectPhatBieu = [];
  String idCapNhatTrangThai = '';
  String idCuocHop = '';
  String idDanhSachCanBo = '';
  String idCanBoDiThay = '';
  List<LoaiSelectModel> listLoaiHop = [];
  String? ngaySinhs;
  String chonNgay = '';
  List<File>? listFile = [];
  PhongHop chosePhongHop = PhongHop();
  final int maxSizeFile30 = 31457280;
  BehaviorSubject<bool> isValidateSubject = BehaviorSubject();
  BehaviorSubject<bool> isValidateTimer = BehaviorSubject();
  BehaviorSubject<bool> isValidateThoiGianBatDauKetThuc = BehaviorSubject();
  BehaviorSubject<List<DonViModel>> listDonViModel = BehaviorSubject();
  BehaviorSubject<bool> checkValidateLoaiNV = BehaviorSubject();
  List<int> dataLoaiNhiemVu = [];
  List<Data> listStatusRom = [];
  List<DonViModel> listDataCanBo = [];
  List<DanhSachThanhPhanThamGiaModel> listThanhPhanThamGiaOld = [];
  Timer? _debounce;
  bool needRefreshMainMeeting = false;
  ChiTietBieuQuyetModel chiTietBieuQuyetModel = ChiTietBieuQuyetModel();
  List<DsLuaChonOld> listLuaChonOld = [];
  BehaviorSubject<ChiTietBieuQuyetModel> chiTietBieuQuyetSubject =
      BehaviorSubject();
  BehaviorSubject<DanhSachCanBoBieuQuyetModel> danhSachCanBoBieuQuyetSubject =
      BehaviorSubject();
  BehaviorSubject<List<DanhSachThanhPhanThamGiaModel>> listBieuQuyetSubject =
      BehaviorSubject();
  List<String> listLuaChon = [];
  List<SuaDanhSachLuaChonModel> listLuaChonNew = [];
  List<ButtonStatePhatBieu> buttonStatePhatBieu = [
    ButtonStatePhatBieu(
      key: S.current.danh_sach_phat_bieu,
      value: 0,
      color: color5A8DEE,
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
      key: S.current.tu_choi,
      value: 0,
      color: statusCalenderRed,
    ),
  ];
  BehaviorSubject<List<NguoiChutriModel>> listCuCanBoSubject =
      BehaviorSubject();
  BehaviorSubject<ButtonStatePhatBieu> buttonStatePhatBieuSubject =
      BehaviorSubject();

  String idPerson = '';

  final DataUser? dataUser = HiveLocal.getDataUser();

  List<PERMISSION_DETAIL> listButton = [];

  List<CanBoThamGiaStr> scheduleCoperatives = [];

  List<String> fileDeleteKetLuanHop = [];
  List<File> fileSelectKetLuanHop = [];
  BehaviorSubject<List<StatusKetLuanHopModel>> dataTinhTrangKetLuanHop =
      BehaviorSubject.seeded([]);
  BehaviorSubject<ChonBienBanCuocHopModel> dataMauBienBan = BehaviorSubject();

  BehaviorSubject<List<PhienhopModel>> phienHop = BehaviorSubject();
  BehaviorSubject<List<PERMISSION_DETAIL>> listButtonSubject =
      BehaviorSubject();
  BehaviorSubject<String> noiDung = BehaviorSubject();

  HtmlEditorController? controller = keyEditKetLuanHop.currentState?.controller;

  List<DanhSachLoaiNhiemVuLichHopModel> danhSachLoaiNhiemVuLichHopModel = [];

  BehaviorSubject<List<VBGiaoNhiemVuModel>> listVBGiaoNhiemVu =
      BehaviorSubject.seeded([]);

  BehaviorSubject<bool> checkTuyChinh = BehaviorSubject();

  BehaviorSubject<List<ListPhienHopModel>> danhSachChuongTrinhHop =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listNguoiCHuTriModel =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listThuHoi = BehaviorSubject();

  BehaviorSubject<List<MoiHopModel>> listMoiHopSubject = BehaviorSubject();

  Stream<List<MoiHopModel>> get listMoiHopStream => listMoiHopSubject.stream;

  BehaviorSubject<ChiTietLichHopModel> chiTietLichHopSubject =
      BehaviorSubject();

  ChiTietLichHopModel get getChiTietLichHopModel =>
      chiTietLichHopSubject.valueOrNull ?? ChiTietLichHopModel();
  BehaviorSubject<List<YkienCuocHopModel>> listYKienCuocHop = BehaviorSubject();
  BehaviorSubject<List<YkienCuocHopModel>> listYKienPhienHop =
      BehaviorSubject();

  BehaviorSubject<DanhSachPhatBieuLichHopModel>
      danhSachPhatbieuLichHopModelSubject = BehaviorSubject();

  Stream<DanhSachPhatBieuLichHopModel> get danhSachPhatbieuLichHopStream =>
      danhSachPhatbieuLichHopModelSubject.stream;

  final BehaviorSubject<List<String>> themLuaChonBieuQuyet = BehaviorSubject();
  List<String> listThemLuaChon = [];
  final BehaviorSubject<List<SuaDanhSachLuaChonModel>> suaDanhSachLuaChon =
      BehaviorSubject();
  BehaviorSubject<ThongTinPhongHopModel> getThongTinPhongHopSb =
      BehaviorSubject();

  Stream<ThongTinPhongHopModel> get getThongTinPhongHop =>
      getThongTinPhongHopSb.stream;
  BehaviorSubject<ThongTinPhongHopModel> getThongTinYeuCauChuanBi =
      BehaviorSubject();
  List<DanhSachLuaChonModel> lisLuaChonOld = [];

  ThongTinPhongHopModel get getThongTinPhongHopForPermision =>
      getThongTinPhongHopSb.valueOrNull ?? ThongTinPhongHopModel();

  final BehaviorSubject<List<ThietBiPhongHopModel>> getListThietBiPhongHop =
      BehaviorSubject<List<ThietBiPhongHopModel>>();

  Stream<List<ThietBiPhongHopModel>> get getListThietBi =>
      getListThietBiPhongHop.stream;

  XemKetLuanHopModel xemKetLuanHopModel = XemKetLuanHopModel.emty();

  BehaviorSubject<KetLuanHopModel> ketLuanHopSubject = BehaviorSubject();

  KetLuanHopModel get getKetLuanHopModel =>
      ketLuanHopSubject.valueOrNull ?? KetLuanHopModel();

  BehaviorSubject<List<DanhSachNhiemVuLichHopModel>>
      danhSachNhiemVuLichHopSubject = BehaviorSubject();

  BehaviorSubject<List<DanhSachNguoiThamGiaModel>> nguoiThamGiaSubject =
      BehaviorSubject();

  final BehaviorSubject<List<PhongHopModel>> phongHopSubject =
      BehaviorSubject();
  List<DanhSachNguoiThamGiaModel> listData = [];

  List<String> cacLuaChonBieuQuyet = [];
  List<SuaDanhSachLuaChonModel> suaLuaChonBieuQuyet = [];
  List<NguoiChutriModel> dataThuKyOrThuHoiDeFault = [];
  DateTime timeNow = DateTime.now();
  TimerData end = TimerData(hour: 00, minutes: 00);
  TimerData start = TimerData(
    hour: 00,
    minutes: 00,
  );

  Future<void> initDataChiTiet({final bool needCheckPermission = false}) async {
    final queue = Queue(parallel: 4);
    showLoading();
    unawaited(queue.add(() => getChiTietLichHop(idCuocHop)));
    unawaited(queue.add(() => getDanhSachThuHoiLichHop(idCuocHop)));
    unawaited(queue.add(() => getDanhSachNguoiChuTriPhienHop(idCuocHop)));
    unawaited(queue.add(() => getDanhSachCanBoHop(idCuocHop)));
    await queue.onComplete;

    ///check permission button
    if (needCheckPermission) {
      initDataButton();
    }
    showContent();
  }

  Future<Result<List<FileUploadModel>>> uploadFile(List<File> file) async {
    ShowLoadingScreen.show();
    final data = await hopRp.uploadMultiFile(path: file);
    ShowLoadingScreen.dismiss();
    return data;
  }

  /// dùng cho cả bên: tao moi nhiem vu - kl hop
  Future<void> getDanhSachNguoiChuTriPhienHop(String id) async {
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(idCuocHop);
    result.when(
      success: (res) {
        listNguoiCHuTriModel.sink.add(res);
        dataThuKyOrThuHoiDeFault = res;
      },
      error: (error) {},
    );
  }

  bool loaiBieuQ = false;
  String date = '';

  List<DanhSachNguoiThamGiaModel> listDanhSach = [];
  List<String> danhSachLuaChon = [];

  BehaviorSubject<List<CanBoModel>> thanhPhanThamGia =
      BehaviorSubject<List<CanBoModel>>();
  List<CanBoModel> listCanBo = [];
  BehaviorSubject<bool> checkBoxCheckAllTPTG = BehaviorSubject();
  BehaviorSubject<CanBoModel> isCheckDiemDanhSubject = BehaviorSubject();
  List<String> selectedIds = [];

  BehaviorSubject<List<PhatBieuModel>> streamPhatBieu =
      BehaviorSubject<List<PhatBieuModel>>();

  BehaviorSubject<List<DanhSachBietQuyetModel>> streamBieuQuyet =
      BehaviorSubject();
  BehaviorSubject<List<int>> streamListVoteBieuQuyet = BehaviorSubject();
  List<DanhSachBietQuyetModel> listBieuQuyet = [];
  final BehaviorSubject<int> typeStatus = BehaviorSubject.seeded(0);

  BehaviorSubject<SoLuongPhatBieuModel> dataSoLuongPhatBieuSubject =
      BehaviorSubject<SoLuongPhatBieuModel>();

  final BehaviorSubject<int> checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => checkRadioSubject.stream;

  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  TaoPhienHopDetailRepuest taoPhienHopRepuest = TaoPhienHopDetailRepuest();

  List<MoiHopRequest> moiHopRequest = [];

  bool phuongThucNhan = false;
  List<String> addLuaChon = [];
  List<SuaDanhSachLuaChonModel> danhSachLuaChonNew = [];
  List<ThuHoiHopRequest> thuHoiHopRequest = [];

  /// funtion delay
  Future<void> waitToDelay({
    required Function actionNeedDelay,
    required int timeSecond,
  }) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
        Duration(
          milliseconds: timeSecond * 1000,
        ), () {
      actionNeedDelay();
    });
  }
}

class KetLuanHopState {
  final BehaviorSubject<List<FileDetailMeetModel>> listFileDefault =
      BehaviorSubject();
  final BehaviorSubject<List<File>> listFileSelect = BehaviorSubject();
  final BehaviorSubject<bool> validateTinhTrang = BehaviorSubject();

  String valueEdit = '';
  String reportStatusId = '';
  String reportTemplateId = '';
  List<File> listFiles = [];
  List<FileDetailMeetModel> filesApi = [];
  List<String> fileDelete = [];
}

///Thanh phan tham gia
const _THANH_PHAN_THAM_GIA = 0;
const _DON_VI_PHOI_HOP_KHAC = 1;
const _THONG_TIN_KHAC_MOI = 2;

class ThanhPhanThamGiaHopCubit extends DetailMeetCalenderCubit {
  DetailMeetCalenderCubit? detailMeetCalenderCubit;
  final Map<int, List<DonViModel>> _data = {};
  List<String> diemDanhIds = [];

  Future<void> getDanhSachCuocHopTPTH() async {
    final result = await hopRp.getDanhSachCuocHopTPTH(idCuocHop);

    result.when(
      success: (success) {
        thanhPhanThamGia.add(success.listCanBo ?? []);
        // dataThaGiaDefault = success.listCanBo ?? [];
      },
      error: (error) {},
    );
  }

  Future<void> themThanhPhanThamGia() async {
    final data = convertMoiHopRequest();
    if (data.isEmpty) {
      MessageConfig.show(
        title: S.current.vui_long_chon_can_bo_hoac_don_vi_moi,
        messState: MessState.error,
      );
      return;
    }
    showLoading();
    final result =
        await hopRp.postMoiHop(idCuocHop, false, phuongThucNhan, data);
    await result.when(
      success: (res) async {
        await getDanhSachCuocHopTPTH();
        showLoading(isShow: false);
        MessageConfig.show(
          title: S.current.them_thanh_phan_tham_gia_thanh_cong,
        );
        await getDanhSachNguoiChuTriPhienHop(idCuocHop);
        moiHopRequest.clear();
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.them_thanh_phan_tham_gia_that_bai,
          messState: MessState.error,
        );
        showLoading(isShow: false);
      },
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
    showLoading();
    final result = await hopRp.postDiemDanh(diemDanhIds);

    await result.when(
      success: (value) async {
        diemDanhIds.clear();
        await getDanhSachCuocHopTPTH();
        MessageConfig.show(
          title: S.current.diem_danh_thanh_cong,
        );
        showLoading(isShow: false);
      },
      error: (error) {
        showLoading(isShow: false);
      },
    );
  }

  ///TC: Tiếp cận
  ///XL: Xử lý
  static const int INDEX_FILTER_ALL = 0;
  static const int INDEX_FILTER_TC_CHO_TIEP_NHAN = 1;
  static const int INDEX_FILTER_TC_PHAN_XU_LY = 2;
  static const int INDEX_FILTER_TC_DANG_XU_LY = 3;
  static const int INDEX_FILTER_TC_CHO_TAO_VB_DI = 4;
  static const int INDEX_FILTER_TC_DA_CHO_VB_DI = 5;
  static const int INDEX_FILTER_TC_DA_HOAN_THANH = 6;
  static const int INDEX_FILTER_TC_CHO_BSTT = 7;
  static const int INDEX_FILTER_TC_BI_TU_CHOI_TIEP_NHAN = 8;
  static const int INDEX_FILTER_TC_BI_HUY_BO = 9;
  static const int INDEX_FILTER_TC_CHUYEN_XU_LY = 10;
  static const int INDEX_FILTER_XL_CHO_TIEP_NHAN_XL = 11;
  static const int INDEX_FILTER_XL_CHO_PHAN_CONG_XL = 12;
  static const int INDEX_FILTER_XL_DA_PHAN_CONG = 13;
  static const int INDEX_FILTER_XL_CHO_XU_LY = 14;
  static const int INDEX_FILTER_XL_CHO_DUYET = 15;
  static const int INDEX_FILTER_XL_CHO_TAO_VB_DI = 16;
  static const int INDEX_FILTER_XL_DA_CHO_VB_DI = 17;
  static const int INDEX_FILTER_XL_DA_HOAN_THANH = 18;
  static const int INDEX_FILTER_XL_CHO_CHO_Y_KIEN = 19;
  static const int INDEX_FILTER_XL_DA_CHO_Y_KIEN = 20;
  static const int INDEX_FILTER_XL_THU_HOI = 21;
  static const int INDEX_FILTER_XL_TRA_LAI = 22;
  static const int INDEX_FILTER_XL_CHUYEN_XU_LY = 23;
  static const int INDEX_FILTER_TC_CHO_DUYET = 24;
  static const int INDEX_FILTER_OUT_RANGE = 25;

  Future<void> postHuyDiemDanh(String id) async {
    showLoading();
    final result = await hopRp.postHuyDiemDanh(id);
    await result.when(
      success: (value) async {
        await getDanhSachCuocHopTPTH();
        MessageConfig.show(
          title: S.current.xoa_diem_danh_thanh_cong,
        );
        showLoading(isShow: false);
      },
      error: (error) {
        showLoading(isShow: false);
      },
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
    bool value = false;
    if (selectedIds.contains(id)) {
      value = true;
    }

    return value;
  }

  void addOrRemoveId({
    required bool isSelected,
    required String id,
  }) {
    if (isSelected) {
      diemDanhIds.add(id);
    } else {
      diemDanhIds.remove(id);
    }
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

  Future<void> callApiThanhPhanThamGia() async {
    showLoading();
    diemDanhIds = [];
    await getDanhSachCuocHopTPTH();
    await danhSachCanBoTPTG(id: idCuocHop);
    showLoading(isShow: false);
  }

  void addThanhPhanThamGia(List<DonViModel> value) {
    _data[_THANH_PHAN_THAM_GIA] = value;
  }

  void addDonViPhoiHopKhac(List<DonViModel> value) {
    _data[_DON_VI_PHOI_HOP_KHAC] = value;
  }

  void addKhacMoi(List<DonViModel> value) {
    _data[_THONG_TIN_KHAC_MOI] = value;
  }

  List<MoiHopRequest> convertMoiHopRequest() {
    final data = <MoiHopRequest>[];
    data.addAll(_coverDataThanhPhanThamGia());
    data.addAll(
      _data[_DON_VI_PHOI_HOP_KHAC]?.map(
            (a) => MoiHopRequest(
              DauMoiLienHe: a.dauMoiLienHe,
              Email: a.email,
              GhiChu: a.noidung,
              SoDienThoai: a.sdt,
              TenCoQuan: a.tenCoQuan,
              VaiTroThamGia: a.vaiTroThamGia,
              dauMoi: a.dauMoiLienHe,
              email: a.email,
              noiDungLamViec: a.noidung,
              soDienThoai: a.sdt,
              tenCanBo: '',
              tenDonVi: a.tenDonVi,
            ),
          ) ??
          [],
    );
    data.addAll(
      _data[_THONG_TIN_KHAC_MOI]?.map(
            (a) => MoiHopRequest(
              DauMoiLienHe: a.dauMoiLienHe,
              Email: a.email,
              GhiChu: a.noidung,
              SoDienThoai: a.sdt,
              TenCoQuan: a.tenCoQuan,
              VaiTroThamGia: a.vaiTroThamGia,
              dauMoi: a.dauMoiLienHe,
              email: a.email,
              noiDungLamViec: a.noidung,
              soDienThoai: a.sdt,
              tenCanBo: '',
              tenDonVi: a.tenDonVi,
            ),
          ) ??
          [],
    );
    data.addAll(
      _data[_THONG_TIN_KHAC_MOI]?.map(
            (a) => MoiHopRequest(
              DauMoiLienHe: a.dauMoiLienHe,
              Email: a.email,
              GhiChu: a.noidung,
              SoDienThoai: a.sdt,
              id: null,
              TenCoQuan: a.tenCoQuan,
              VaiTroThamGia: a.vaiTroThamGia,
              dauMoi: a.dauMoiLienHe,
              email: a.email,
              noiDungLamViec: a.noidung,
              soDienThoai: a.sdt,
              tenCanBo: a.tenCanBo,
              tenDonVi: a.tenDonVi,
            ),
          ) ??
          [],
    );
    return data;
  }

  List<MoiHopRequest> _coverDataThanhPhanThamGia() {
    return _data[_THANH_PHAN_THAM_GIA]
            ?.map(
              (e) => e.userId.isNotEmpty
                  ? MoiHopRequest(
                      VaiTroThamGia: e.vaiTroThamGia,
                      tenDonVi: e.tenDonVi,
                      hoTen: e.tenCanBo,
                      status: e.status,
                      type: e.type,
                      userId: e.userId,
                      CanBoId: e.userId,
                      donViId: e.donViId,
                      DonViId: e.donViId,
                      chucVu: e.chucVu,
                      GhiChu: e.noidung,
                    )
                  : MoiHopRequest(
                      VaiTroThamGia: e.vaiTroThamGia,
                      tenDonVi: e.name,
                      status: e.status,
                      type: e.type,
                      donViId: e.donViId,
                      DonViId: e.donViId,
                      GhiChu: e.noidung,
                    ),
            )
            .toList() ??
        <MoiHopRequest>[];
  }

  void dispose() {
    _data.clear();
  }

  void showLoading({bool isShow = true}) {
    void show() {
      if (isMobile()) {
        ShowLoadingScreen.show();
      } else {
        detailMeetCalenderCubit?.showLoading();
      }
    }

    void dismiss() {
      if (isMobile()) {
        ShowLoadingScreen.dismiss();
      } else {
        detailMeetCalenderCubit?.showContent();
      }
    }

    if (isShow) {
      show();
    } else {
      dismiss();
    }
  }
}
