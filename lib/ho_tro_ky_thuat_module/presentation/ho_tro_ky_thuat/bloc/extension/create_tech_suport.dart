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
    if (areaList.isEmpty || issueList.isEmpty) {
      showLoading();
      await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
      await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
      if (flagLoadThemMoiYCHT) {
        showContent();
      } else {
        //nothing
      }
    } else {
      listKhuVuc.sink.add(areaList);
      flagLoadThemMoiYCHT = true;
      listLoaiSuCo.sink.add(issueList);
      sinkIssue();
    }
  }

  void selectArea(int index) {
    addTaskHTKTRequest.districtName = areaList[index].name;
    addTaskHTKTRequest.districtId = areaList[index].id;
    buildingList = areaList[index].childCategories ?? [];
    final _buildingList = listKhuVuc.value[index].childCategories
            ?.map((e) => '${e.name}${e.id}')
            .toList() ??
        [];
    addTaskHTKTRequest.buildingName = null;
    addTaskHTKTRequest.buildingId = null;
    buildingListStream.sink.add(_buildingList);
  }

  void selectBuilding(int index) {
    addTaskHTKTRequest.buildingName = buildingList[index].name;
    addTaskHTKTRequest.buildingId = buildingList[index].id;
  }

  void sinkIssue() {
    final _issueList = issueList.map((e) => e.name ?? '').toList();
    issueListStream.sink.add(_issueList);
  }

  void addIssueListRequest(List<int> indexList) {
    addTaskHTKTRequest.danhSachSuCo = [];
    for (final e in indexList) {
      addTaskHTKTRequest.danhSachSuCo!.add(listLoaiSuCo.value[e].id ?? '');
    }
  }
}
