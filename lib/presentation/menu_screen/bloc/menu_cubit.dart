import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';

import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_state.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/fake_date_menu.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MenuCubit extends BaseCubit<MenuState> {
  MenuCubit() : super(MainStateInitial());
  final BehaviorSubject<UserInformationModel> _getInforUser =
      BehaviorSubject<UserInformationModel>();

  Stream<UserInformationModel> get getInforUser => _getInforUser.stream;
  AccountRepository get accountRp => Get.find();
  String id = '';
  Future<void> getUser() async {
    final data = HiveLocal.getDataUser();
    if (data != null) {
      id = data.userInformation?.id ?? '';
    }
    String hoTen = '';
    String phamViTxt = '';
    String anhDaiDien = '';
    showLoading();
    final result = await accountRp.getInfo(id);
    final phamVi = await accountRp.getPhamVi();
    result.when(
        success: (res) {
          hoTen = res.hoTen ?? '';
          anhDaiDien = res.anhDaiDienFilePath ?? '';
        },
        error: (err) {});
    phamVi.when(
        success: (res) {
          phamViTxt = res.chucVu;
        },
        error: (err) {});
    showContent();
    _getInforUser.sink.add(UserInformationModel(
        hoTen: hoTen, chucVu: phamViTxt, anhDaiDienFilePath: anhDaiDien));
  }
  Future<void> refeshUser() async {
    String hoTen = '';
    String phamViTxt = '';
    String anhDaiDien = '';
    final result = await accountRp.getInfo(id);
    final phamVi = await accountRp.getPhamVi();
    result.when(
        success: (res) {
          hoTen = res.hoTen ?? '';
          anhDaiDien = res.anhDaiDienFilePath ?? '';
        },
        error: (err) {});
    phamVi.when(
        success: (res) {
          phamViTxt = res.chucVu;
        },
        error: (err) {});

    _getInforUser.sink.add(UserInformationModel(
        hoTen: hoTen, chucVu: phamViTxt, anhDaiDienFilePath: anhDaiDien));
  }
}
