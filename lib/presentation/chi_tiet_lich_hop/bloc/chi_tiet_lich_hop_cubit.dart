import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/cu_can_bo_di_thay_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/thu_hoi_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/DanhSachNhiemVuLichHopModel.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/can_bo_tham_gia_str.dart';
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
import 'package:ccvc_mobile/domain/model/lich_hop/tao_hop/phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';

import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chi_tiet_lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/chuong_trinh_hop_ex.dart';

import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';

import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/permission_type.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:rxdart/rxdart.dart';

const DANHSACHPHATBIEU = 0;
const CHODUYET = 1;
const DADUYET = 2;
const HUYDUYET = 3;

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  /// hạn chế khởi tạo biến mới ở trong cubit, nếu biến đó không dung trong cubit thì khởi tao ngoài view
  /// đã có các file extension riêng, các hàm get và api để đúng mục extension
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
  String idCuocHop = '';
  List<LoaiSelectModel> listLoaiHop = [];
  String? ngaySinhs;
  String chonNgay = '';
  List<File>? listFile = [];
  PhongHop chosePhongHop = PhongHop();
  BehaviorSubject<bool> isValidateSubject = BehaviorSubject();

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

  BehaviorSubject<ChiTietLichHopModel> chiTietLichHopSubject =
      BehaviorSubject();

  ChiTietLichHopModel get getChiTietLichHopModel =>
      chiTietLichHopSubject.valueOrNull ?? ChiTietLichHopModel();
  BehaviorSubject<List<YkienCuocHopModel>> listYKienCuocHop = BehaviorSubject();

  BehaviorSubject<DanhSachPhatBieuLichHopModel>
      danhSachPhatbieuLichHopModelSubject = BehaviorSubject();

  Stream<DanhSachPhatBieuLichHopModel> get danhSachPhatbieuLichHopStream =>
      danhSachPhatbieuLichHopModelSubject.stream;

  final BehaviorSubject<String> themBieuQuyet = BehaviorSubject<String>();

  final BehaviorSubject<ThongTinPhongHopModel> getThongTinPhongHopSb =
      BehaviorSubject<ThongTinPhongHopModel>();

  Stream<ThongTinPhongHopModel> get getThongTinPhongHop =>
      getThongTinPhongHopSb.stream;

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

  List<NguoiChutriModel> dataThuKyOrThuHoiDeFault = [];

  List<NguoiChutriModel> dataThuHoi = [];

  DateTime timeNow = DateTime.now();
  TimerData end = TimerData(hour: 00, minutes: 00);
  TimerData start = TimerData(
    hour: 00,
    minutes: 00,
  );

  bool loaiBieuQ = false;
  String date = DateTime.now().toStringWithListFormat;

  List<DanhSachNguoiThamGiaModel> listDanhSach = [];
  List<String> listLuaChon = [];

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

  final BehaviorSubject<int> checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => checkRadioSubject.stream;

  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  TaoPhienHopRepuest taoPhienHopRepuest = TaoPhienHopRepuest();

  List<MoiHopRequest> moiHopRequest = [];

  bool phuongThucNhan = false;

  List<ThuHoiHopRequest> thuHoiHopRequest = [];

  Future<void> initDataChiTiet({final bool needCheckPermission = false}) async {
    await getChiTietLichHop(idCuocHop);

    await getDanhSachThuHoiLichHop(idCuocHop);

    await getDanhSachNguoiChuTriPhienHop(idCuocHop);

    ///check permission button
    if (needCheckPermission) {
      initDataButton();
    }
  }
}
