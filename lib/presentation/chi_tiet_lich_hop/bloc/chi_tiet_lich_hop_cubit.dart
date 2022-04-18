import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_lich_hop_resquest.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/status_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/xem_ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/edit_ket_luan_hop_screen.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/timer/time_date_widget.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
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

  BehaviorSubject<List<StatusKetLuanHopModel>> dataTinhTrangKetLuanHop =
      BehaviorSubject.seeded([]);
  BehaviorSubject<ChonBienBanCuocHopModel> dataMauBienBan = BehaviorSubject();
  List<String> dataThuhoi = ['thu hoi', 'thu hồi'];
  List<String> dataBocBang = ['boc bang', 'boc bang2'];
  List<PhienhopModel> phienHop = [];
  List<String> dataDropdown = ['1', '2', '3'];
  BehaviorSubject<String> noiDung = BehaviorSubject();
  List<CanBoModel> dataThanhPhanThamGia = [];
  List<String?> data = [];
  HtmlEditorController? controller = keyEditKetLuanHop.currentState?.controller;

  BehaviorSubject<List<ListPhienHopModel>> danhSachChuongTrinhHop =
      BehaviorSubject();

  BehaviorSubject<List<NguoiChutriModel>> listNguoiCHuTriModel =
      BehaviorSubject();

  BehaviorSubject<MessageModel> messageSubject = BehaviorSubject();

  Stream<MessageModel> get messageStream => messageSubject.stream;

  BehaviorSubject<List<MoiHopModel>> listMoiHopSubject = BehaviorSubject();

  Stream<List<MoiHopModel>> get listMoiHopStream => listMoiHopSubject.stream;

  BehaviorSubject<ChiTietLichHopModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  BehaviorSubject<List<YkienCuocHopModel>> listYKienCuocHop = BehaviorSubject();

  BehaviorSubject<DanhSachPhatBieuLichHopModel>
      danhSachPhatbieuLichHopModelSubject = BehaviorSubject();

  Stream<DanhSachPhatBieuLichHopModel> get danhSachPhatbieuLichHopStream =>
      danhSachPhatbieuLichHopModelSubject.stream;

  final BehaviorSubject<String> _themBieuQuyet = BehaviorSubject<String>();

  Stream<String> get themBieuQuyet => _themBieuQuyet.stream;

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

  BehaviorSubject<DanhSachNhiemVuLichHopModel> danhSachNhiemVuLichHopSubject =
      BehaviorSubject();

  List<String> cacLuaChonBieuQuyet = [];

  String id = '';
  List<LoaiSelectModel> listLoaiHop = [];

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  Future<void> initData({String? id, bool? danhSachYKien}) async {
    showLoading();
    // await getChiTietLichHop(id);
    // final queue = Queue(parallel: 1);
    // unawaited(queue.add(() => getThongTinPhongHopApi()));
    // unawaited(queue.add(() => getDanhSachThietBi()));
    // unawaited(queue.add(() => getDanhSachNguoiChuTriPhienHop(id)));
    // unawaited(queue.add(() => getXemKetLuanHop(id)));
    // await queue.onComplete.catchError((er) {});
    // await getDanhSachPhatBieuLichHop(typeStatus.value, id);
    // await getDanhSachBieuQuyetLichHop(id);
    // await soLuongPhatBieuData(id: id);
    // await getDanhSachPhienHop(id);
    if (danhSachYKien == true) {
      await getDanhSachYKien(id ?? '');
    }
    // await postChonMauHop();
    // await ListStatusKetLuanHop();
    // await danhSachCanBoTPTG(id: id);
    // await getListPhienHop(id);
    showContent();
    // queue.dispose();
  }

  Future<void> getChiTietLichHop(String id) async {
    this.id = id;
    final loaiHop = await hopRp
        .getLoaiHop(CatogoryListRequest(pageIndex: 1, pageSize: 100, type: 1));
    loaiHop.when(
        success: (res) {
          listLoaiHop = res;
        },
        error: (err) {});
    final result = await hopRp.getChiTietLichHop(id);
    result.when(
        success: (res) {
          res.loaiHop = _findLoaiHop(res.typeScheduleId)?.name ?? '';
          chiTietLichLamViecSubject.add(res);
        },
        error: (err) {});
  }

  Future<void> postMoiHop({
    required String lichHopId,
    required bool IsMultipe,
    required bool isSendMail,
    required List<MoiHopRequest> body,
  }) async {
    final result =
        await hopRp.postMoiHop(lichHopId, IsMultipe, isSendMail, body);

    result.when(
      success: (value) {
        listMoiHopSubject.add(value);
      },
      error: (error) {},
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

  Future<void> getDanhSachPhatBieuLichHop(int status, String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(status, lichHopId);
    result.when(
        success: (res) {
          final List<PhatBieuModel> phatBieu = res.toList();
          phatbieu.sink.add(phatBieu);
        },
        error: (err) {});
  }

  // danh cho duyet, da duyet, huy duyet
  Future<void> getDanhSachPhatBieuLichHopNoStatus(String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHopNoStatus(lichHopId);
    result.when(
        success: (res) {
          final List<PhatBieuModel> phatBieu = res.toList();
          phatbieu.sink.add(phatBieu);
        },
        error: (err) {});
  }

  // danh sach bieu quyet
  Future<void> getDanhSachBieuQuyetLichHop(String id) async {
    final result = await hopRp.getDanhSachBieuQuyetLichHop(id);
    result.when(
        success: (res) {
          final List<PhatBieuModel> resBieuQuyet = res.toList();
          bieuQuyet.sink.add(resBieuQuyet);
        },
        error: (err) {});
  }

  // thanh phan tham gia
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

  LoaiSelectModel? _findLoaiHop(String id) {
    final loaiHopType =
        listLoaiHop.where((element) => element.id == id).toList();
    if (loaiHopType.isNotEmpty) {
      return loaiHopType.first;
    }
  }

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
        error: (err) {});
  }

  // danh sách phiên họp ý kiến cuộc họp
  Future<void> getDanhSachPhienHop(String id) async {
    showLoading();
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {
        phienHop = res.danhSachPhienHop!.toList();
      },
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
    startTime = '${hourStart.toString()}:${minuteStart.toString()}';
    endTime = '${hourEnd.toString()}:${minuteEnd.toString()}';
  }

  void getDate(String value) {
    dateBieuQuyet = value;
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

  BehaviorSubject<List<CanBoModel>> thanhPhanThamGia =
      BehaviorSubject<List<CanBoModel>>();

  Stream<List<CanBoModel>> get streamthanhPhanThamGia =>
      thanhPhanThamGia.stream;

  final BehaviorSubject<bool> checkBoxCheck = BehaviorSubject();

  Stream<bool> get checkBoxCheckBool => checkBoxCheck.stream;

  void checkBoxButton() {
    checkBoxCheck.sink.add(check);
  }

  List<String> selectedIds = [];

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

  BehaviorSubject<List<PhatBieuModel>> phatbieu =
      BehaviorSubject<List<PhatBieuModel>>();

  Stream<List<PhatBieuModel>> get streamPhatBieu => phatbieu.stream;

  BehaviorSubject<List<PhatBieuModel>> bieuQuyet =
      BehaviorSubject<List<PhatBieuModel>>();

  Stream<List<PhatBieuModel>> get streamBieuQuyet => bieuQuyet.stream;

  final BehaviorSubject<int> typeStatus = BehaviorSubject.seeded(0);

  Stream<int> get getTypeStatus => typeStatus.stream;

  void changeType(int value) {
    if (value == 1) {}
  }

  SoLuongPhatBieuModel dataSoLuongPhatBieu = SoLuongPhatBieuModel();

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

  List<PhatBieuModel> listPhatBieu = [];

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
    if (_index == 1) {
      loaiBieuQuyet = true;
    } else {
      loaiBieuQuyet = false;
    }
  }

  DanhSachNhiemVuLichHopModel danhSachNhiemVu = DanhSachNhiemVuLichHopModel(
    soNhiemVu: 'Chua tao duoc data tren web de ghep',
    noiDungTheoDoi: 'Chua tao duoc data tren web de ghep ',
    tinhHinhThucHienNoiBo: ' Chua tao duoc data tren web de ghep',
    hanXuLy: '2021-10-29T11:42:42.4179289',
    loaiNhiemVu: 'Chua tao duoc data tren web de ghep',
    trangThai: TrangThai.DaDuyet,
  );

  Future<void> deleteChiTietLichHop(String id) async {
    final result = await hopRp.deleteChiTietLichHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> huyChiTietLichHop(String scheduleId) async {
    final result = await hopRp.huyChiTietLichHop(scheduleId, 8, false);
    result.when(success: (res) {}, error: (err) {});
  }

  TaoLichHopRequest taoLichHopRequest = TaoLichHopRequest();

  Future<void> postSuaLichHop() async {
    showLoading();

    final result = await hopRp.postSuaLichHop(taoLichHopRequest);

    result.when(
      success: (value) {},
      error: (error) {},
    );

    showContent();
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

  TaoPhienHopRepuest taoPhienHopRepuest = TaoPhienHopRepuest();

  List<MoiHopRequest> moiHopRequest = [];

  bool phuongThucNhan = false;

  void dispose() {}
}

///Chương Trình họp
extension ChuongTrinhHop on DetailMeetCalenderCubit {
  Future<void> getListPhienHop(String id) async {
    final result = await hopRp.getDanhSachPhienHop(id);
    result.when(
        success: (res) {
          danhSachChuongTrinhHop.sink.add(res);
        },
        error: (error) {});
  }

  Future<void> getDanhSachNguoiChuTriPhienHop(String id) async {
    final result = await hopRp.getDanhSachNguoiChuTriPhienHop(id);
    result.when(
        success: (res) {
          listNguoiCHuTriModel.sink.add(res);
        },
        error: (error) {});
  }

  Future<void> getThemPhienHop(String id) async {
    final result = await hopRp.getThemPhienHop(id, taoPhienHopRepuest);
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
}

///kết luận hop
extension KetLuanHop on DetailMeetCalenderCubit {
  Future<void> getXemKetLuanHop(String id) async {
    final result = await hopRp.getXemKetLuanHop(id);
    result.when(success: (res) {
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
    }, error: (err) {
      print('lỗi kết luận họp');
    });
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
      success: (value) {
        messageSubject.add(value);
      },
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
        error: (error) {});
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
}

///Y kien cuoc hop
extension YKienCuocHop on DetailMeetCalenderCubit {
  Future<void> getDanhSachYKien(String id) async {
    final result = await hopRp.getDanhSachYKien(id);
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
  }) async {
    showLoading();
    final ThemYKienRequest themYKienRequest = ThemYKienRequest(
      content: yKien,
      scheduleId: idLichHop,
      scheduleOpinionId: scheduleOpinionId,
    );
    final result = await hopRp.themYKienHop(themYKienRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }
}
