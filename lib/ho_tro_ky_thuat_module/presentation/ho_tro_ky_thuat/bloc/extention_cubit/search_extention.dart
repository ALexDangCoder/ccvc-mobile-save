import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/category.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';

extension onChangeSearch on HoTroKyThuatCubit {
  void initSearch() {
    if (listTrangThai.value.isEmpty) {
      geiApiSearch();
    }
    keyWord = statusKeyWord;
    donViSearch.add(statusDonVi);
    createOn = statusNgayYeuCau;
    finishDay = statusNgayHoanThanh;
    userRequestIdName = statusNguoiTiepNhan;
    handlerIdName = statusNguoiXuLy;
    districtIdName = statusKhuVuc;
    buildingIdName = statusToaNha;
    room = statusSoPhong;
    processingCodeName = statusTrangThaiXuLy;
  }

  void onSaveSearch() {
    countSearch = HoTroKyThuatCubit.SEARCH;
  }

  void onSearchPop() {
    switch (countSearch) {
      case HoTroKyThuatCubit.INIT_SEARCH:
        codeUnit = null;
        createOn = null;
        finishDay = null;
        userRequestId = null;
        userRequestIdName = null;
        districtId = null;
        districtIdName = null;
        buildingId = null;
        buildingIdName = null;
        room = null;
        processingCode = null;
        processingCodeName = null;
        handlerId = null;
        handlerIdName = null;
        keyWord = null;
        donViSearch.add(S.current.chon);
        break;
      case HoTroKyThuatCubit.CLOSE_SEARCH:
        break;
      case HoTroKyThuatCubit.SEARCH:
        statusKeyWord = keyWord;
        statusDonVi = donViSearch.value;
        statusNgayYeuCau = createOn;
        statusNgayHoanThanh = finishDay;
        statusNguoiTiepNhan = userRequestIdName;
        statusNguoiXuLy = handlerIdName;
        statusKhuVuc = districtIdName;
        statusToaNha = buildingIdName;
        statusSoPhong = room;
        statusTrangThaiXuLy = processingCodeName;
        getListDanhBaCaNhan(
          page: 1,
        );
        break;
      default:
        break;
    }
    countSearch = HoTroKyThuatCubit.POP_SEARCH;
  }

  void onCancelSearch() {
    if (countSearch != HoTroKyThuatCubit.INIT_SEARCH) {
      countSearch = HoTroKyThuatCubit.CLOSE_SEARCH;
    }
  }

  void onChangeTimKiem(String value) {
    keyWord = value;
  }

  void onChangeNgayYeuCau(DateTime dateTime) {
    createOn = dateTime.toString();
  }

  void onChangeNgayHoanThanh(DateTime dateTime) {
    finishDay = dateTime.toString();
  }

  void onChangeNguoiTiepNhan(int index) {
    userRequestId = listNguoiTiepNhanYeuCau.value[index].userId;
    userRequestIdName = '${listNguoiTiepNhanYeuCau.value[index].hoVaTen}';
  }

  void onChangeKhuVuc(int index) {
    listToaNha.add(
      listKhuVuc.value[index].childCategories ?? [],
    );
    buildingIdName = null;
    districtId = listKhuVuc.value[index].id;
    districtIdName = listKhuVuc.value[index].name;
    buildingIdName = null;
  }

  void onChangeToaNha(int index) {
    buildingId = listToaNha.value[index].id;
    buildingIdName = listToaNha.value[index].name;
  }

  void onChangeTrangThaiXuLy(int index) {
    processingCode = listTrangThai.value[index].code;
    processingCodeName = listTrangThai.value[index].name;
  }

  void onChangeNguoiXuLy(int index) {
    handlerId = listCanCoHTKT.value[index].userId;
    handlerIdName = getListThanhVien(
      listCanCoHTKT.value,
    )[index];
  }

  void onChangeDonVi(DonViModel value) {
    isShowDonVi.add(false);
    codeUnit = value.id;
    donViSearch.add(
      value.name,
    );
  }

  void onChangeRoom(String value) {
    room = value;
  }
}

extension getItemsSearch on HoTroKyThuatCubit {
  List<String> getItemsNguoiTiepNhanYeuCau() {
    return listNguoiTiepNhanYeuCau.value
        .map(
          (e) => '${e.hoVaTen}',
        )
        .toList();
  }

  List<String> getItemsThanhVien() {
    return listCanCoHTKT.value
        .map((e) => '${e.tenThanhVien.toString()} - ${e.userName.toString()}')
        .toList();
  }

  List<String> getItemsKhuVuc() {
    return listKhuVuc.value.map((e) => e.name ?? '').toList();
  }

  List<String> getItemsToaNha(List<ChildCategories> listData) {
    return listData.map((e) => '${e.name}').toList();
  }

  List<String> getItemsTrangThai() {
    return listTrangThai.value.map((e) => e.name ?? '').toList();
  }
}
