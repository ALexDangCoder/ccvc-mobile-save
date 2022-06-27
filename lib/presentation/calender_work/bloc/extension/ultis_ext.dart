import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';

import '../calender_state.dart';

extension UltisCalender on CalenderCubit{
  void getDay() {
    final DateTime textTime = DateTime.now();
    textDay = getDateToString(textTime);
  }

  void chooseTypeListLv(Type_Choose_Option_List type) {
    if (type == Type_Choose_Option_List.DANG_LICH) {
      pageSize = 100;
      emit( LichLVStateDangLich(stateOptionDay));
    } else if (type == Type_Choose_Option_List.DANG_LIST) {
      pageSize = 10;
      emit( LichLVStateDangList(stateOptionDay));
    } else if (type == Type_Choose_Option_List.DANH_SACH) {
      emit( LichLVStateDangDanhSach(stateOptionDay));
    }
  }

  Future<void> refreshApi() async  {
    if (state.type == Type_Choose_Option_Day.DAY) {
      await callApi();
    } else if (state.type ==
        Type_Choose_Option_Day.WEEK) {
      await callApiTuan();
    } else {
      await callApiMonth();
    }
  }

  void chooseTypeCalender(Type_Choose_Option_Day type) {
    if (state is LichLVStateDangLich) {
      emit(LichLVStateDangLich(type));
    } else {
      emit(LichLVStateDangList(type));
    }
  }


  void changeScreenMenu(TypeCalendarMenu typeMenu) {
    changeItemMenuSubject.add(typeMenu);
  }


}
