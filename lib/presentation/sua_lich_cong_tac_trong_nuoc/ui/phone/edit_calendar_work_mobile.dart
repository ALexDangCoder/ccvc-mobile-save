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

class EditCalendarWork extends StatefulWidget {
  final ChiTietLichLamViecCubit cubit;
  final ChiTietLichLamViecModel event;

  const EditCalendarWork({
    Key? key,
    required this.cubit,
    required this.event,
  }) : super(key: key);

  @override
  _EditCalendarWorkState createState() =>
      _EditCalendarWorkState();
}

class _EditCalendarWorkState
    extends State<EditCalendarWork> {
  final CreateWorkCalCubit createCubit = CreateWorkCalCubit();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final _formKey = GlobalKey<FormGroupState>();
  late DateTimeCupertinoCustomCubit cupertinoCubit;
  final ScrollController scrollController = ScrollController();
  bool pickTimeValidatorValue = true;
  bool chooseTypeCalendarValidatorValue = true;
  bool chooseFileValidatorValue = true;

  @override
  void initState() {
    cupertinoCubit = DateTimeCupertinoCustomCubit();
    assignData(widget.event);
    createCubit.loadData();
    super.initState();
  }

  void assignData(ChiTietLichLamViecModel event) {
    createCubit.listeningEndDataTime(
      DateTime.parse(
        timeFormat(
          '${event.dateTimeTo}',
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_TIME_PUT,
        ),
      ),
    );
    createCubit.listeningStartDataTime(
      DateTime.parse(
        timeFormat(
          '${event.dateTimeFrom}',
          DateTimeFormat.DATE_TIME_RECEIVE,
          DateTimeFormat.DATE_TIME_PUT,
        ),
      ),
    );

    createCubit.detailCalendarWorkModel = event;
    createCubit.selectedCountry = event.country ?? '';
    createCubit.selectedCountryID = event.countryId ?? '';
    createCubit.datNuocSelectModel?.id = event.countryId;
    createCubit.typeScheduleId = event.typeScheduleId;
    createCubit.dateTimeFrom = event.dateTimeFrom;
    createCubit.dateTimeTo = event.dateTimeTo;
    createCubit.linhVucString = event.linhVuc;
    createCubit.days = event.days;
    createCubit.typeRepeat = event.typeRepeat;
    createCubit.typeScheduleName = event.typeScheduleName;
    createCubit.changeOption.sink.add(event.typeScheduleName ?? '');
    createCubit.publishSchedule = event.publishSchedule;

    createCubit.dateRepeat = event.dateRepeat;

    createCubit.scheduleReminder = event.scheduleReminder;
    createCubit.detailCalendarWorkModel.scheduleCoperatives =
        event.scheduleCoperatives;
    titleController.text = event.title ?? '';
    contentController.text = event.content ?? '';
    locationController.text = event.location ?? '';
    if (event.typeScheduleId == '1cc5fd91-a580-4a2d-bbc5-7ff3c2c3336e') {
      createCubit.checkTrongNuoc.sink.add(true);
    } else {
      createCubit.checkTrongNuoc.sink.add(false);
    }
    createCubit.files = event.files;
    createCubit.id = event.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateWorkCalCubit, CreateWorkCalState>(
      bloc: createCubit,
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
          stream: createCubit.stateStream,
          child: FollowKeyBoardWidget(
            child: CreateWorkCalendarProvide(
              taoLichLamViecCubit: createCubit,
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
                          cubit: createCubit,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldStyle(
                                  controller: titleController,
                                  urlIcon: ImageAssets.icEdit,
                                  hintText: S.current.tieu_de,
                                  validate: (value) {
                                    return value.pleaseEnter(S.current.tieu_de);
                                  },
                                ),
                                LoaiLichWidget(
                                  taoLichLamViecCubit: createCubit,
                                  callback: (value) {
                                    chooseTypeCalendarValidatorValue = value;
                                  },
                                  isEdit: true,
                                ),
                                CupertinoMaterialPicker(
                                  isEdit: true,
                                  isAllDay: widget.event.isAllDay ?? false,
                                  isSwitchButtonChecked:
                                      widget.event.isAllDay ?? false,
                                  initDateStart: createCubit
                                      .dateTimeFrom
                                      ?.convertStringToDate(),
                                  initTimeStart: createCubit
                                      .dateTimeFrom
                                      ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd,
                                  ),
                                  initDateEnd: createCubit.dateTimeTo
                                      ?.convertStringToDate(),
                                  initTimeEnd: createCubit.dateTimeTo
                                      ?.convertStringToDate(
                                    formatPattern:
                                        DateFormatApp.dateTimeBackEnd,
                                  ),
                                  cubit: cupertinoCubit,
                                  onDateTimeChanged: (
                                    String timeStart,
                                    String timeEnd,
                                    String dateStart,
                                    String dateEnd,
                                  ) {
                                    createCubit.checkValidateTime();
                                    if (timeEnd != INIT_TIME_PICK &&
                                        dateEnd != INIT_DATE_PICK) {
                                      createCubit.listeningEndDataTime(
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
                                      createCubit
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
                                    createCubit.isCheckAllDaySubject
                                        .add(value);
                                  },
                                  validateTime: (String value) {
                                    pickTimeValidatorValue = value.isNotEmpty;
                                  },
                                ),
                                NhacLaiWidget(
                                  cubit: createCubit,
                                  isEdit: true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                NguoiChuTriWidget(
                                  cubit: createCubit,
                                ),
                                LinhVucWidget(
                                  cubit: createCubit,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 30.0,
                                  ),
                                  child: CustomSwitchWidget(
                                    onToggle: (value) {
                                      createCubit.publishSchedule =
                                          value;
                                    },
                                    value:
                                        createCubit.publishSchedule ??
                                            false,
                                  ),
                                ),
                                StreamBuilder<bool>(
                                  stream: createCubit.checkTrongNuoc,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    if (!data) {
                                      return Column(
                                        children: [
                                          ItemTinhWidget(
                                            taoLichLamViecCubit:
                                                createCubit,
                                          ),
                                          ItemHuyenWidget(
                                            taoLichLamViecCubit:
                                                createCubit,
                                          ),
                                          ItemXaWidget(
                                            taoLichLamViecCubit:
                                                createCubit,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return ItemDatNuocWidget(
                                        cubit: createCubit,
                                      );
                                    }
                                  },
                                ),
                                TextFieldStyle(
                                  controller: locationController,
                                  urlIcon: ImageAssets.icViTri,
                                  hintText: S.current.dia_diem,
                                  validate: (value) {
                                    return value
                                        .pleaseEnter(S.current.dia_diem);
                                  },
                                ),
                                LichLapWidget(
                                  cubit: createCubit,
                                  isEdit: true,
                                ),
                                StreamBuilder<bool>(
                                  stream: createCubit
                                      .lichLapTuyChinhSubject.stream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    return data
                                        ? SuaLichLapTuyChinh(
                                            taoLichLamViecCubit:
                                                createCubit,
                                            initDataTuyChinh:
                                                createCubit
                                                    .listNgayChonTuan(
                                              createCubit.days ?? '',
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                                StreamBuilder<bool>(
                                  stream: createCubit
                                      .lichLapKhongLapLaiSubject.stream,
                                  builder: (context, snapshot) {
                                    final data = snapshot.data ?? false;
                                    return data
                                        ? ItemLapDenNgayWidget(
                                            taoLichLamViecCubit:
                                                createCubit,
                                            isThem: false,
                                            initDate: DateTime.parse(
                                              createCubit.dateRepeat ??
                                                  DateTime.now().toString(),
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                                TextFieldStyle(
                                  controller: contentController,
                                  urlIcon: ImageAssets.icDocument,
                                  hintText: S.current.noi_dung,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ThanhPhanThamGiaTLWidget(
                                  taoLichLamViecCubit: createCubit,
                                  listPeopleInit: createCubit
                                      .detailCalendarWorkModel
                                      .scheduleCoperatives,
                                ),
                                TaiLieuWidget(
                                  files: createCubit.files ?? [],
                                  onChange: (files, value) {
                                    createCubit.filesTaoLich = files;
                                    chooseFileValidatorValue = !value;
                                  },
                                  idRemove: (String id) {
                                    createCubit.filesDelete.add(id);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 16.0, top: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: buttonEditCalendar(
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
                                            createCubit.checkTrongNuoc,
                                        builder: (context, snapshot) {
                                          final data = snapshot.data ?? false;
                                          return Expanded(
                                            child: StreamBuilder<bool>(
                                              stream: createCubit
                                                  .btnSubject.stream,
                                              builder: (context, snapshot) {
                                                return buttonEditCalendar(
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
    if (_formKey.currentState!.validator() &&
        !pickTimeValidatorValue &&
        !chooseTypeCalendarValidatorValue &&
        chooseFileValidatorValue) {
      checkInside(data);
    }
    if (pickTimeValidatorValue) {
      cupertinoCubit.validateTime.sink.add(
        S.current.ban_phai_chon_thoi_gian,
      );
    }
    if (chooseTypeCalendarValidatorValue) {
      createCubit.checkChooseTypeCal.sink.add(true);
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
          createCubit.checkDuplicate(
            context: context,
            title: titleController.value.text.removeSpace,
            content: contentController.value.text.removeSpace,
            location: locationController.value.text.removeSpace,
            isEdit: true,
            isOnly: !value,
          );
        });
      } else {
        createCubit.checkDuplicate(
          context: context,
          title: titleController.value.text.removeSpace,
          content: contentController.value.text.removeSpace,
          location: locationController.value.text.removeSpace,
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
          createCubit.checkDuplicate(
            context: context,
            title: titleController.value.text.removeSpace,
            content: contentController.value.text.removeSpace,
            location: locationController.value.text.removeSpace,
            isEdit: true,
            isOnly: !value,
            isInside: false,
          );
        });
      } else {
        createCubit.checkDuplicate(
          context: context,
          title: titleController.value.text.removeSpace,
          content: contentController.value.text.removeSpace,
          location: locationController.value.text.removeSpace,
          isEdit: true,
          isInside: false,
        );
      }
    }
  }
}

Widget buttonEditCalendar({
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