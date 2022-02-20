import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/edit_personal_information_state.dart';

class EditPersonalInformationCubit
    extends BaseCubit<EditPersonalInformationState> {
  EditPersonalInformationCubit() : super(EditPersonalInformationInitial());

  void dispose() {}
}
