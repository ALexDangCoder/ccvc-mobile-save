import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/extension/edit_tech_suport_request.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';

extension CreateTechSupport on HoTroKyThuatCubit {
  Future<void> geiApiAddAndSearch() async {
    getTree();
    await getNguoiTiepNhanYeuCau();
    await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
    await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
    await getCategory(title: HoTroKyThuatCubit.TRANG_THAI);
  }

  ///start
  // if (isEdit) {
  // await getChiTietHTKTEdit(id: id ?? '');
  // areaValue = getValueAreaDropDown(
  // statusHTKT: StatusHTKT.Edit,
  // id: modelEditHTKT.districId,
  // );
  // buildingValue = getValueAreaDropDown(
  // statusHTKT: StatusHTKT.Edit,
  // id: modelEditHTKT.buildingId,
  // isArea: false,
  // );
  // } else {
  // areaValue = getValueAreaDropDown(
  // statusHTKT: StatusHTKT.Create,
  // );
  // buildingValue = getValueAreaDropDown(
  // statusHTKT: StatusHTKT.Create,
  // isArea: false,
  // );
  // }
  /// end

  Future<void> getApiThemMoiYCHT() async {
    showLoading();
    if (listKhuVuc.value.isNotEmpty || listToaNha.value.isNotEmpty) {
      listKhuVuc.value.clear();
      listToaNha.value.clear();
    }
    await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
    await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
    listKhuVuc.sink.add(areaList);
    listLoaiSuCo.sink.add(issueList);
    sinkIssue();
    if (flagLoadThemMoiYCHT) {
      showContent();
    } else {
      showError();
    }
  }

  Future<void> loadApiEditYCHT({required String id}) async {
    showLoading();
    editModelHTKT.add(SupportDetail());

    ///get data building, district
    if (listKhuVuc.value.isNotEmpty || listToaNha.value.isNotEmpty) {
      listKhuVuc.value.clear();
      listToaNha.value.clear();
    }
    await getCategory(title: HoTroKyThuatCubit.KHU_VUC);
    await getCategory(title: HoTroKyThuatCubit.LOAI_SU_CO);
    listKhuVuc.sink.add(areaList);
    listLoaiSuCo.sink.add(issueList);
    sinkIssue();

    ///get data detail htkt
    await getChiTietHTKTEdit(id: id);
    findNameAreaFeatBuilding(
      id: editModelHTKT.value.buildingId ?? '',
      isArea: false,
    );
    findNameAreaFeatBuilding(
      id: editModelHTKT.value.districId ?? '',
    );
    getIssuesEditHTKT();

    if (flagLoadEditHTKT) {
      showContent();
    } else {
      showError();
    }
  }

  void selectArea(int index) {
    addTaskHTKTRequest.districtName = areaList[index].name;
    addTaskHTKTRequest.districtId = areaList[index].id;
    showErrorKhuVuc.add(false);
    buildingList = areaList[index].childCategories ?? [];
    final _buildingList = listKhuVuc.value[index].childCategories
            ?.map((e) => '${e.name}')
            .toList() ??
        [];
    buildingListStream.sink.add(_buildingList);
  }

  void selectAreaEdit(int index) {
    nameBuilding = null;
    editTaskHTKTRequest.buildingId = null;
    editTaskHTKTRequest.buildingName = null;
    showErrorToaNha.add(true);
    nameArea = areaList[index].name;
    editTaskHTKTRequest.districtName = areaList[index].name;
    editTaskHTKTRequest.districtId = areaList[index].id;
    showErrorKhuVuc.add(false);
    buildingList = areaList[index].childCategories ?? [];
    final _buildingList = listKhuVuc.value[index].childCategories
            ?.map((e) => '${e.name}')
            .toList() ??
        [];
    buildingListStream.sink.add(_buildingList);
  }

  void selectBuilding(int index) {
    addTaskHTKTRequest.buildingName = buildingList[index].name;
    addTaskHTKTRequest.buildingId = buildingList[index].id;
    showErrorToaNha.add(false);
  }

  void selectBuildingEdit(int index) {
    editTaskHTKTRequest.buildingName = buildingList[index].name;
    editTaskHTKTRequest.buildingId = buildingList[index].id;
    nameBuilding = buildingList[index].name;
    showErrorToaNha.add(false);
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

  void addIssuesEdit(List<int> index) {
    editTaskHTKTRequest.danhSachSuCo = [];
    index.toSet().toList();
    try {
      index.remove(-1);
    } catch (_) {}
    for (final e in index) {
      editTaskHTKTRequest.danhSachSuCo!.add(listLoaiSuCo.value[e].id ?? '');
    }
  }

  void addIssuesEditRequest(List<int> indexList) {}
}