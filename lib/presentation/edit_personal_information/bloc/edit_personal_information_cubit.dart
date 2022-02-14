import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/edit_personal_information_state.dart';
import 'package:rxdart/rxdart.dart';

class EditPersonalInformationCubit
    extends BaseCubit<EditPersonalInformationState> {
  EditPersonalInformationCubit() : super(EditPersonalInformationInitial());
  BehaviorSubject<File> saveFile = BehaviorSubject();

  Stream<File> get saveFileStream => saveFile.stream;
  BehaviorSubject<bool> isCheckTinhSubject = BehaviorSubject();

  Stream<bool> get isCheckTinhStream => isCheckTinhSubject.stream;

  BehaviorSubject<bool> isCheckHuyenSubject = BehaviorSubject();

  Stream<bool> get isCheckHuyenStream => isCheckHuyenSubject.stream;
  String ngaySinh = '';
  String tinh = '';
  String huyen = '';
  String xa = '';
  bool gioiTinh = false;
  ManagerPersonalInformationModel managerPersonalInformationModel =
      ManagerPersonalInformationModel();
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

  void dispose() {}
}
