import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/history_detail_document.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/cong_tac_chuan_bi_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_nhiem_vu_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/handing_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/ket_luan_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thanh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  HopRepository get hopRp => Get.find();
  bool check = false;
  int danhSachphatBieu = 1;
  int choDuyet = 2;
  int daDuyet = 3;
  int huyDuyet = 4;
  List<String> dataThuhoi = ['thu hoi', 'thu hồi'];
  List<String> dataBocBang = ['boc bang', 'boc bang2'];
  List<String> dataThemYkien = ['cuộc họp 1', 'cuộc họp 2'];

  //

  BehaviorSubject<MessageModel> messageSubject = BehaviorSubject();

  Stream<MessageModel> get messageStream => messageSubject.stream;

  BehaviorSubject<List<MoiHopModel>> listMoiHopSubject = BehaviorSubject();

  Stream<List<MoiHopModel>> get listMoiHopStream => listMoiHopSubject.stream;

  BehaviorSubject<ChiTietLichHopModel> chiTietLichLamViecSubject =
      BehaviorSubject();

  BehaviorSubject<ChuongTrinhHopModel> danhSachCanBoTPTGSubject =
      BehaviorSubject();

  BehaviorSubject<DanhSachPhatBieuLichHopModel>
      danhSachPhatbieuLichHopModelSubject = BehaviorSubject();

  Stream<DanhSachPhatBieuLichHopModel> get danhSachPhatbieuLichHopStream =>
      danhSachPhatbieuLichHopModelSubject.stream;

  final BehaviorSubject<String> _themBieuQuyet = BehaviorSubject<String>();

  Stream<String> get themBieuQuyet => _themBieuQuyet.stream;

  Stream<ChiTietLichHopModel> get chiTietLichLamViecStream =>
      chiTietLichLamViecSubject.stream;

  Stream<ChuongTrinhHopModel> get danhSachCanBoTPTGStream =>
      danhSachCanBoTPTGSubject.stream;

  final BehaviorSubject<ThongTinPhongHopModel?> _getThongTinPhongHop =
      BehaviorSubject<ThongTinPhongHopModel?>();

  Stream<ThongTinPhongHopModel?> get getThongTinPhongHop =>
      _getThongTinPhongHop.stream;
  final BehaviorSubject<List<ThietBiPhongHopModel>> _getListThietBiPhongHop =
      BehaviorSubject<List<ThietBiPhongHopModel>>();

  Stream<List<ThietBiPhongHopModel>> get getListThietBi =>
      _getListThietBiPhongHop.stream;

  List<String> cacLuaChonBieuQuyet = [];

  String id = '';
  List<LoaiSelectModel> listLoaiHop = [];

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  Future<void> initData(String id) async {
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
    final queue = Queue(parallel: 2);
    unawaited(queue.add(() => getThongTinPhongHopApi()));
    unawaited(queue.add(() => getDanhSachThietBi()));
    await queue.onComplete.catchError((er) {});
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

  Future<void> suaKetLuan({
    required String scheduleId,
    required String content,
    required String reportStatusId,
    required String reportTemplateId,
    required List<File> files,
  }) async {
    final result = await hopRp.suaKetLuan(
      scheduleId,
      content,
      reportStatusId,
      reportTemplateId,
      files,
    );

    result.when(
      success: (value) {
        messageSubject.add(value);
      },
      error: (error) {},
    );
  }

<<<<<<< HEAD
  void getID() {
=======
  void getDanhSachPhatBieu() {
>>>>>>> develop
    getDanhSachPhatBieuLichHop(id);
    getDanhSachBieuQuyetLichHop(id);
  }

  Future<void> getDanhSachPhatBieuLichHop(String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(lichHopId);
    result.when(
        success: (res) {
          List<PhatBieuModel> phatBieu = res.toList();
          phatbieu.sink.add(phatBieu);
        },
        error: (err) {});
  }

  Future<void> getDanhSachBieuQuyetLichHop(String id) async {
    final result = await hopRp.getDanhSachBieuQuyetLichHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  Future<void> danhSachCanBoTPTG({required String id}) async {
    final result = await hopRp.getDanhSachCanBoTPTG(id);

    result.when(
      success: (value) {
        danhSachCanBoTPTGSubject.add(value);
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
    final result = await hopRp.getListThongTinPhongHop(id);
    result.when(
      success: (res) {
        _getThongTinPhongHop.sink.add(res);
      },
      error: (err) {},
    );
  }

  Future<void> getDanhSachThietBi() async {
    final result = await hopRp.getListThietBiPhongHop(id);
    result.when(
        success: (res) {
          _getListThietBiPhongHop.sink.add(res);
        },
        error: (err) {});
  }

  Future<void> getTongPhienHop() async {
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> selectPhienHop() async {
    final result = await hopRp.getTongPhienHop(id);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> themYKien() async {
    ThemYKienRequest themYKienRequest =
        ThemYKienRequest(content: 'them y kien', scheduleId: id);
    final result = await hopRp.themYKienHop(themYKienRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> sendMailKetLuatHop() async {
    final result = await hopRp.sendMailKetLuanHop(id);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> themBieuQuyetHop() async {
    final BieuQuyetRequest bieuQuyetRequest = BieuQuyetRequest(
        dateStart: '01/01/1900',
        lichHopId: id,
        loaiBieuQuyet: false,
        noiDung: 'noi dung',
        quyenBieuQuyet: true,
        thoiGianBatDau: '1900-01-01T09:55',
        thoiGianKetThuc: '1900-01-01T10:30',
        trangThai: 0,
        danhSachLuaChon: [
          DanhSachLuaChon(
            tenLuaChon: 'gio tay',
            mauBieuQuyet: 'primary',
          )
        ],
        danhSachThanhPhanThamGia: [
          DanhSachThanhPhanThamGia(
            canBoId: '39227131-3db7-48f8-a1b2-57697430cc69',
            donViId: '0bf3b2c3-76d7-4e05-a587-9165c3624d76',
            idPhienhopCanbo: '904c6a02-1540-4768-8b72-db8aa3aabb8d',
          )
        ]);
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
    bool isListCanBo(ThanhPhanThamGiaModel canBo) {
      return canBo.tebCanBo!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value =
        dataThanhPhanThamGia.where((element) => isListCanBo(element)).toList();
    thanhPhanThamGia.sink.add(value);
  }

  BehaviorSubject<List<ThanhPhanThamGiaModel>> thanhPhanThamGia =
      BehaviorSubject<List<ThanhPhanThamGiaModel>>();

  Stream<List<ThanhPhanThamGiaModel>> get streamthanhPhanThamGia =>
      thanhPhanThamGia.stream;

  final BehaviorSubject<bool> checkBoxCheck = BehaviorSubject();

  Stream<bool> get checkBoxCheckBool => checkBoxCheck.stream;

  void checkBoxButton() {
    checkBoxCheck.sink.add(check);
  }

  List<String> selectedIds = [];
<<<<<<< HEAD

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
      log('LEN : ${selectedIds.length}');
    }
    List<ThanhPhanThamGiaModel> _tempList = [];
    if (thanhPhanThamGia.hasValue) {
      _tempList = thanhPhanThamGia.value;
    } else {
      _tempList = dataThanhPhanThamGia;
    }
    thanhPhanThamGia.sink.add(_tempList);
  }

  void validateCheckAll() {
    check = selectedIds.length == dataThanhPhanThamGia.length;
    log(check.toString());
    checkBoxCheck.sink.add(check);
  }

  List<ThanhPhanThamGiaModel> dataThanhPhanThamGia = [];

  List<String> dataDropdown = ['1', '2', '3'];

=======

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
      log('LEN : ${selectedIds.length}');
    }
    List<ThanhPhanThamGiaModel> _tempList = [];
    if (thanhPhanThamGia.hasValue) {
      _tempList = thanhPhanThamGia.value;
    } else {
      _tempList = dataThanhPhanThamGia;
    }
    thanhPhanThamGia.sink.add(_tempList);
  }

  void validateCheckAll() {
    check = selectedIds.length == dataThanhPhanThamGia.length;
    log(check.toString());
    checkBoxCheck.sink.add(check);
  }

  List<ThanhPhanThamGiaModel> dataThanhPhanThamGia = [];

  List<String> dataDropdown = ['1', '2', '3'];

>>>>>>> develop
  BehaviorSubject<List<PhatBieuModel>> phatbieu =
      BehaviorSubject<List<PhatBieuModel>>();

  Stream<List<PhatBieuModel>> get streamPhatBieu => phatbieu.stream;

  BehaviorSubject<List<PhatBieuModel>> bieuQuyet =
      BehaviorSubject<List<PhatBieuModel>>();

  Stream<List<PhatBieuModel>> get streamBieuQuyet => bieuQuyet.stream;

  List<PhatBieuModel> listBieuQuyet = [];

  final BehaviorSubject<int> typeStatus = BehaviorSubject.seeded(1);

  Stream<int> get getTypeStatus => typeStatus.stream;

  void getValueStatus(int value) {
    if (value == choDuyet) {
    } else if (value == daDuyet) {
    } else if (value == huyDuyet) {
    } else {}
    typeStatus.sink.add(value);
    print(value);
  }

  void changeType(int value) {
    if (value == 1) {}
  }

  SoLuongPhatBieuModel dataSoLuongPhatBieu = SoLuongPhatBieuModel();

<<<<<<< HEAD
  Future<void> soLuongPhatBieuData({required String id}) async {
=======
  Future<void> soLuongPhatBieuData() async {
>>>>>>> develop
    final result = await hopRp.getSoLuongPhatBieu(id);
    result.when(
        success: (res) {
          dataSoLuongPhatBieu.danhSachPhatBieu = res.danhSachPhatBieu;
          dataSoLuongPhatBieu.choDuyet = res.choDuyet;
          dataSoLuongPhatBieu.daDuyet = res.daDuyet;
          dataSoLuongPhatBieu.huyDuyet = res.huyDuyet;
        },
<<<<<<< HEAD
        error: (err) {
          print('lỗi số lượng phát biểu');
        });
=======
        error: (err) {});
>>>>>>> develop
  }

  List<PhatBieuModel> listPhatBieu = [];

  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
  }

  TrangThai typeTrangthai(int value) {
    switch (value) {
      case 1:
        return TrangThai.DaDuyet;
      case 2:
        return TrangThai.ChoDuyet;
      case 3:
        return TrangThai.ChuaGuiDuyet;
      case 4:
        return TrangThai.HuyDuyet;
      default:
        return TrangThai.DaDuyet;
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

  //xem ket luan hop
  Future<void> getXemKetLuanHop(String id) async {
    final result = await hopRp.getXemKetLuanHop(id);
    result.when(
        success: (res) {
          KetLuanHopModel ketLuanHopModel = KetLuanHopModel(
            id: res.id ?? '',
            thoiGian: res.endDate ?? '',
            trangThai: typeTrangthai(res.status ?? 0),
            tinhTrang: typeTinhTrang(res.reportStatusCode ?? ''),
            file: res.files ?? '',
          );
          ketLuanHopSubject.sink.add(ketLuanHopModel);
        },
<<<<<<< HEAD
        error: (err) {
          KetLuanHopModel ketLuanHopModel = KetLuanHopModel(
            id: '',
            thoiGian: '',
            trangThai: typeTrangthai(0),
            tinhTrang: typeTinhTrang(''),
            file: '',
          );
          ketLuanHopSubject.sink.add(ketLuanHopModel);
          print('aaaaaaaaaaaaaaaaaaaaaaaa looi ket luan hop');
        });
=======
        error: (err) {});
>>>>>>> develop
  }

  BehaviorSubject<KetLuanHopModel> ketLuanHopSubject = BehaviorSubject();

  Stream<KetLuanHopModel> get ketLuanHopStream => ketLuanHopSubject.stream;

  BehaviorSubject<DanhSachNhiemVuLichHopModel> danhSachNhiemVuLichHopSubject =
      BehaviorSubject();

  Stream<DanhSachNhiemVuLichHopModel> get streamDanhSachNhiemVuLichHop =>
      danhSachNhiemVuLichHopSubject.stream;

  HandingCommentLichHop handingCommentLichHop = HandingCommentLichHop.emty();

  void dispose() {}
}

///Chương Trình họp
extension ChuongTrinhHop on DetailMeetCalenderCubit {
  Future<void> getListPhienHop() async {
    final result = await hopRp.getDanhSachPhienHop(id);
  }
}
