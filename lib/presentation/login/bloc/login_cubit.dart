import 'dart:async';


import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/login_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';

import 'package:ccvc_mobile/presentation/login/bloc/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginStateIntial());

  AccountRepository get _loginRepo => Get.find();

  bool isHideClearData = false;
  bool isCheckEye1 = true;
  bool isHideEye1 = false;
  bool passIsError = false;

  void closeDialog() {
    showContent();
  }

  Future<void> loginAndSaveinfo({
    required String userName,
    required String passWord,
    required String appCode,
    required BuildContext context,
  }) async {
    showLoading();
    final result = await _loginRepo.login(userName, passWord, appCode);
    result.when(
      success: (res) {
        passIsError = false;
        final LoginModel token = LoginModel(
          refreshToken: res.refreshToken,
          accessToken: res.accessToken,
        );
        emit(LoginSuccess(token: token.accessToken ?? ''));
        PrefsService.saveRefreshToken(token.refreshToken ?? '');
        final DataUser dataUser = DataUser(
          userId: res.userId,
          username: res.username,
          userInformation: res.userInformation,
        );

        HiveLocal.saveDataUser(dataUser);
      },
      error: (err) {
        emit(LoginError(err.message));
        passIsError = true;
      },
    );

  }
  Future<void> getPermission() async {
    showLoading();
    final permissionResult = await _loginRepo.getListPermissionApp();
   await permissionResult.when(
      success: (res)  async {
        await  HiveLocal.savePermission(res);
        showContent();
      },
      error: (err) {
        showContent();
      },
    );

  }
}
