import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/edit_person_information/edit_person_information_request.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/edit_personal_information/data_edit_person_information.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/debouncer.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_state.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/pick_image_extension.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class ManagerPersonalInformationCubit
    extends BaseCubit<ManagerPersonalInformationState> {
  ManagerPersonalInformationCubit() : super(BaseChooseTimeInitial());

  EditPersonInformationRequest editPersonInformationRequest =
      EditPersonInformationRequest();
  Debouncer debouncer = Debouncer();
  final BehaviorSubject<ModelAnh> avatarPathSubject = BehaviorSubject();
  final BehaviorSubject<ModelAnh> chuKyPathSubject = BehaviorSubject();
  final BehaviorSubject<ModelAnh> kyNhayPathSubject = BehaviorSubject();
  final BehaviorSubject<bool> isCheckTinhSubject = BehaviorSubject();
  final BehaviorSubject<File> saveFile = BehaviorSubject();
  final BehaviorSubject<ManagerPersonalInformationModel> managerPersonSubject =
      BehaviorSubject();
  final BehaviorSubject<bool> isCheckHuyenSubject = BehaviorSubject();
  final BehaviorSubject<DataEditPersonInformation> dataEditSubject =
      BehaviorSubject();

  final BehaviorSubject<List<TinhHuyenXaModel>> tinhSubject =
      BehaviorSubject.seeded(
    [],
  );
  final BehaviorSubject<List<TinhHuyenXaModel>> huyenSubject =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<String> isCheckRadioButton = BehaviorSubject();
  final BehaviorSubject<bool> isCheckButtonReset = BehaviorSubject.seeded(true);
  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();
  final BehaviorSubject<List<TinhHuyenXaModel>> xaSubject =
      BehaviorSubject.seeded([]);
  final isCheckRegex = RegExp(r'^[0-9]{0,2}$');
  final isCheckCccd = RegExp(r'^[0-9]{0,255}$');

  Stream<ManagerPersonalInformationModel> get managerStream =>
      managerPersonSubject.stream;

  Stream<File> get saveFileStream => saveFile.stream;

  Stream<bool> get isCheckTinhStream => isCheckTinhSubject.stream;

  Stream<bool> get isCheckHuyenStream => isCheckHuyenSubject.stream;

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  Stream<List<TinhHuyenXaModel>> get huyenStream => huyenSubject.stream;

  Stream<List<TinhHuyenXaModel>> get xaStream => xaSubject.stream;

  Stream<List<TinhHuyenXaModel>> get tinhStream => tinhSubject.stream;
  String ngaySinh = '';
  String tinh = '';
  String huyen = '';
  String idTinh = '';
  String idHuyen = '';
  String idXa = '';
  String thuTu = '';
  String xa = '';
  bool gioiTinh = false;
  String identifier = '';
  DataEditPersonInformation dataEditPersonInformation =
      DataEditPersonInformation();
  List<TinhHuyenXaModel> huyenModel = [];
  List<TinhHuyenXaModel> tinhModel = [];
  List<TinhHuyenXaModel> xaModel = [];
  ManagerPersonalInformationModel managerPersonalInformationModel =
      ManagerPersonalInformationModel();

  AccountRepository get _managerRepo => Get.find();
  bool isChechValidate = false;

  String checkThuTu(String? thuTu) {
    if (thuTu == null || thuTu == '') {
      return '';
    }
    return thuTu;
  }

  Future<void> getInfo({
    String id = '',
  }) async {
    final result = await _managerRepo.getInfo(id);
    result.when(
      success: (res) {
        managerPersonalInformationModel = res;
        if (res.tinhId != null) {
          getDataHuyenXa(
            parentId: res.tinhId ?? '',
            isXa: false,
          );
        }
        if (res.huyenId != null) {
          getDataHuyenXa(
            isXa: true,
            parentId: res.huyenId ?? '',
          );
        }
        managerPersonSubject.sink.add(managerPersonalInformationModel);
      },
      error: (error) {},
    );
  }

  Future<void> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        final data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {}
  }

  Future<void> getDataTinh() async {
    final result = await _managerRepo.getData();
    result.when(
      success: (res) {
        tinhModel = res;
        tinhSubject.sink.add(tinhModel);
      },
      error: (error) {},
    );
  }

  Future<void> getDataHuyenXa({
    String parentId = '',
    required bool isXa,
  }) async {
    final result = await _managerRepo.getDataChild(parentId);
    result.when(
      success: (res) {
        if (isXa) {
          xaModel = res;
          xaSubject.sink.add(xaModel);
        } else {
          huyenModel = res;
          huyenSubject.sink.add(huyenModel);
        }
      },
      error: (error) {},
    );
  }

  Future<void> getEditPerson({
    String id = '',
    String maCanBo = '',
    String name = '',
    String sdtCoQuan = '',
    String sdt = '',
    String email = '',
    bool gioitinh = true,
    String ngaySinh = '',
    String cmnt = '',
    String diaChiLienHe = '',
    DonViDetail? donViDetail,
    String? thuTu = '',
    String tinh = '',
    String huyen = '',
    String xa = '',
    String idTinh = '',
    String idHuyen = '',
    String idXa = '',
    String? iDDonViHoatDong,
  }) async {
    final EditPersonInformationRequest editPerson =
        EditPersonInformationRequest(
      id: id,
      maCanBo: maCanBo,
      hoTen: name,
      phoneDiDong: sdt,
      phoneCoQuan: sdtCoQuan,
      phoneNhaRieng: '',
      email: email,
      gioiTinh: gioitinh,
      ngaySinh: DateTime.parse(ngaySinh).formatApiSS,
      userName: '',
      userId: '',
      iDDonViHoatDong: '00000000-0000-0000-0000-000000000000',
      cmtnd: cmnt,
      anhDaiDienFilePath: '',
      anhChuKyFilePath: '',
      anhChuKyNhayFilePath: '',
      bitChuyenCongTac: false,
      thoiGianCapNhat: '',
      bitNhanTinBuonEmail: false,
      bitNhanTinBuonSMS: false,
      bitDanhBa: false,
      chucVu: '',
      donVi: '',
      bitThuTruongDonVi: false,
      bitDauMoiPAKN: true,
      diaChi: diaChiLienHe,
      donViDetail: donViDetail,
      chucVuDetail: '',
      nhomChucVuDetail: '',
      thuTu: thuTu,
      iThuTu: 0,
      tinh: tinh,
      huyen: huyen,
      xa: xa,
      tinhId: idTinh,
      huyenId: idHuyen,
      xaId: idXa,
      departments: editPersonInformationRequest.departments,
      userAccounts: editPersonInformationRequest.userAccounts,
      lsCanBoKiemNhiemResponse: [],
    );
    final result = await _managerRepo.getEditPerson(editPerson);
    result.when(
      success: (res) {
        dataEditPersonInformation = res;
        dataEditSubject.sink.add(dataEditPersonInformation);
      },
      error: (error) {},
    );
  }

  //
  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
  }

  Future<void> getCurrentUnit(
    ManagerPersonalInformationModel managerPersonalInformationModel,
  ) async {
    this.managerPersonalInformationModel = managerPersonalInformationModel;
    ngaySinh = managerPersonalInformationModel.ngaySinh ?? '';
    gioiTinh = managerPersonalInformationModel.gioiTinh ?? false;
    tinh = managerPersonalInformationModel.tinh ?? '';
    huyen = managerPersonalInformationModel.huyen ?? '';
    xa = managerPersonalInformationModel.xa ?? '';
    idTinh = managerPersonalInformationModel.tinhId ?? '';
    idHuyen = managerPersonalInformationModel.huyenId ?? '';
    idXa = managerPersonalInformationModel.xaId ?? '';
  }

  Future<void> loadApi({String id = ''}) async {
    final queue = Queue(parallel: 4);

    showLoading();
    unawaited(queue.add(() => getInfo(id: id)));
    await queue.add(() => getDataTinh());
    await queue.onComplete;
    showContent();
    queue.dispose();
  }

  Future<void> selectGTEvent(bool gioiTinh) async {
    this.gioiTinh = gioiTinh;
  }

  Future<void> selectBirthdayEvent(String birthday) async {
    ngaySinh = birthday;
  }

  Future<void> uploadImage({required File xFile}) async {
    saveFile.sink.add(xFile);
  }

  List<String> fakeDataGioiTinh = [
    'Nam',
    'Nữ',
  ];

  void dispose() {}
}
