import 'package:ccvc_mobile/presentation/edit_personal_information/bloc/pick_media_file.dart';
import 'package:ccvc_mobile/presentation/manager_personal_information/bloc/manager_personal_information_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/map_extension.dart';

extension PickImageExtension on ManagerPersonalInformationCubit {
  Future<String> pickAvatar() async {
    final resultMap = await pickImageFunc(tittle: 'Pick avatar');
    final _path = resultMap.stringValueOrEmpty(PATH_OF_FILE);
    return _path;
  }
}
