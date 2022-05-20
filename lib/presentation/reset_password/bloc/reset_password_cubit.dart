import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/reset_password/bloc/reset_password_state.dart';

class ResetPasswordCubit extends BaseCubit<ResetPassWordState> {
  ResetPasswordCubit() : super(ResetPassWordStateIntial());
 String? confirmPass;


  validateInputText(String inputText) {
    if (inputText.isEmpty) {
      return S.current.khong_the_bo_trong;
    }
    return ;
  }
}
