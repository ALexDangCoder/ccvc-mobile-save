import 'dart:developer';

import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

import '../chi_tiet_lich_hop_cubit.dart';

///thành phần tham gia
extension ThanhPhanThamGia on DetailMeetCalenderCubit {
  Future<void> getDanhSachCuocHopTPTH() async {
    final result = await hopRp.getDanhSachCuocHopTPTH(idCuocHop);

    result.when(
      success: (success) {
        thanhPhanThamGia.add(success.listCanBo ?? []);
        // dataThaGiaDefault = success.listCanBo ?? [];
      },
      error: (error) {},
    );
  }

  Future<void> themThanhPhanThamGia() async {
   final data  = moiHopRequest;
   log('${data}');
    // final result =
    //     await hopRp.postMoiHop(idCuocHop, false, phuongThucNhan, moiHopRequest);
    // result.when(
    //   success: (res) {
    //     getDanhSachCuocHopTPTH();
    //     moiHopRequest.clear();
    //   },
    //   error: (error) {},
    // );
  }

  Future<void> danhSachCanBoTPTG({required String id}) async {
    final result = await hopRp.getDanhSachCanBoTPTG(id);
    result.when(
      success: (value) {
        dataThanhPhanThamGia = value.listCanBo ?? [];
        thanhPhanThamGia.sink.add(value.listCanBo ?? []);
      },
      error: (error) {},
    );
  }

  Future<void> postDiemDanh() async {
    showLoading();
    final result = await hopRp.postDiemDanh(selectedIds);
    result.when(
      success: (value) {
        showContent();
        getDanhSachCuocHopTPTH();
        selectedIds.clear();
      },
      error: (error) {
        showError();
      },
    );
    showContent();
  }

  Future<void> postHuyDiemDanh(String id) async {
    showLoading();
    final result = await hopRp.postHuyDiemDanh(id);
    result.when(
      success: (value) {
        showContent();
        getDanhSachCuocHopTPTH();
      },
      error: (error) {
        showError();
      },
    );
    showContent();
  }

  void search(String text) {
    final searchTxt = text.trim().toLowerCase().vietNameseParse();
    bool isListCanBo(CanBoModel canBo) {
      return canBo.tenCanBo!
          .toLowerCase()
          .vietNameseParse()
          .contains(searchTxt);
    }

    final value =
        dataThanhPhanThamGia.where((element) => isListCanBo(element)).toList();
    thanhPhanThamGia.sink.add(value);
  }

  void checkBoxButton() {
    checkBoxCheckAllTPTG.sink.add(check);
  }

  bool checkIsSelected(String id) {
    bool value = false;
    if (selectedIds.contains(id)) {
      value = true;
    }
    validateCheckAll();
    return value;
  }

  void addOrRemoveId({
    required bool isSelected,
    required String id,
  }) {
    if (isSelected) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
      final temp = selectedIds.toSet();
      selectedIds = temp.toList();
    }
    validateCheckAll();
  }

  void checkAll() {
    selectedIds.clear();
    if (check) {
      selectedIds = dataThanhPhanThamGia
          .where((element) => element.showCheckBox())
          .map((e) => e.id ?? '')
          .toList();
    }
    List<CanBoModel> _tempList = [];
    if (thanhPhanThamGia.hasValue) {
      _tempList = thanhPhanThamGia.value;
    } else {
      _tempList = dataThanhPhanThamGia;
    }
    thanhPhanThamGia.sink.add(_tempList);
  }

  void validateCheckAll() {
    check = selectedIds.length ==
        dataThanhPhanThamGia.where((element) => element.showCheckBox()).length;
    checkBoxCheckAllTPTG.sink.add(check);
  }

  Future<void> callApiThanhPhanThamGia() async {
    showLoading();
    await getDanhSachCuocHopTPTH();
    await danhSachCanBoTPTG(id: idCuocHop);
    showContent();
  }
}
