import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/data/request/thong_bao/device_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/login_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/login/bloc/login_state.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginStateIntial());

  AccountRepository get _loginRepo => Get.find();

  ThongBaoRepository get _serviceNoti => Get.find();

  bool isHideClearData = false;
  bool isCheckEye1 = true;
  bool isHideEye1 = false;
  bool passIsError = false;
  final toast = FToast();
  BehaviorSubject<String> thongBao = BehaviorSubject();

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

  Future<String?> getTokken() async {
    final fcmTokken = await FirebaseMessaging.instance.getToken();
    return fcmTokken;
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
        createDevice();
      },
      error: (err) {
        thongBao.sink.add('');
        if (err is NoNetworkException || err is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else if (err.code == StatusCodeConst.STATUS_UNAUTHORIZED) {
          thongBao.sink.add(S.current.sai_tai_khoan_hoac_mat_khau);
        } else if (err.code == StatusCodeConst.STATUS_BAD_REQUEST) {
          if (err.message.contains(S.current.sai_tai_khoan_hoac_mat_khau)) {
            thongBao.sink.add(err.message);
          } else {
            MessageConfig.show(
              messState: MessState.customIcon,
              title: S.current.tai_khoan_hien_khong_ton_tai,
              urlIcon: ImageAssets.icUserNotExits,
            );
          }
        } else {
          thongBao.sink.add(S.current.dang_nhap_khong_thanh_cong);
        }
        emit(LoginError(err.message));
        showContent();
      },
    );
  }

  String get getPlatform => Platform.isAndroid ? DEVICE_ANDROID : DEVICE_IOS;

  Future<String?> get getTokkenNoti => FirebaseMessaging.instance.getToken();

  Future<void> createDevice() async {
    String? deviceId;
    try {
      deviceId = await getTokkenNoti;
      final result = await _serviceNoti.createDevice(
        DeviceRequest(
          isActive: true,
          registationId: deviceId,
          deviceType: getPlatform,
        ),
      );
      result.when(
        success: (success) {},
        error: (error) {},
      );
    } catch (e) {
      deviceId = 'Failed to get deviceId.';
      log(e.toString());
    }
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
  BehaviorSubject<bool> canCheckIsDeviceSupportedSubject =
      BehaviorSubject<bool>.seeded(true);
  bool canCheckIsDeviceSupported = false;

  Future<void> canCheckIsDevice() async {
    canCheckIsDeviceSupported = await localAuth.isDeviceSupported();
    canCheckIsDeviceSupportedSubject.sink.add(canCheckIsDeviceSupported);
  }

  Future<void> checkBiometrics(BuildContext context) async {
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      if(availableBiometrics.isEmpty){
        showDiaLog(
          context,
          title: S.current.thong_bao,
          textContent: S.current.thiet_bi_cua_ban_chua_bat,
          icon: Container(),
          btnRightTxt: S.current.dong,
          isOneButton: false,
          btnLeftTxt: S.current.dong,
          funcBtnRight: () {},
        );
      }
      if (availableBiometrics.isNotEmpty) {
        try {
          if (PrefsService.getOpenFaceId() != '') {
            final authenticated = await localAuth.authenticate(
                localizedReason: 'Please authenticate to show account balance',
              options: const AuthenticationOptions(useErrorDialogs: false,biometricOnly: true)
                );
            if (authenticated) {
              await loginAndSaveinfo(
                userName: PrefsService.getLoginUserName(),
                passWord: PrefsService.getLoginPassWord(),
                appCode: APP_CODE,
              );
            }
          } else {
            showDiaLog(
              context,
              title: S.current.dang_nhap_khong_thanh_cong,
              textContent: S.current.chuc_nang_dang_nhap_bang,
              icon: Container(),
              btnRightTxt: S.current.dong,
              isOneButton: false,
              btnLeftTxt: S.current.dong,
              funcBtnRight: () {},
            );
          }
        } on PlatformException catch (e) {
         if(e.code == auth_error.lockedOut){
            showDiaLog(
              context,
              title: S.current.dang_nhap_khong_thanh_cong,
              textContent: S.current.chuc_nang_dang_nhap_bang,
              icon: Container(),
              btnRightTxt: S.current.dong,
              isOneButton: false,
              btnLeftTxt: S.current.dong,
              funcBtnRight: () {},
            );
          }else if(e.code == auth_error.notEnrolled){
            showDiaLog(
              context,
              title: S.current.thong_bao,
              textContent: S.current.thiet_bi_cua_ban_chua_bat,
              icon: Container(),
              btnRightTxt: S.current.dong,
              isOneButton: false,
              btnLeftTxt: S.current.dong,
              funcBtnRight: () {},
            );
          }else{
           showDiaLog(
             context,
             title: S.current.thong_bao,
             textContent: S.current.thiet_bi_cua_ban_chua_bat,
             icon: Container(),
             btnRightTxt: S.current.dong,
             isOneButton: false,
             btnLeftTxt: S.current.dong,
             funcBtnRight: () {},
           );
         }

        }
      }
    }
  }
}
