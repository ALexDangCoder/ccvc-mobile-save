import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/forgot_password/bloc/forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPassWordState> {
  ForgotPasswordCubit() : super(ForgotPassWordStateIntial());
  bool isCheckEye=false;
  bool isCheckEye1=false;
  bool isCheckEye2=false;
  bool isHideEye=false;
  bool isHideEye1=false;
  bool isHideEye2=false;

  validateInputText(String inputText) {
    if (inputText.isEmpty) {
      return S.current.khong_the_bo_trong;
    }
    return;
  }
}
