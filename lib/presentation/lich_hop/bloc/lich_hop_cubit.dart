import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  bool isCheckNgay = false;
  late BuildContext context;
  BehaviorSubject<int> index=BehaviorSubject.seeded(0);

  LichHopCubit() : super(LichHopStateIntial());
  List<String> listImageLichHopCuaToi = [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.lichCanKlch,
    ImageAssets.lichSapToi,
    ImageAssets.icLichCongTacNuocNgoai,
  ];

  dynamic currentTime = DateFormat.yMMMEd().format(DateTime.now());
  List<MeetingSchedule> listMeeting = [

    MeetingSchedule("hung", "2022-02-07T07:45:00", "2022-02-07T08:45:00"),
    MeetingSchedule("hung", "2022-02-07T09:45:00", "2022-02-07T10:45:00"),
    MeetingSchedule("hung", "2022-02-07T11:45:00", "2022-02-07T12:45:00"),
    MeetingSchedule("hung", "2022-02-07T13:45:00", "2022-02-07T15:45:00"),
  ];

  DataSource getCalenderDataSource() {
    List<Appointment> appointments = [];
    RecurrenceProperties recurrence =
        RecurrenceProperties(startDate: DateTime.now());
    recurrence.recurrenceType = RecurrenceType.daily;
    recurrence.interval = 2;
    recurrence.recurrenceRange = RecurrenceRange.noEndDate;
    recurrence.recurrenceCount = 10;
    for (int i = 0; i < listMeeting.length; i++) {
      appointments.add(
        Appointment(
          startTime: DateTime.parse(listMeeting[i].dateTimeFrom),
          endTime: DateTime.parse(listMeeting[i].dateTimeTo),
          subject: listMeeting[i].title,
          color: textColorMangXaHoi,
          isAllDay: false
        ),
      );
    }
    return DataSource(appointments);
  }

  chooseTypeList(Type_Choose_Option_List type) {
    if (type == Type_Choose_Option_List.DANG_LICH) {
      emit(const LichHopStateDangLich(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANG_LIST) {
      emit(const LichHopStateDangList(Type_Choose_Option_Day.DAY));
    } else if (type == Type_Choose_Option_List.DANH_SACH) {
      emit(const LichHopStateDangDanhSach(Type_Choose_Option_Day.DAY));
    }
  }

  chooseTypeDay(Type_Choose_Option_Day type) {
    if (state is LichHopStateDangLich) {
      emit(LichHopStateDangLich(type));
    } else {
      emit(LichHopStateDangList(type));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
