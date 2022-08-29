import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/bieu_quyet_extension.dart';
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
    final result =
        await hopRp.postMoiHop(idCuocHop, false, phuongThucNhan, moiHopRequest);
    result.when(
      success: (res) {
        getDanhSachCuocHopTPTH();
        moiHopRequest.clear();
      },
      error: (error) {},
    );
  }

  Future<void> danhSachCanBoTPTG({required String id}) async {
    final result = await hopRp.getDanhSachCanBoTPTG(id);
    result.when(
      success: (value) {
        dataThanhPhanThamGia = value.listCanBo ?? [];
        isCheckDiemDanh(value.listCanBo ?? []);
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

  Future<void> callApiThanhPhanThamGia() async {
    showLoading();
    await getDanhSachCuocHopTPTH();
    await danhSachCanBoTPTG(id: idCuocHop);
    showContent();
  }
}

extension ThanhPhanThamGiaExt on ThanhPhanThamGiaHopCubit {
  void addOrRemoveId({
    required bool isSelected,
    required String id,
  }) {
    if (isSelected) {
      diemDanhIds.remove(id);
    } else {
      diemDanhIds.add(id);
      final temp = diemDanhIds.toSet();
      diemDanhIds = temp.toList();
    }
    validateCheckAll();
  }

  void checkAll() {
    final selectedCanBo = thanhPhanThamGia.valueOrNull ?? [];
    diemDanhIds.clear();
    if (check) {
      diemDanhIds = selectedCanBo
          .where((element) => element.isVangMat ?? true)
          .map((e) => e.id ?? '')
          .toList();
    }

    thanhPhanThamGia.sink.add(selectedCanBo);
  }

  void removeCheckAll() {
    final selectedCanBo = thanhPhanThamGia.valueOrNull ?? [];
    diemDanhIds.clear();
    thanhPhanThamGia.sink.add(selectedCanBo);
  }

  void validateCheckAll() {
    final selectedCanBo = thanhPhanThamGia.valueOrNull ?? [];
    check = diemDanhIds.length ==
        selectedCanBo.where((element) => element.isVangMat ?? true).length;
    checkBoxCheckAllTPTG.sink.add(check);
  }
}
