import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';

extension EditTechSupportRequest on HoTroKyThuatCubit {
  List<String> getTechSupportValue(List<String> idList) {
    final List<String> issueNameList = [];
    for (final e in idList) {
      final item =
          listLoaiSuCo.value.where((element) => element.id == e).toList().first;
      issueNameList.add(item.name ?? '');
    }
    return issueNameList;
  }
}
