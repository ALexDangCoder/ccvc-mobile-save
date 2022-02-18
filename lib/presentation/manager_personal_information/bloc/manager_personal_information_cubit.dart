import 'dart:async';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/model/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/domain/repository/manager_repository.dart';
import 'package:ccvc_mobile/domain/repository/tinh_huyen_xa_repository.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_state.dart';
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

//tinh huyen sss
  BehaviorSubject<List<TinhHuyenXaModel>> tinhSubject = BehaviorSubject.seeded(
    [],
  );
  List<TinhHuyenXaModel> tinhModel = [];

  Stream<List<TinhHuyenXaModel>> get tinhStream => tinhSubject.stream;

  ManagerRepository get _managerRepo => Get.find();

  TinhHuyenXaRepository get _tinhHuyenXaRepo => Get.find();

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
        managerPersonSubject.sink.add(managerPersonalInformationModel);
      },
      error: (error) {},
    );
  }

  Future<void> getDataTinh() async {
    final result = await _tinhHuyenXaRepo.getData();
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
    final result = await _tinhHuyenXaRepo.getDataChild(parentId);
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
    ngaySinh = managerPersonalInformationModel.ngaySinh ?? '';
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

  List<String> fakeDataTinh = [
    'hà nôi',
    'lam loi',
    'phú tho',
    'hà nam',
    'an giang',
    'phúc thọ',
    'bình thuận',
    'phú mỹ',
  ];
  List<String> fakeDataHuyen = [
    'hà nôi',
    'lam loi',
    'phú tho',
    'hà nam',
    'an giang',
    'phúc thọ',
    'bình thuận',
    'phú mỹ',
  ];

  void dispose() {
    _showDialogSetting.close();
  }
}
