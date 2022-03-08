import 'dart:developer';
import 'dart:io';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/request/lich_hop/chon_bien_ban_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/danh_sach_lich_hop_request.dart';
import 'package:ccvc_mobile/data/request/lich_hop/tao_phien_hop_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop_item.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/tao_phien_hop_model.dart';
import 'package:ccvc_mobile/domain/model/meeting_schedule.dart';
import 'package:ccvc_mobile/domain/repository/lich_hop/hop_repository.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_state.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class LichHopCubit extends BaseCubit<LichHopState> {
  LichHopCubit() : super(LichHopStateIntial()) {
    final user = HiveLocal.getDataUser();
    if (user != null) {
      userId = user.userId ?? '';
      donViId = user.userInformation?.donViTrucThuoc?.id ?? '';
    }
  }

  List<ItemDanhSachLichHop> listDSLH = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String userId = '';
  String donViId = '';
  int page = 1;
  int totalPage = 2;
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

  Future<void> getDashboard() async {
    showLoading();

    final result = await hopRepo.getDashBoardLichHop(
      startDate.formatApi,
      endDate.formatApi,
    );

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

  BehaviorSubject<List<ListPhienHopModel>> phienHopSubject = BehaviorSubject();
  List<ListPhienHopModel> listPhienHop = [];

  Future<void> getDanhSachPhienHop({
    required String id,
  }) async {
    showLoading();
    final result = await hopRepo.getDanhSachPhienHop(id);
    result.when(
      success: (value) {
        listPhienHop = value;
        phienHopSubject.sink.add(listPhienHop);
      },
      error: (error) {},
    );
    showContent();
  }

  Future<void> postDanhSachLichHop() async {
    showLoading();
    final result = await hopRepo.postDanhSachLichHop(
      DanhSachLichHopRequest(
        DateFrom: startDate.formatApi,
        DateTo: endDate.formatApi,
        DonViId: donViId,
        PageIndex: page,
        PageSize: 10,
        UserId: userId,
      ),
    );
    result.when(
      success: (value) {
        totalPage = value.totalPage ?? 1;
        log("${value.items?.map((e) => e.id).toList()}");

        listDSLH.addAll(value.items ?? []);

        value.items = listDSLH;
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
  BehaviorSubject<List<TaoPhienHopModel>> themPhienSubject = BehaviorSubject();
  List<TaoPhienHopModel> listThemPhien = [];

  Future<void> themPhemHop({
    required String canBoId,
    required String donViId,
    required String lichHopId,
    required String thoiGian_BatDau,
    required String thoiGian_KetThuc,
    required String noiDung,
    required String tieuDe,
    required String hoTen,
    required bool IsMultipe,
    required List<FilesRepuest> file,
  }) async {
    showLoading();
    final TaoPhienHopRepuest taoPhienHopRepuest = TaoPhienHopRepuest(
        canBoId,
        donViId,
        thoiGian_BatDau,
        thoiGian_KetThuc,
        noiDung,
        tieuDe,
        hoTen,
        IsMultipe,
        file);
    final result = await hopRepo.getThemPhienHop(lichHopId, taoPhienHopRepuest);

    result.when(
      success: (value) {
        listThemPhien = value;
        themPhienSubject.sink.add(listThemPhien);
      },
      error: (error) {},
    );

    showContent();
  }

  // them tai lieu tao lich hop
  Future<void> postFileTaoLichHop({
    required int entityType,
    required String entityName,
    required String entityId,
    required bool isMutil,
    required List<File> files,
  }) async {
    showLoading();
    await hopRepo
        .postFileTaoLichHop(entityType, entityName, entityId, isMutil, files)
        .then((value) {
      value.when(
        success: (res) {},
        error: (err) {},
      );
    });
  }

  BehaviorSubject<ChonBienBanCuocHopModel> chonBienBanHopSubject =
      BehaviorSubject();
  ChonBienBanCuocHopModel chonBienBanCuocHopModel = ChonBienBanCuocHopModel();

  Future<void> postChonMauHop({
    required int pageIndex,
    required int pageSize,
  }) async {
    showLoading();
    final ChonBienBanHopRequest chonBienBanHopRequest =
        ChonBienBanHopRequest(pageIndex, pageSize);
    final result = await hopRepo.postChonMauBienBanHop(chonBienBanHopRequest);

    result.when(
      success: (value) {
        chonBienBanCuocHopModel = value;
        chonBienBanHopSubject.sink.add(chonBienBanCuocHopModel);
      },
      error: (error) {},
    );

    showContent();
  }

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
