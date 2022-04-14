import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/account/change_pass_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

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
  bool isSuccess=false;

  void closeDialog() {
    showContent();
  }

  BehaviorSubject<ChangePassModel> changePassSubject = BehaviorSubject();
  ChangePassModel model = ChangePassModel();

  Future<void> changePassWord({
    required String passwordOld,
    required String password,
    required String repeatPassword,
  }) async {
    showLoading();
    final result = await _loginRepo.changePass(
      passwordOld,
      password,
      repeatPassword,
    );
    result.when(
      success: (res) {
        model = res;
        changePassSubject.sink.add(model);
        isSuccess=model.isSuccess??false;
        message = model.messages?.first ?? '';
        showContent();
      },
      error: (err) {
      },
    );
  }
}
