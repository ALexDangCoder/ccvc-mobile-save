import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';

extension CreateTechSupport on HoTroKyThuatCubit {
  Future<void> geiApiAddAndSearch() async {
    getTree();
    await getNguoiTiepNhanYeuCau();
    await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
    await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
    await getCategory(title: HoTroKyThuatCubit.TRANG_THAI);
  }

  Future<void> getApiThemMoiYCHT() async {
    showLoading();
    await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
    await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
    if (flagLoadThemMoiYCHT) {
      showContent();
    } else {
      //nothing
    }
  }

  void selectArea(int index) {
    addTaskHTKTRequest.districtName = listKhuVuc.value[index].name;
    addTaskHTKTRequest.districtId = listKhuVuc.value[index].id;

    listToaNha.add(
      listKhuVuc.value[index].childCategories ?? [],
    );
    final _buildingList = listKhuVuc.value[index].childCategories
            ?.map((e) => '${e.name}${e.id}')
            .toList() ??
        [];
    buildingListStream.sink.add(_buildingList);
  }

  void selectBuilding(int index) {}
}
