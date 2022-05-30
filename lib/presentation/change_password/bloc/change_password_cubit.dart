import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_state.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class ChangePasswordCubit extends BaseCubit<ChangePassWordState> {
  ChangePasswordCubit() : super(ChangePassWordStateIntial());

  AccountRepository get _loginRepo => Get.find();

  bool isCheckEye = true;
  bool isCheckEye1 = true;
  bool isCheckEye2 = true;
  bool isHideEye = false;
  bool isHideEye1 = false;
  bool isHideEye2 = false;
  String message = '';
  bool? isSuccess;
  final toast = FToast();
  BehaviorSubject<String> thongBao = BehaviorSubject();

  void closeDialog() {
    showContent();
  }

  Future<void> changePassWord({
    required String passwordOld,
    required String password,
    required String repeatPassword,
    required BuildContext context,
  }) async {
    showLoading();
    final result = await _loginRepo.changePass(
      passwordOld,
      password,
      repeatPassword,
    );
    result.when(
      success: (res) {
        isSuccess = true;
        showContent();
      },
      error: (err) {
        thongBao.sink.add('');
        if (err is NoNetworkException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        } else if (err.code == 400) {
          if (err.message.contains(S.current.sai_tai_khoan_hoac_mat_khau)) {
            thongBao.sink.add(err.message);
          } else {
            MessageConfig.show(
              messState: MessState.customIcon,
              title: err.message,
              urlIcon: ImageAssets.icUserNotExits,
            );
            Navigator.pop(context);
            AppStateCt.of(context).appState.setToken('');
            HiveLocal.clearData();
          }
        } else {
          thongBao.sink.add(err.message);
        }
        showContent();
      },
    );
  }
}
