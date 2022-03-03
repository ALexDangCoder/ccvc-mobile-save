import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/forgot_password/bloc/forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPassWordState> {
  ForgotPasswordCubit() : super(ForgotPassWordStateIntial());
  bool isCheckEye = true;
  bool isCheckEye1 = true;
  bool isCheckEye2 = true;
  bool isHideEye = false;
  bool isHideEye1 = false;
  bool isHideEye2 = false;
}
