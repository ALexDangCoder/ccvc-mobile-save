import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/table_pick_date.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CupertinoMaterialPicker extends StatefulWidget {
  const CupertinoMaterialPicker({
    Key? key,
    this.isAddMargin = false,
    this.isSwitchButtonChecked = false,
    this.onSwitchPressed,
    this.initTimeStart,
    this.initTimeEnd,
    this.initDateStart,
    this.initDateEnd,
    this.isEdit = false,
    required this.onDateTimeChanged,
    required this.validateTime,
    this.isAllDay = false,
    this.cubit,
    this.timeStartConfigSystem,
    this.timeEndConfigSystem,
  }) : super(key: key);

  final bool isAddMargin;
  final bool isAllDay;
  final bool isEdit;
  final DateTimeCupertinoCustomCubit? cubit;
  final bool isSwitchButtonChecked;
  final Function(bool)? onSwitchPressed;
  final DateTime? initTimeStart;
  final DateTime? initTimeEnd;
  final DateTime? initDateStart;
  final DateTime? initDateEnd;
  final String? timeStartConfigSystem;
  final String? timeEndConfigSystem;
  final Function(
    String timeStart,
    String timeEnd,
    String dateStart,
    String dateEnd,
  ) onDateTimeChanged;
  final Function(String value) validateTime;

  @override
  CupertinoMaterialPickerState createState() => CupertinoMaterialPickerState();
}

class CupertinoMaterialPickerState extends State<CupertinoMaterialPicker> {
  late final DateTimeCupertinoCustomCubit _cubit;
  late final Debouncer debouncer;
  final keyExpandedEnd =
      GlobalObjectKey<ExpandedSectionState>(ExpandedSectionState());
  final keyExpandedBegin =
      GlobalObjectKey<ExpandedSectionState>(ExpandedSectionState());
  int counterTimeStart = 0;
  int counterTimeEnd = 0;
  int counterDate = 0;

  @override
  void initState() {
    super.initState();
    _cubit = widget.cubit ?? DateTimeCupertinoCustomCubit();
    _cubit.isSwitchBtnCheckedSubject.add(widget.isSwitchButtonChecked);
    _cubit.timeStartConfigSystem = widget.timeStartConfigSystem ?? '00:00';
    _cubit.timeEndConfigSystem = widget.timeEndConfigSystem ?? '00:00';
    debouncer = Debouncer();
    initData(widget.isEdit);
  }

  bool validator() {
    return _cubit.checkTime();
  }

  void initData(bool data) {
    if (data) {
      _cubit.onTimeChanged(
          timeSelected: widget.initTimeEnd ?? DateTime.now(),
          typePicker: TypePickerDateTime.TIME_END);
      _cubit.onTimeChanged(
        timeSelected: widget.initDateEnd ?? DateTime.now(),
        typePicker: TypePickerDateTime.DATE_END,
      );
      _cubit.onTimeChanged(
          timeSelected: widget.initTimeStart ?? DateTime.now(),
          typePicker: TypePickerDateTime.TIME_START);
      _cubit.onTimeChanged(
        timeSelected: widget.initDateStart ?? DateTime.now(),
        typePicker: TypePickerDateTime.DATE_START,
      );
    }
  }

