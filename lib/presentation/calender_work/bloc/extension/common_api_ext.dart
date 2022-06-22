import 'dart:async';

import 'package:ccvc_mobile/data/request/lich_hop/envent_calendar_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/danh_sach_lich_lam_viec_request.dart';
import 'package:ccvc_mobile/data/request/lich_lam_viec/lich_lam_viec_right_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:queue/queue.dart';

import '../calender_cubit.dart';

extension CommonApiExt on CalenderCubit {
  Future<void> menuCalendar() async {
    final result = await lichLamViec.getDataMenu(
      startDates.formatApi,
      endDates.formatApi,
    );

    result.when(
      success: (value) {
        listLanhDao.clear();
        value.forEach((element) {
          listLanhDao.add(
            ItemThongBaoModelMyCalender(
              typeMenu: TypeCalendarMenu.LichTheoLanhDao,
              type: TypeContainer.number,
              menuModel: element,
            ),
          );
        });
        menuModelSubject.add(value);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }

  Future<void> dataLichLamViec({
    required String startDate,
    required String endDate,
  }) async {
    final result = await lichLamViec.getLichLv(startDate, endDate);
    result.when(
      success: (res) {
        lichLamViecDashBroads = res;
        lichLamViecDashBroadSubject.sink.add(lichLamViecDashBroads);
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }

  Future<void> callApiWithAsync() async {
    final Queue que = Queue();
    listDSLV.clear();
    page = 1;
    unawaited(que.add(() => getListLichLV()));
    unawaited(
      que.add(
        () => dataLichLamViec(
          startDate: startDates.formatApi,
          endDate: endDates.formatApi,
        ),
      ),
    );
    unawaited(
      que.add(
        () => dataLichLamViecRight(
          startDate: startDates.formatApi,
          endDate: endDates.formatApi,
          type: 0,
        ),
      ),
    );
    unawaited(que.add(() => menuCalendar()));
    await que.onComplete;
  }

  Future<void> postDanhSachLichlamViec({
    required DanhSachLichLamViecRequest body,
  }) async {
    final result = await lichLamViec.postDanhSachLichLamViec(body);
    result.when(
      success: (value) {
        totalPage = value.totalPage ?? 1;
        danhSachLichLamViecSubject.add(value);
      },
      error: (error) {
        showContent();
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }

  Future<void> postEventsCalendar({
    TypeCalendarMenu typeCalendar = TypeCalendarMenu.LichCuaToi,
  }) async {
    final result = await lichLamViec.postEventCalendar(
      EventCalendarRequest(
        DateFrom: startDates.formatApi,
        DateTo: endDates.formatApi,
        DonViId:
            HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
        isLichCuaToi: typeCalendar == TypeCalendarMenu.LichCuaToi,
        month: selectDay.month,
        PageIndex: page,
        PageSize: 10,
        UserId: HiveLocal.getDataUser()?.userId ?? '',
        year: selectDay.year,
      ),
    );
    result.when(
      success: (value) {
        final List<DateTime> data = [];

        value.forEach((element) {
          data.add(element.convertStringToDate());
        });

        eventsSubject.add(data);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }

  Future<void> dataLichLamViecRight({
    required String startDate,
    required String endDate,
    required int type,
  }) async {
    final LichLamViecRightRequest request = LichLamViecRightRequest(
      dateFrom: startDate,
      dateTo: endDate,
      type: type,
    );
    final result = await lichLamViec.getLichLvRight(request);
    result.when(
      success: (res) {
        lichLamViecDashBroadRight = res;
        lichLamViecDashBroadRightSubject.sink.add(lichLamViecDashBroadRight);
      },
      error: (err) {
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }

  Future<void> getListLichLV() async {
    final DanhSachLichLamViecRequest data = DanhSachLichLamViecRequest(
      DateFrom: startDates.formatApi,
      DateTo: endDates.formatApi,
      DonViId: changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
          ? idDonViLanhDao
          : HiveLocal.getDataUser()?.userInformation?.donViTrucThuoc?.id ?? '',
      IsLichLanhDao:
          changeItemMenuSubject.value == TypeCalendarMenu.LichTheoLanhDao
              ? true
              : null,
      isLichCuaToi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichCuaToi),
      isLichDuocMoi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichDuocMoi),
      isLichTaoHo: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichTaoHo),
      isLichHuyBo:
          changeItemMenuSubject.value.getListLichHop(TypeCalendarMenu.LichHuy),
      isLichThuHoi: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichThuHoi),
      isChuaCoBaoCao: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichHopCanKLCH),
      isDaCoBaoCao: changeItemMenuSubject.value
          .getListLichHop(TypeCalendarMenu.LichDaKLCH),
      isChoXacNhan: getStateLDM.value.getListState(stateLDM.ChoXacNhan),
      isLichThamGia: getStateLDM.value.getListState(stateLDM.ThamGia),
      isLichTuChoi: getStateLDM.value.getListState(stateLDM.TuChoi),
      PageIndex: page,
      PageSize: modeLLV == Type_Choose_Option_List.DANG_LICH ? 1000 : 10,
      UserId: HiveLocal.getDataUser()?.userId ?? '',
    );
    final result = await lichLamViec.getListLichLamViec(data);
    result.when(
      success: (res) {
        totalPage = res.totalPage ?? 1;
        dataLichLvModel = res;
        listDSLV.addAll(dataLichLvModel.listLichLVModel ?? []);
        dataLichLvModel.listLichLVModel = listDSLV;
        listLichSubject.sink.add(dataLichLvModel);
      },
      error: (error) {
        MessageConfig.show(
          title: S.current.error,
          title2: S.current.no_internet,
          showTitle2: true,
        );
      },
    );
  }
}
