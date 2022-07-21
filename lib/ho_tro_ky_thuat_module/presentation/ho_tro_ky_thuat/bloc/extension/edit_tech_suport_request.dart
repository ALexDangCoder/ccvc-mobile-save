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
    result.when(
      success: (success) {
        modelEditHTKT = success;

        ///start
        editTaskHTKTRequest.buildingId = success.buildingId ?? '';
        editTaskHTKTRequest.districtId = success.districId ?? '';
        editTaskHTKTRequest.id = success.id ?? '';
        editTaskHTKTRequest.room = success.room;
        editTaskHTKTRequest.phone = success.soDienThoai;
        editTaskHTKTRequest.danhSachSuCo =
            success.danhSachSuCo?.map((e) => e.suCoId ?? '').toList();
        editTaskHTKTRequest.buildingName = findNameAreaFeatBuilding(
          id: success.buildingId ?? '',
          isArea: false,
        );
        editTaskHTKTRequest.districtName = findNameAreaFeatBuilding(
          id: success.districId ?? '',
        );
        editTaskHTKTRequest.description = success.moTaSuCo;
        editTaskHTKTRequest.name = success.tenThietBi;
        editTaskHTKTRequest.lstFileId =
            success.filesDinhKem?.map((e) => e.id ?? '').toList();

        ///end
        editModelHTKT.add(success);
        flagLoadEditHTKT = true;
      },
      error: (error) {
        flagLoadEditHTKT = false;
      },
    );
  }
}
