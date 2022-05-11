import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/account/change_pass_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/change_password/bloc/change_password_state.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/show_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool? isSuccess;
  final toast = FToast();

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
        if(model.isSuccess==false){
          toast.showToast(
            child: ShowToast(
              text: S.current.mat_khau_hien_tai_chua_dung,
            ),
            gravity: ToastGravity.BOTTOM,
          );
        }
        showContent();
      },
      error: (err) {
      },
    );
  }
}
