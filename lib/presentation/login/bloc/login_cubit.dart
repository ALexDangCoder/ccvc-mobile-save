import 'dart:async';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/login_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_state.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:local_auth/local_auth.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginStateIntial());

  AccountRepository get _loginRepo => Get.find();

  bool isHideClearData = false;
  bool isCheckEye1 = true;
  bool isHideEye1 = false;
  bool passIsError = false;
  final toast = FToast();

  bool? getEmail(String text) {
    int result = text.indexOf('@');
    if ((result >= 64)) {
      toast.showToast(
        child: ShowToast(
          text: S.current.nhap_sai_dinh_dang,
        ),
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else {
      return true;
    }
  }

  void closeDialog() {
    showContent();
  }

  Future<void> loginAndSaveinfo({
    required String userName,
    required String passWord,
    required String appCode,
  }) async {
    showLoading();
    final result = await _loginRepo.login(userName, passWord, appCode);
    result.when(
      success: (res) {
        final LoginModel token = LoginModel(
          refreshToken: res.dataUser?.refreshToken,
          accessToken: res.dataUser?.accessToken,
        );
        emit(LoginSuccess(token: token.accessToken ?? ''));
        PrefsService.saveRefreshToken(token.refreshToken ?? '');
        PrefsService.saveLoginUserName(userName);
        PrefsService.saveLoginPassWord(passWord);
        final DataUser dataUser = DataUser(
          userId: res.dataUser?.userId,
          username: res.dataUser?.username,
          userInformation: res.dataUser?.userInformation,
        );

        HiveLocal.saveDataUser(dataUser);
      },
      error: (err) {
        if (err.code == 401) {
          toast.showToast(
            child: ShowToast(
              text: S.current.sai_tai_khoan_hoac_mat_khau,
            ),
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          toast.showToast(
            child: ShowToast(
              text: S.current.dang_nhap_khong_thanh_cong,
            ),
            gravity: ToastGravity.BOTTOM,
          );
        }
        emit(LoginError(err.message));
        showContent();
      },
    );
  }

  Future<void> getPermission() async {
    showLoading();
    final permissionResult = await _loginRepo.getListPermissionApp();
    await permissionResult.when(
      success: (res) async {
        await HiveLocal.savePermission(res);
        showContent();
      },
      error: (err) {
        showContent();
      },
    );
  }

  var localAuth = LocalAuthentication();

  Future<void> checkBiometrics() async {
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face) ||
          availableBiometrics.contains(BiometricType.fingerprint)) {
        final authenticated = await localAuth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            useErrorDialogs: false,
            biometricOnly: true);
        if (authenticated) {
          await loginAndSaveinfo(
            userName: PrefsService.getLoginUserName(),
            passWord: PrefsService.getLoginPassWord(),
            appCode: APP_CODE,
          );
        } else {}
      }
    }
  }
}
