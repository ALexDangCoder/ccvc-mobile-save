import 'dart:developer';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  LichHopCubit() : super(LichHopStateIntial());

  DanhSachLichHopRequest danhSachLichHopRequest = fakeDataBody;
  int page = 1;
  int totalPage = 1;
  bool isCheckNgay = false;
  late BuildContext context;
  BehaviorSubject<int> index = BehaviorSubject.seeded(0);

  HopRepository get hopRepo => Get.find();

  BehaviorSubject<List<MeetingSchedule>> listMeetTingScheduleSubject =
      BehaviorSubject();

  final BehaviorSubject<DanhSachCongViecModel> danhSachCongViecSubject =
      BehaviorSubject();

  final BehaviorSubject<DanhSachLichHopModel> danhSachLichHopSubject =
      BehaviorSubject();

  BehaviorSubject<DashBoardLichHopModel> dashBoardSubject = BehaviorSubject();

  Stream<DashBoardLichHopModel> get dashBoardStream => dashBoardSubject.stream;

  Stream<List<MeetingSchedule>> get listMeetingStream =>
      listMeetTingScheduleSubject.stream;

  Stream<DanhSachCongViecModel> get danhSachCongViecStream =>
      danhSachCongViecSubject.stream;

  Stream<DanhSachLichHopModel> get danhSachLichHopStream =>
      danhSachLichHopSubject.stream;

  Future<void> getDashboard({
    required String dateStart,
    required String dateTo,
  }) async {
    showLoading();

    final result = await hopRepo.getDashBoardLichHop(dateStart, dateTo);

    result.when(
      success: (value) {
        listItemSchedule[0].numberOfSchedule = value.soLichChuTri ?? 0;
        listItemSchedule[2].numberOfSchedule = value.soLichSapToi ?? 0;
        listItemSchedule[3].numberOfSchedule = value.soLichTrung ?? 0;
        dashBoardSubject.add(value);
      },
      error: (error) {},
    );

    showContent();
  }

  Future<void> postDanhSachLichHop({
    required DanhSachLichHopRequest body,
  }) async {
    showLoading();
    final result = await hopRepo.postDanhSachLichHop(body);
    result.when(
      success: (value) {
        totalPage = value.totalPage ?? 1;
        danhSachLichHopSubject.add(value);
      },
      error: (error) {},
    );
    showContent();
  }

  List<String> listImageLichHopCuaToi = [
    ImageAssets.icLichCongTacTrongNuoc,
    ImageAssets.lichCanKlch,
    ImageAssets.lichSapToi,
    ImageAssets.icLichCongTacNuocNgoai,
  ];

  dynamic currentTime = DateFormat.MMMMEEEEd().format(DateTime.now());
  List<MeetingSchedule> listMeeting = [
    MeetingSchedule(
        'hung hung hung', '2022-02-07T07:45:00', '2022-02-07T08:45:00'),
    MeetingSchedule('hung', '2022-02-07T09:45:00', '2022-02-07T10:45:00'),
    MeetingSchedule('hung', '2022-02-07T11:45:00', '2022-02-07T12:45:00'),
    MeetingSchedule('hung', '2022-02-07T13:45:00', '2022-02-07T15:45:00'),
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
            isAllDay: false),
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
    }
    if (state is LichHopStateDangList) {
      emit(LichHopStateDangList(type));
    }
    if (state is LichHopStateDangDanhSach) {
      emit(LichHopStateDangDanhSach(type));
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
