import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/user_infomation_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_state.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MenuCubit extends BaseCubit<MenuState> {
  MenuCubit() : super(MainStateInitial());
  final BehaviorSubject<UserInformationModel> _getInforUser =
      BehaviorSubject<UserInformationModel>();
  final BehaviorSubject<List<MenuType>> _getMenu =
      BehaviorSubject<List<MenuType>>();

  Stream<List<MenuType>> get getMenu => _getMenu.stream;

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
    String ngaySinh = '';
    showLoading();
    unawaited(permissionMenu());
    final result = await accountRp.getInfo(id);
    final phamVi = await accountRp.getPhamVi();
    result.when(
      success: (res) {
        hoTen = res.hoTen ?? '';
        anhDaiDien = res.anhDaiDienFilePath ?? '';
        ngaySinh = res.ngaySinh ?? '';
      },
      error: (err) {},
    );
    phamVi.when(
      success: (res) {
        phamViTxt = res.chucVu;
      },
      error: (err) {},
    );
    showContent();
    _getInforUser.sink.add(UserInformationModel(
        hoTen: hoTen,
        chucVu: phamViTxt,
        anhDaiDienFilePath: anhDaiDien,
        ngaySinh: ngaySinh));
  }

  Future<void> refeshUser() async {
    String hoTen = '';
    String phamViTxt = '';
    String anhDaiDien = '';
    String ngaySinh = '';
    final result = await accountRp.getInfo(id);
    final phamVi = await accountRp.getPhamVi();
    result.when(
      success: (res) {
        hoTen = res.hoTen ?? '';
        anhDaiDien = res.anhDaiDienFilePath ?? '';
        ngaySinh = res.ngaySinh ?? '';
      },
      error: (err) {},
    );
    phamVi.when(
        success: (res) {
          phamViTxt = res.chucVu;
        },
        error: (err) {});

    _getInforUser.sink.add(
      UserInformationModel(
        hoTen: hoTen,
        chucVu: phamViTxt,
        anhDaiDienFilePath: anhDaiDien,
        ngaySinh: ngaySinh,
      ),
    );
  }

  Future<void> permissionMenu() async {
    final result = await accountRp.getPermissionMenu();
    result.when(
        success: (res) {
          final item = <MenuType>[];
          for (final vl in listFeature) {
            if (res.indexWhere((element) => element.menuType == vl) != -1) {
              item.add(vl);
            }
          }
          _getMenu.sink.add(item);
        },
        error: (err) {});
  }
}