  @override
  void didUpdateWidget(covariant CupertinoMaterialPicker oldWidget) {
    _cubit.timeStartConfigSystem = widget.timeStartConfigSystem ?? '00:00';
    _cubit.timeEndConfigSystem = widget.timeEndConfigSystem ?? '00:00';
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switchButton,
        pickTimeStart,
        pickTimeEnd,
        spaceH12,
        warningText,
      ],
    );
  }

  Widget get warningText => StreamBuilder<String>(
        stream: _cubit.validateTime.stream,
        builder: (context, snapshot) {
          widget.validateTime(
            snapshot.data ??
                (widget.isEdit ? '' : S.current.ban_phai_chon_thoi_gian),
          );
          return Visibility(
            visible:
                (snapshot.data?.isNotEmpty) ?? (widget.isEdit ? true : false),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Text(
                snapshot.data ?? '',
                style: textNormalCustom(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      );

  Widget get pickTimeEnd => Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorECEEF7,
            ),
          ),
        ),
        child: ExpandOnlyWidget(
          key: keyExpandedEnd,
          isShowIcon: false,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  S.current.ket_thuc,
                  style: textNormal(titleItemEdit, 16),
                ),
              ),
              StreamBuilder<bool>(
                stream: _cubit.isSwitchBtnCheckedSubject,
                builder: (context, snapshot) {
                  final bool isShowTime = snapshot.data ?? false;
                  return Visibility(
                    visible: !isShowTime,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        expandTimeEnd(TypePickerDateTime.TIME_END);
                      },
                      child: StreamBuilder<String>(
                        stream: _cubit.timeEndSubject,
                        initialData: INIT_TIME_PICK,
                        builder: (context, snapshot) {
                          final String time = snapshot.data ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              time,
                              style: textNormal(titleItemEdit, 16),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: _cubit.dateEndSubject.stream,
                initialData: INIT_DATE_PICK,
                builder: (context, snapshot) {
                  final String date = snapshot.data ?? S.current.ddmmyy;
                  return GestureDetector(
                    onTap: () {
                      expandDateEnd(TypePickerDateTime.DATE_END);
                    },
                    child: Text(
                      date,
                      style: textNormal(titleItemEdit, 16),
                    ),
                  );
                },
              )
            ],
          ),
          child: StreamBuilder<TypePickerDateTime>(
            stream: _cubit.typePickerSubjectEnd.stream,
            initialData: TypePickerDateTime.TIME_END,
            builder: (context, snapshot) {
              final typePicker = snapshot.data ?? TypePickerDateTime.TIME_END;
              return typePicker == TypePickerDateTime.TIME_END
                  ? SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        key: UniqueKey(),
                        maximumDate: MAXIMUM_DATE,
                        minimumDate: MINIMUM_DATE,
                        maximumYear: MAXIMUM_YEAR,
                        minimumYear: MINIMUM_YEAR,
                        backgroundColor: backgroundColorApp,
                        mode: _cubit.getTypePicker(typePicker),
                        use24hFormat: true,
                        initialDateTime: initDataTo.convertStringToDate(
                          formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                        ),
                        onDateTimeChanged: (value) {
                          debouncer.run(
                            () {
                              _cubit.onTimeChanged(
                                timeSelected: value,
                                typePicker: typePicker,
                              );
                              widget.onDateTimeChanged(
                                timeFrom,
                                timeTo,
                                dateFrom,
                                dateTo,
                              );
                              _cubit.checkTime();
                            },
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: StreamBuilder<DateTime>(
                        stream: _cubit.editCheckAllDay.stream,
                        initialData: widget.initDateEnd ??
                            initDataTo.convertStringToDate(
                              formatPattern: DateFormatApp.pickDateFormat,
                            ),
                        builder: (context, snapshot) {
                          return DateTimeCus(
                            key: UniqueKey(),
                            onDatePicked: (onDatePicked) {
                              callBackEndPick(onDatePicked, typePicker);
                              widget.onDateTimeChanged(
                                timeFrom,
                                timeTo,
                                dateFrom,
                                dateTo,
                              );
                            },
                            initialDate: snapshot.data,
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      );

  Widget get pickTimeStart => Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorECEEF7,
            ),
          ),
        ),
        child: ExpandOnlyWidget(
          key: keyExpandedBegin,
          isShowIcon: false,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  S.current.bat_dau,
                  style: textNormal(titleItemEdit, 16),
                ),
              ),
              StreamBuilder<bool>(
                stream: _cubit.isSwitchBtnCheckedSubject,
                builder: (context, snapshot) {
                  final bool isShowTime = snapshot.data ?? false;
                  return Visibility(
                    visible: !isShowTime,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        expandTimeStart(TypePickerDateTime.TIME_START);
                      },
                      child: StreamBuilder<String>(
                        stream: _cubit.timeBeginSubject,
                        initialData: INIT_TIME_PICK,
                        builder: (context, snapshot) {
                          final String time = snapshot.data ?? '';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              time,
                              style: textNormal(titleItemEdit, 16),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              StreamBuilder<String>(
                stream: _cubit.dateBeginSubject,
                initialData: INIT_DATE_PICK,
                builder: (context, snapshot) {
                  final String date = snapshot.data ?? S.current.ddmmyy;
                  return GestureDetector(
                    onTap: () {
                      expandDateStart(TypePickerDateTime.DATE_START);
                    },
                    child: Text(
                      date,
                      style: textNormal(titleItemEdit, 16),
                    ),
                  );
                },
              )
            ],
          ),
          child: StreamBuilder<TypePickerDateTime>(
            stream: _cubit.typePickerSubjectStart,
            initialData: TypePickerDateTime.TIME_START,
            builder: (context, snapshot) {
              final typePicker = snapshot.data ?? TypePickerDateTime.TIME_START;
              return typePicker == TypePickerDateTime.TIME_START
                  ? SizedBox(
                      height: 200,
                      child: CupertinoDatePicker(
                        maximumDate: MAXIMUM_DATE,
                        minimumDate: MINIMUM_DATE,
                        maximumYear: MAXIMUM_YEAR,
                        minimumYear: MINIMUM_YEAR,
                        backgroundColor: backgroundColorApp,
                        mode: _cubit.getTypePicker(typePicker),
                        use24hFormat: true,
                        initialDateTime: initDataFrom.convertStringToDate(
                          formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                        ),
                        onDateTimeChanged: (value) {
                          debouncer.run(
                            () {
                              _cubit.onTimeChanged(
                                timeSelected: value,
                                typePicker: typePicker,
                              );
                              _cubit.checkTime();
                              widget.onDateTimeChanged(
                                timeFrom,
                                timeTo,
                                dateFrom,
                                dateTo,
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: StreamBuilder<DateTime>(
                        stream: _cubit.editCheckAllDay.stream,
                        initialData: widget.initDateStart ??
                            initDataFrom.convertStringToDate(
                              formatPattern: DateFormatApp.pickDateFormat,
                            ),
                        builder: (context, snapshot) {
                          return DateTimeCus(
                            key: UniqueKey(),
                            onDatePicked: (onDatePicked) {
                              callBackStartPick(onDatePicked, typePicker);
                              widget.onDateTimeChanged(
                                timeFrom,
                                timeTo,
                                dateFrom,
                                dateTo,
                              );
                            },
                            initialDate: snapshot.data,
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      );

  void callBackStartPick(String onDatePicked, TypePickerDateTime typePicker) {
    final convertDate = timeFormat(
      onDatePicked,
      DateTimeFormat.DAY_MONTH_YEAR_BETWEEN,
      DateTimeFormat.DAY_MONTH_YEAR,
    );
    _cubit.dateBeginSubject.sink.add(convertDate);
    _cubit.onTimeChanged(
      timeSelected: convertDate.convertStringToDate(
        formatPattern: DateFormatApp.date,
      ),
      typePicker: typePicker,
    );
    _cubit.checkTime();
  }

  void callBackEndPick(String onDatePicked, TypePickerDateTime typePicker) {
    final convertDate = timeFormat(
      onDatePicked,
      DateTimeFormat.DAY_MONTH_YEAR_BETWEEN,
      DateTimeFormat.DAY_MONTH_YEAR,
    );
    _cubit.dateEndSubject.sink.add(convertDate);
    _cubit.onTimeChanged(
      timeSelected: convertDate.convertStringToDate(
        formatPattern: DateFormatApp.date,
      ),
      typePicker: typePicker,
    );
    _cubit.checkTime();
  }

  Widget get switchButton => Row(
        children: [
          SizedBox(
            height: 18.0.textScale(),
            width: 18.0.textScale(),
            child: SvgPicture.asset(ImageAssets.icNhacLai),
          ),
          SizedBox(
            width: 14.5.textScale(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical:
                    widget.isAddMargin ? 16.0.textScale() : 14.0.textScale(),
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorECEEF7,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.ca_ngay,
                    style: textNormalCustom(
                      color: titleItemEdit,
                      fontSize: 16.0.textScale(),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  StreamBuilder<bool>(
                    initialData: widget.isSwitchButtonChecked,
                    stream: _cubit.isSwitchBtnCheckedSubject,
                    builder: (context, snapshot) {
                      final bool isChecked = snapshot.data ?? false;
                      return CustomSwitch(
                        value: isChecked,
                        onToggle: (bool value) {
                          _cubit.handleSwitchButtonPressed(isToggled: value);
                          if (value) {
                            _cubit.editCheckAllDay.sink.add(DateTime.now());
                          } else {
                            if (typeStart == TypePickerDateTime.DATE_START) {
                              _cubit.editCheckAllDay.sink.add(
                                initDataFrom.convertStringToDate(
                                  formatPattern: DateFormatApp.pickDateFormat,
                                ),
                              );
                            } else if (typeEnd == TypePickerDateTime.DATE_END) {
                              _cubit.editCheckAllDay.sink.add(
                                initDataTo.convertStringToDate(
                                  formatPattern: DateFormatApp.pickDateFormat,
                                ),
                              );
                            }
                          }
                          widget.onSwitchPressed?.call(value);
                          if (value) {
                            _cubit.setTypePickerStart(
                              TypePickerDateTime.DATE_START,
                            );
                            _cubit.setTypePickerEnd(
                              TypePickerDateTime.DATE_END,
                            );
                          }
                          widget.onDateTimeChanged(
                            timeFrom,
                            timeTo,
                            dateFrom,
                            dateTo,
                          );
                          _cubit.checkTime();
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      );

  void expandTimeEnd(TypePickerDateTime type) {
    counterTimeEnd++;
    if (_cubit.typePickerSubjectEnd.value == TypePickerDateTime.TIME_END &&
        keyExpandedEnd.currentState!.isExpandedGroup) {
      keyExpandedEnd.currentState?.collapseGesture();
    } else {
      keyExpandedEnd.currentState?.expandGesture();
      if (keyExpandedBegin.currentState!.isExpandedGroup) {
        keyExpandedBegin.currentState?.collapseGesture();
      }
    }
    if (counterTimeEnd == 1) {
      _cubit.timeToTmp = '00:00';
      _cubit.timeEndSubject.sink.add(_cubit.timeToTmp);
    }
    if (typeEnd != TypePickerDateTime.TIME_END) {
      _cubit.setTypePickerEnd(type);
    }
  }

  void expandTimeStart(TypePickerDateTime type) {
    counterTimeStart++;
    if (_cubit.typePickerSubjectStart.value == TypePickerDateTime.TIME_START &&
        keyExpandedBegin.currentState!.isExpandedGroup) {
      keyExpandedBegin.currentState?.collapseGesture();
    } else {
      keyExpandedBegin.currentState?.expandGesture();
      if (keyExpandedEnd.currentState!.isExpandedGroup) {
        keyExpandedEnd.currentState?.collapseGesture();
      }
    }
    if (counterTimeStart == 1) {
      _cubit.timeFromTmp = '00:00';
      _cubit.timeBeginSubject.sink.add(_cubit.timeFromTmp);
    }
    if (typeStart != TypePickerDateTime.TIME_START) {
      _cubit.setTypePickerStart(type);
    }
  }

  String get now =>
      DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date);

  String get dateFrom => _cubit.dateBeginSubject.valueOrNull ?? now;

  TypePickerDateTime get typeStart => _cubit.typePickerSubjectStart.value;

  TypePickerDateTime get typeEnd => _cubit.typePickerSubjectEnd.value;

  String get dateTo => _cubit.dateEndSubject.valueOrNull ?? now;

  String get timeTo => _cubit.timeEndSubject.valueOrNull ?? '00:00';

  String get timeFrom => _cubit.timeBeginSubject.valueOrNull ?? '00:00';

  String get initDataFrom =>
      '${dateFrom != INIT_DATE_PICK ? dateFrom : now} ${timeFrom != INIT_TIME_PICK ? timeFrom : '00:00'}';

  String get initDataTo =>
      '${dateTo != INIT_DATE_PICK ? dateTo : now} ${timeTo != INIT_TIME_PICK ? timeTo : '00:00'}';

  void expandDateEnd(TypePickerDateTime type) {
    counterDate++;
    if (_cubit.typePickerSubjectEnd.value == TypePickerDateTime.DATE_END &&
        keyExpandedEnd.currentState!.isExpandedGroup) {
      keyExpandedEnd.currentState?.collapseGesture();
    } else {
      keyExpandedEnd.currentState?.expandGesture();
      if (keyExpandedBegin.currentState!.isExpandedGroup) {
        keyExpandedBegin.currentState?.collapseGesture();
      }
    }
    if (counterDate == 1) {
      _cubit.dateToTmp =
          DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date);
      _cubit.dateFromTmp =  _cubit.dateToTmp;
      _cubit.dateEndSubject.sink.add(_cubit.dateToTmp);
      _cubit.dateBeginSubject.sink.add(_cubit.dateToTmp);
    }
    if (typeEnd != TypePickerDateTime.DATE_END) {
      _cubit.setTypePickerEnd(type);
    }
  }

  void expandDateStart(TypePickerDateTime type) {
    counterDate++;
    if (_cubit.typePickerSubjectStart.value == TypePickerDateTime.DATE_START &&
        keyExpandedBegin.currentState!.isExpandedGroup) {
      keyExpandedBegin.currentState?.collapseGesture();
    } else {
      keyExpandedBegin.currentState?.expandGesture();
      if (keyExpandedEnd.currentState!.isExpandedGroup) {
        keyExpandedEnd.currentState?.collapseGesture();
      }
    }
    if (typeStart != TypePickerDateTime.DATE_START) {
      _cubit.setTypePickerStart(type);
    }
    if(counterDate == 1){
      _cubit.dateToTmp =
          DateTime.now().dateTimeFormatter(pattern: DateFormatApp.date);
      _cubit.dateFromTmp =  _cubit.dateToTmp;
      _cubit.dateEndSubject.sink.add(_cubit.dateToTmp);
      _cubit.dateBeginSubject.sink.add(_cubit.dateToTmp);
    }
  }
}

String timeFormat(String time, String oldPattern, String newPattern) {
  if (time == '') return '';
  return DateFormat(newPattern).format(DateFormat(oldPattern).parse(time));
}
