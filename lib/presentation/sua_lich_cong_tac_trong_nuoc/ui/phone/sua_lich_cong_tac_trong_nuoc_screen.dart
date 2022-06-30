import 'dart:io';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/bloc/chi_tiet_lich_lam_viec_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/text_field_style.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/them_link_hop_dialog.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_cubit.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/bloc/create_work_calendar_state.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/create_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/custom_switch_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_dat_nuoc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lap_den_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_lich_lap_tuy_chinh.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_quan_huyen_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_tinh_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/item_xa_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/linh_vuc_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/loai_lich_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nguoi_chu_tri_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/nhac_lai_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/ui/date_time_cupertino_material.dart';
import 'package:ccvc_mobile/widgets/notify/notify_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/bloc/thanh_phan_tham_gia_cubit.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuaLichCongTacTrongNuocPhone extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final ChiTietLichLamViecModel event;

  const SuaLichCongTacTrongNuocPhone({
    Key? key,
    required this.cubit,
    required this.event,
  }) : super(key: key);

  @override
  _SuaLichCongTacTrongNuocPhoneState createState() =>
      _SuaLichCongTacTrongNuocPhoneState();
}

class _SuaLichCongTacTrongNuocPhoneState
    extends State<SuaLichCongTacTrongNuocPhone> {
  final CreateWorkCalCubit taoLichLamViecCubit = CreateWorkCalCubit();
  TextEditingController tieuDeController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  TextEditingController diaDiemController = TextEditingController();
  ThanhPhanThamGiaCubit thamGiaCubit = ThanhPhanThamGiaCubit();
  final _formKey = GlobalKey<FormGroupState>();
  late DateTimeCupertinoCustomCubit calCubit;
  final ScrollController scrollController = ScrollController();
  bool timeValue = true;
  bool calValue = true;

  @override
  void initState() {
    calCubit = DateTimeCupertinoCustomCubit();
    assignData(widget.event);
    taoLichLamViecCubit.loadData();
    super.initState();
  }

  void assignData(ChiTietLichLamViecModel event) {
    taoLichLamViecCubit.listeningEndDataTime(
      DateTime.parse(
        timeFormat(
          '${event.dateTimeTo}',
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_TIME_PUT,
        ),
      ),
    );
    taoLichLamViecCubit.listeningStartDataTime(
      DateTime.parse(
        timeFormat(
          '${event.dateTimeFrom}',
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_TIME_PUT,
        ),
      ),
    );

    taoLichLamViecCubit.detailCalendarWorkModel = event;
    taoLichLamViecCubit.selectedCountry = event.country ?? '';
    taoLichLamViecCubit.selectedCountryID = event.countryId ?? '';
    taoLichLamViecCubit.datNuocSelectModel?.id = event.countryId;
    taoLichLamViecCubit.typeScheduleId = event.typeScheduleId;
    taoLichLamViecCubit.dateTimeFrom = event.dateTimeFrom;
    taoLichLamViecCubit.dateTimeTo = event.dateTimeTo;
    taoLichLamViecCubit.linhVucString = event.linhVuc;
    taoLichLamViecCubit.days = event.days;
    taoLichLamViecCubit.typeRepeat = event.typeRepeat;
    taoLichLamViecCubit.typeScheduleName = event.typeScheduleName;
    taoLichLamViecCubit.changeOption.sink.add(event.typeScheduleName ?? '');
    taoLichLamViecCubit.publishSchedule = event.publishSchedule;

    taoLichLamViecCubit.dateRepeat = event.dateRepeat;

    taoLichLamViecCubit.scheduleReminder = event.scheduleReminder;
    taoLichLamViecCubit.detailCalendarWorkModel.scheduleCoperatives =
        event.scheduleCoperatives;
    tieuDeController.text = event.title ?? '';
    noiDungController.text = event.content ?? '';
    diaDiemController.text = event.location ?? '';
    if (event.typeScheduleId == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
      taoLichLamViecCubit.checkTrongNuoc.sink.add(true);
    } else {
      taoLichLamViecCubit.checkTrongNuoc.sink.add(false);
    }
    taoLichLamViecCubit.files = event.files;
    taoLichLamViecCubit.id = event.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateWorkCalCubit, CreateWorkCalState>(
      bloc: taoLichLamViecCubit,
      listener: (context, state) {
        if (state is CreateSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NotifyWidget(
                content: S.current.ban_da_sua_lich_lam_viec_thanh_cong,
                image: ImageAssets.icTaoLichLamViecThanhCong,
                textButtom: S.current.quay_lai,
              ),
            ),
          ).then((value) {
            if (value == null) {
              Navigator.pop(context, true);
            }
            if (value) {
              Navigator.pop(context, true);
            } else {
              Navigator.pop(context, false);
            }
          });
        } else {}
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: backgroundColorApp,
        ),
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: taoLichLamViecCubit.stateStream,
          child: FollowKeyBoardWidget(
            child: CreateWorkCalendarProvide(
              taoLichLamViecCubit: taoLichLamViecCubit,
              child: ExpandGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.sua_lich_lam_viec,
                      style: textNormalCustom(fontSize: 18, color: textTitle),
                    ),
                    Expanded(
                      child: FormGroup(
                        key: _formKey,
                        scrollController: scrollController,
                        child: ProviderWidget<CreateWorkCalCubit>(
                          cubit: taoLichLamViecCubit,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldStyle(
                                  controller: tieuDeController,
                                  urlIcon: ImageAssets.icEdit,
                                  hintText: S.current.tieu_de,
                                  validate: (value) {
                                    return value.pleaseEnter(S.current.tieu_de);
                                  },
                                ),
                                LoaiLichWidget(
                                  taoLichLamViecCubit: taoLichLamViecCubit,
                                  callback: (value) {
                                    calValue = value;
                                  },
                                  isEdit: true,
                                ),
                                CupertinoMaterialPicker(
                                  isEdit: true,
                                  isAllDay: widget.event.isAllDay ?? false,
                                  isSwitchButtonChecked:
                                      widget.event.isAllDay ?? false,
                                  initDateStart: taoLichLamViecCubit
                                      .dateTimeFrom
                                      ?.convertStringToDate(),
                                  initTimeStart: taoLichLamViecCubit
                                      .dateTimeFrom
                                      ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd,
                                  ),
                                  initDateEnd: taoLichLamViecCubit.dateTimeTo
                                      ?.convertStringToDate(),
                                  initTimeEnd: taoLichLamViecCubit.dateTimeTo
                                      ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd,
                                  ),
                                  cubit: calCubit,
                                  onDateTimeChanged: (
                                    String timeStart,
                                    String timeEnd,
                                    String dateStart,
                                    String dateEnd,
                                  ) {
                                    taoLichLamViecCubit.checkValidateTime();
                                    if (timeEnd != INIT_TIME_PICK &&
                                        dateEnd != INIT_DATE_PICK) {
                                      taoLichLamViecCubit.listeningEndDataTime(
                                        DateTime.parse(
                                          timeFormat(
                                            '$dateEnd $timeEnd',
                                            DateTimeFormat.DATE_TIME_PICKER,
                                            DateTimeFormat.DATE_TIME_PUT,
                                          ),
                                        ),
                                      );
                                    }
                                    if (timeStart != INIT_TIME_PICK &&
                                        dateStart != INIT_DATE_PICK) {
                                      taoLichLamViecCubit
                                          .listeningStartDataTime(
                                        DateTime.parse(
                                          timeFormat(
                                            '$dateStart $timeStart',
                                            DateTimeFormat.DATE_TIME_PICKER,
                                            DateTimeFormat.DATE_TIME_PUT,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  onSwitchPressed: (value) {
                                    taoLichLamViecCubit.isCheckAllDaySubject
                                        .add(value);
                                  },
                                  validateTime: (String value) {
                                    timeValue = value.isNotEmpty;
                                  },
                                ),
                                NhacLaiWidget(
                                  cubit: taoLichLamViecCubit,
                                  isEdit: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                NguoiChuTriWidget(
                                  cubit: taoLichLamViecCubit,
                                ),
                                LinhVucWidget(
                                  cubit: taoLichLamViecCubit,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 30.0,
                                  ),
                                  child: CustomSwitchWidget(
                                    onToggle: (value) {
                                      taoLichLamViecCubit.publishSchedule =
                                          value;
                                    },
                                    value:
                                        taoLichLamViecCubit.publishSchedule ??
                                            false,
                                  ),
                                ),
                                StreamBuilder<bool>(
                                  stream: taoLichLamViecCubit.checkTrongNuoc,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    if (!data) {
                                      return Column(
                                        children: [
                                          ItemTinhWidget(
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                          ),
                                          ItemHuyenWidget(
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                          ),
                                          ItemXaWidget(
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return ItemDatNuocWidget(
                                        cubit: taoLichLamViecCubit,
                                      );
                                    }
                                  },
                                ),
                                TextFieldStyle(
                                  controller: diaDiemController,
                                  urlIcon: ImageAssets.icViTri,
                                  hintText: S.current.dia_diem,
                                  validate: (value) {
                                    return value
                                        .pleaseEnter(S.current.dia_diem);
                                  },
                                ),
                                LichLapWidget(
                                  cubit: taoLichLamViecCubit,
                                  isEdit: true,
                                ),
                                StreamBuilder<bool>(
                                  stream: taoLichLamViecCubit
                                      .lichLapTuyChinhSubject.stream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    return data
                                        ? SuaLichLapTuyChinh(
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                            initDataTuyChinh:
                                                taoLichLamViecCubit
                                                    .listNgayChonTuan(
                                              taoLichLamViecCubit.days ?? '',
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                                StreamBuilder<bool>(
                                  stream: taoLichLamViecCubit
                                      .lichLapKhongLapLaiSubject.stream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    return data
                                        ? ItemLapDenNgayWidget(
                                            taoLichLamViecCubit:
                                                taoLichLamViecCubit,
                                            isThem: false,
                                            initDate: DateTime.parse(
                                              taoLichLamViecCubit.dateRepeat ??
                                                  DateTime.now().toString(),
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                                TextFieldStyle(
                                  controller: noiDungController,
                                  urlIcon: ImageAssets.icDocument,
                                  hintText: S.current.noi_dung,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ThanhPhanThamGiaTLWidget(
                                  taoLichLamViecCubit: taoLichLamViecCubit,
                                  listPeopleInit: taoLichLamViecCubit
                                      .detailCalendarWorkModel
                                      .scheduleCoperatives,
                                ),
                                TaiLieuWidget(
                                  files: taoLichLamViecCubit.files ?? [],
                                  onChange: (onChange){
                                    taoLichLamViecCubit.filesTaoLich = onChange;
                                  },
                                  idRemove: (String id) {
                                    taoLichLamViecCubit.filesDelete.add(id);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0,top: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: btnSuaLich(
                                          name: S.current.dong,
                                          bgr: buttonColor.withOpacity(0.1),
                                          colorName: textDefault,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      StreamBuilder<bool>(
                                        stream:
                                            taoLichLamViecCubit.checkTrongNuoc,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? false;
                                          return Expanded(
                                            child: StreamBuilder<bool>(
                                              stream: taoLichLamViecCubit
                                                  .btnSubject.stream,
                                              builder: (context, snapshot) {
                                                return btnSuaLich(
                                                  name: S.current.luu,
                                                  bgr: labelColor,
                                                  colorName: Colors.white,
                                                  onTap: () {
                                                    validateField(data);
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateField(bool data) async {
    _formKey.currentState!.validator();
    if (_formKey.currentState!.validator() && !timeValue && !calValue) {
      checkInside(data);
    }
    if (timeValue) {
      calCubit.validateTime.sink.add(
        S.current.ban_phai_chon_thoi_gian,
      );
    }
    if (calValue) {
      taoLichLamViecCubit.checkChooseTypeCal.sink.add(true);
    }
  }

  void checkInside(bool data) {
    if (!data) {
      if (widget.event.isLichLap ?? false) {
        showDialog(
          context: context,
          builder: (context) => ThemLinkHopDialog(
            title: S.current.sua_lich_lam_viec,
            isConfirm: false,
            imageUrl: ImageAssets.ic_edit_cal,
            textConfirm: S.current.ban_co_chac_chan_sua_lich,
            textRadioAbove: S.current.chi_lich_nay,
            textRadioBelow: S.current.tu_lich_nay,
          ),
        ).then((value) {
          taoLichLamViecCubit.checkDuplicate(
            context: context,
            title: tieuDeController.value.text.removeSpace,
            content: noiDungController.value.text.removeSpace,
            location: diaDiemController.value.text.removeSpace,
            isEdit: true,
            isOnly: !value,
          );
        });
      } else {
        taoLichLamViecCubit.checkDuplicate(
          context: context,
          title: tieuDeController.value.text.removeSpace,
          content: noiDungController.value.text.removeSpace,
          location: diaDiemController.value.text.removeSpace,
          isEdit: true,
        );
      }
    } else {
      if (widget.event.isLichLap ?? false) {
        showDialog(
          context: context,
          builder: (context) => ThemLinkHopDialog(
            title: S.current.sua_lich_lam_viec,
            isConfirm: false,
            imageUrl: ImageAssets.ic_edit_cal,
            textConfirm: S.current.ban_co_chac_chan_sua_lich,
            textRadioAbove: S.current.chi_lich_nay,
            textRadioBelow: S.current.tu_lich_nay,
          ),
        ).then((value) {
          taoLichLamViecCubit.checkDuplicate(
            context: context,
            title: tieuDeController.value.text.removeSpace,
            content: noiDungController.value.text.removeSpace,
            location: diaDiemController.value.text.removeSpace,
            isEdit: true,
            isOnly: !value,
            isInside: false,
          );
        });
      } else {
        taoLichLamViecCubit.checkDuplicate(
          context: context,
          title: tieuDeController.value.text.removeSpace,
          content: noiDungController.value.text.removeSpace,
          location: diaDiemController.value.text.removeSpace,
          isEdit: true,
          isInside: false,
        );
      }
    }
  }
}

Widget btnSuaLich({
  required String name,
  required Color bgr,
  required Color colorName,
  required Function onTap,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgr,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: textNormalCustom(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorName,
        ),
      ),
    ),
  );
}
