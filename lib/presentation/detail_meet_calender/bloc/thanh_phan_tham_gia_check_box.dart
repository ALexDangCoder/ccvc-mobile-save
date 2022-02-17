import 'dart:developer';

import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/th%C3%A0nh_phan_tham_gia_model.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:rxdart/rxdart.dart';

extension CheckBoxHandle on DetailMeetCalenderCubit {
  bool checkIsSelected(String id) {
    bool vl = false;
    if (selectedIds.contains(id)) {
      vl = true;
    }
    validateCheckAll();
    return vl;
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
      selectedIds =
          listFakeThanhPhanThamGiaModel.map((e) => e.id ?? '').toList();
      log('LEN : ${selectedIds.length}');
    }
    List<ThanhPhanThamGiaModel> _tempList = [];
    if (thanhPhanThamGia.hasValue) {
      _tempList = thanhPhanThamGia.value;
    } else {
      _tempList = listFakeThanhPhanThamGiaModel;
    }
    thanhPhanThamGia.sink.add(_tempList);
  }

  void validateCheckAll() {
    check = selectedIds.length == listFakeThanhPhanThamGiaModel.length;
    log(check.toString());
    checkBoxCheck.sink.add(check);
  }
}
