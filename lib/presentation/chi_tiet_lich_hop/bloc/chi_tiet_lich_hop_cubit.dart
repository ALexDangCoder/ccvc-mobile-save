import 'dart:io';
import 'package:ccvc_mobile/config/base/base_cubit.dart';

import 'package:ccvc_mobile/data/request/lich_hop/category_list_request.dart';

import 'package:ccvc_mobile/data/request/lich_hop/kien_nghi_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_tin_phong_hop_model.dart';

import 'package:ccvc_mobile/data/request/lich_hop/moi_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/them_y_kien_hop_request.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_phat_bieu_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/moi_hop.dart';

import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DetailMeetCalenderCubit extends BaseCubit<DetailMeetCalenderState> {
  DetailMeetCalenderCubit() : super(DetailMeetCalenderInitial());

  HopRepository get hopRp => Get.find();

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

  final BehaviorSubject<ThongTinPhongHopModel> _getThongTinPhongHop =
      BehaviorSubject<ThongTinPhongHopModel>();

  Stream<ThongTinPhongHopModel> get getThongTinPhongHop =>
      _getThongTinPhongHop.stream;
  final BehaviorSubject<List<ThietBiPhongHopModel>> _getListThietBiPhongHop =
      BehaviorSubject<List<ThietBiPhongHopModel>>();

  Stream<List<ThietBiPhongHopModel>> get getListThietBi =>
      _getListThietBiPhongHop.stream;

  List<String> cacLuaChonBieuQuyet = [];

  String id = '434d4166-4732-4a90-b6ff-a783d65d7fd6';
  List<LoaiSelectModel> listLoaiHop = [];

  void addValueToList(String value) {
    cacLuaChonBieuQuyet.add(value);
  }

  void removeTag(String value) {
    cacLuaChonBieuQuyet.remove(value);
  }

  Future<void> initData() async {
    getThongTinPhongHopApi();
    getDanhSachThietBi();
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

  void getDanhSachPhatBieu() {
    getDanhSachPhatBieuLichHop('e908def0-e519-4f3b-b9c7-ef841ef15331');
    getDanhSachBieuQuyetLichHop('e908def0-e519-4f3b-b9c7-ef841ef15331');
  }

  Future<void> getDanhSachPhatBieuLichHop(String lichHopId) async {
    final result = await hopRp.getDanhSachPhatBieuLichHop(lichHopId);
    result.when(success: (res) {}, error: (err) {});
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

  Future<void> soLuongPhatBieuData() async {
    final result =
        await hopRp.getSoLuongPhatBieu('8bbd89ee-57fb-4f41-a6f9-06aa86fa4377');
    result.when(success: (res) {}, error: (err) {});
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
        error: (err) {});
  }

  Future<void> getDanhSachThietBi() async {
    final result = await hopRp.getListThietBiPhongHop(id);
    result.when(
        success: (res) {
          _getListThietBiPhongHop.sink.add(res);
        },
        error: (err) {});
  }

  // xem ket luan hop
  Future<void> getXemKetLuanHop() async {
    final result = await hopRp.getXemKetLuanHop(id);
    result.when(success: (res) {}, error: (err) {});
  }
  // danh sach ket luan hop
  Future<void> getDanhSachKetLuanHop() async {
    final result = await hopRp.getDanhSachKetLuanHop(id);
    result.when(success: (res) {}, error: (err) {});
  }

  ListPerSon fakeDataListPerson() {
    ListPerSon fakeDataListPersona = ListPerSon(
      tongSoNguoi: 8,
      soNguoiDongY: 3,
      soNguoiChoXacNhan: 5,
      listPerson: listFake,
    );
    return fakeDataListPersona;
  }

  List<Person> listFake = [
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Nguyễn Minh Hoàng',
      isConnect: true,
      color: Colors.blue,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
    Person(
      name: 'Hoàng Mai Linh',
      isConnect: false,
      color: Colors.red,
    ),
  ];

  List<String> fakeDataDropdown = ['item 1', 'item 2', 'item 3'];
  final HopRepository _hopRepo = Get.find();

  Future<void> getTongPhienHop() async {
    final result =
        await _hopRepo.getTongPhienHop('f6b9aae0-23b1-497d-8096-866c964f2e17');
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> selectPhienHop() async {
    final result =
        await _hopRepo.getTongPhienHop('f6b9aae0-23b1-497d-8096-866c964f2e17');
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  final HopRepository _HopRepo = Get.find();

  Future<void> themYKien() async {
    ThemYKienRequest themYKienRequest = ThemYKienRequest(
        content: 'them y kien',
        scheduleId: 'ab675c7d-fb86-4ec1-806f-5308b0f97af1');
    final result = await _HopRepo.themYKienHop(themYKienRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  Future<void> sendMailKetLuatHop() async {
    final result = await _hopRepo
        .sendMailKetLuanHop('f6b9aae0-23b1-497d-8096-866c964f2e17');
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
        lichHopId: 'ab675c7d-fb86-4ec1-806f-5308b0f97af1',
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
    final result = await _HopRepo.themBieuQuyet(bieuQuyetRequest);
    result.when(
      success: (res) {},
      error: (err) {
        return;
      },
    );
  }

  void dispose() {}
}
