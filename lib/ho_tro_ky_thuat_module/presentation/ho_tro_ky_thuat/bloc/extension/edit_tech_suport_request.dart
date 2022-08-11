import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:get/get.dart';

extension EditTechSupportRequest on HoTroKyThuatCubit {
  void removeFileId(String id) {
    if ((editTaskHTKTRequest.lstFileId ?? []).contains(id)) {
      editTaskHTKTRequest.lstFileId?.remove(id);
    }
  }

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  Future<void> getChiTietHTKTEdit({required String id}) async {
    final result = await _hoTroKyThuatRepository.getSupportDetail(id);
    result.when(
      success: (success) {
        editTaskHTKTRequest.fileUpload = [];
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
            success.filesDinhKem?.map((e) => e.fileId ?? '').toList();

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
