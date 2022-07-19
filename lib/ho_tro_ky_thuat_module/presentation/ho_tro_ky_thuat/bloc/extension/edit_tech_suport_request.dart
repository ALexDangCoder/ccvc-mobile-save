import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:get/get.dart';

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

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  Future<void> getChiTietHTKTEdit({required String id}) async {
    final result = await _hoTroKyThuatRepository.getSupportDetail(id);
    SupportDetail modelEditHTKT = SupportDetail();
    result.when(
      success: (success) {
        modelEditHTKT = success;
        flagLoadThemMoiYCHT = true;
      },
      error: (error) {
        flagLoadThemMoiYCHT = false;
      },
    );
  }

  // String? getValueAreaDropDown({
  //   required StatusHTKT statusHTKT,
  //   String? id,
  //   bool isArea = true,
  // }) {
  //   if (statusHTKT == StatusHTKT.Create) {
  //     return isArea
  //         ? addTaskHTKTRequest.districtName
  //         : addTaskHTKTRequest.buildingName;
  //   } else {
  //     return findLocationAreaFeatBuilding(
  //       id: id ?? '',
  //       isArea: isArea,
  //     );
  //   }
  // }
}
