import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/edit_person_information/edit_person_information_request.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/edit_personal_information/data_edit_person_information.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_state.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class ManagerPersonalInformationCubit
    extends BaseCubit<ManagerPersonalInformationState> {
  ManagerPersonalInformationCubit() : super(BaseChooseTimeInitial());

  BehaviorSubject<ManagerPersonalInformationModel> managerPersonSubject =
      BehaviorSubject();

  Stream<ManagerPersonalInformationModel> get managerStream =>
      managerPersonSubject.stream;
  EditPersonInformationRequest editPersonInformationRequest =
      EditPersonInformationRequest();

//tinh huyen sss
  BehaviorSubject<List<TinhHuyenXaModel>> tinhSubject = BehaviorSubject.seeded(
    [],
  );

  List<TinhHuyenXaModel> tinhModel = [];

  Stream<List<TinhHuyenXaModel>> get tinhStream => tinhSubject.stream;

  AccountRepository get _managerRepo => Get.find();

  //
  ManagerPersonalInformationModel managerPersonalInformationModel =
      ManagerPersonalInformationModel();

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
            parentId:
            res.huyenId ?? '',
          );
        }
        managerPersonSubject.sink.add(managerPersonalInformationModel);
      },
      error: (error) {},
    );
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

  BehaviorSubject<List<TinhHuyenXaModel>> huyenSubject =
      BehaviorSubject.seeded([]);

  Stream<List<TinhHuyenXaModel>> get huyenStream => huyenSubject.stream;
  List<TinhHuyenXaModel> huyenModel = [];

  BehaviorSubject<List<TinhHuyenXaModel>> xaSubject =
      BehaviorSubject.seeded([]);

  Stream<List<TinhHuyenXaModel>> get xaStream => xaSubject.stream;
  List<TinhHuyenXaModel> xaModel = [];

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

  //
  DataEditPersonInformation dataEditPersonInformation =
      DataEditPersonInformation();
  BehaviorSubject<DataEditPersonInformation> dataEditSubject =
      BehaviorSubject();

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
    int thuTu = 0,
    String tinh = '',
    String huyen = '',
    String xa = '',
  }) async {
    final EditPersonInformationRequest editPerson =
        EditPersonInformationRequest(
      id: id,
      maCanBo: maCanBo,
      hoTen: name,
      phoneDiDong: '',
      phoneCoQuan: sdtCoQuan,
      phoneNhaRieng: sdt,
      email: email,
      gioiTinh: gioitinh,
      ngaySinh: DateTime.parse(ngaySinh).formatApiSS,
      userName: '',
      userId: '',
      iDDonViHoatDong: '',
      cmtnd: cmnt,
      anhDaiDienFilePath: '',
      anhChuKyFilePath: '',
      anhChuKyNhayFilePath: '',
      bitChuyenCongTac: true,
      thoiGianCapNhat: '',
      bitNhanTinBuonEmail: true,
      bitNhanTinBuonSMS: true,
      bitDanhBa: true,
      chucVu: '',
      donVi: '',
      bitThuTruongDonVi: true,
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
      tinhId: '',
      huyenId: '',
      xaId: '',
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
  BehaviorSubject<File> saveFile = BehaviorSubject();

  final BehaviorSubject<String> avatarPathSubject = BehaviorSubject();
  final BehaviorSubject<String> chuKyPathSubject = BehaviorSubject();
  final BehaviorSubject<String> kyNhayPathSubject = BehaviorSubject();

  Stream<File> get saveFileStream => saveFile.stream;
  BehaviorSubject<bool> isCheckTinhSubject = BehaviorSubject();

  Stream<bool> get isCheckTinhStream => isCheckTinhSubject.stream;

  BehaviorSubject<bool> isCheckHuyenSubject = BehaviorSubject();

  Stream<bool> get isCheckHuyenStream => isCheckHuyenSubject.stream;

  final BehaviorSubject<WidgetType?> _showDialogSetting =
      BehaviorSubject<WidgetType?>();

  Stream<WidgetType?> get showDialogSetting => _showDialogSetting.stream;

  String ngaySinh = '';
  String tinh = '';
  String huyen = '';
  String xa = '';
  bool gioiTinh = false;
  final BehaviorSubject<int> _checkRadioSubject = BehaviorSubject();

  Stream<int> get checkRadioStream => _checkRadioSubject.stream;

  BehaviorSubject<String> isCheckRadioButton = BehaviorSubject();
  BehaviorSubject<bool> isCheckButtonReset = BehaviorSubject.seeded(true);

  void checkRadioButton(int _index) {
    _checkRadioSubject.sink.add(_index);
  }

  Future<void> getCurrentUnit(
    ManagerPersonalInformationModel managerPersonalInformationModel,
  ) async {
    this.managerPersonalInformationModel = managerPersonalInformationModel;
    gioiTinh = managerPersonalInformationModel.gioiTinh ?? false;
    tinh = managerPersonalInformationModel.tinh ?? '';
    huyen = managerPersonalInformationModel.huyen ?? '';
    xa = managerPersonalInformationModel.xa ?? '';
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
    // File file = File();

    saveFile.sink.add(xFile);
  }

  void showDialog(WidgetType type) {
    if (_showDialogSetting.hasValue) {
      if (_showDialogSetting.value == type) {
        closeDialog();
      } else {
        _showDialogSetting.add(type);
      }
    } else {
      _showDialogSetting.add(type);
    }
  }

  void closeDialog() {
    _showDialogSetting.add(null);
  }

  List<String> fakeDataGioiTinh = [
    'Nam',
    'Nữ',
  ];

  void dispose() {
    _showDialogSetting.close();
  }
}
