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
  }) : super(key: key);

  final bool isAddMargin;
  final bool isAllDay;
  final bool isEdit;
  final bool isSwitchButtonChecked;
  final Function(bool)? onSwitchPressed;
  final DateTime? initTimeStart;
  final DateTime? initTimeEnd;
  final DateTime? initDateStart;
  final DateTime? initDateEnd;
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
  late final DateTimeCupertinoCustomCubit cubit;
  late final Debouncer debouncer;
  final keyExpandedEnd =
      GlobalObjectKey<ExpandedSectionState>(ExpandedSectionState());
  final keyExpandedBegin =
      GlobalObjectKey<ExpandedSectionState>(ExpandedSectionState());

  @override
  void initState() {
    super.initState();
    cubit = DateTimeCupertinoCustomCubit();
    debouncer = Debouncer();
    if (widget.isEdit) {
      cubit.onTimeChanged(
        timeSelected: widget.initTimeEnd ??
            DateTime.now().add(
              const Duration(minutes: 30),
            ),
        typePicker: TypePickerDateTime.TIME_END,
      );
      cubit.onTimeChanged(
        timeSelected: widget.initDateEnd ?? DateTime.now(),
        typePicker: TypePickerDateTime.DATE_END,
      );
      cubit.onTimeChanged(
        timeSelected: widget.initTimeStart ?? DateTime.now(),
        typePicker: TypePickerDateTime.TIME_START,
      );
      cubit.onTimeChanged(
        timeSelected: widget.initDateStart ?? DateTime.now(),
        typePicker: TypePickerDateTime.DATE_START,
      );
      cubit.isSwitchBtnCheckedSubject.add(widget.isSwitchButtonChecked);
    }
  }

  bool validator() {
    return !cubit.validateTime.value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Switch Button
        Row(
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
                      stream: cubit.isSwitchBtnCheckedSubject,
                      builder: (context, snapshot) {
                        final bool isChecked = snapshot.data ?? false;
                        return CustomSwitch(
                          value: isChecked,
                          onToggle: (bool value) {
                            cubit.handleSwitchButtonPressed(isChecked: value);
                            widget.onSwitchPressed?.call(value);
                            widget.onDateTimeChanged(
                              cubit.timeBeginSubject.valueOrNull ?? '',
                              cubit.timeEndSubject.valueOrNull ?? '',
                              cubit.dateBeginSubject.value,
                              cubit.dateEndSubject.value,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),

        ///bắt đầu
        Container(
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
                  stream: cubit.isSwitchBtnCheckedSubject,
                  builder: (context, snapshot) {
                    final bool isShowTime = snapshot.data ?? false;
                    return Visibility(
                      visible: !isShowTime,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (cubit.typePickerSubjectStart.value ==
                                  TypePickerDateTime.TIME_START &&
                              keyExpandedBegin.currentState!.isExpandedGroup) {
                            keyExpandedBegin.currentState?.collapseGesture();
                          } else {
                            keyExpandedBegin.currentState?.expandGesture();
                          }
                          cubit.setTypePickerStart(
                              TypePickerDateTime.TIME_START);
                          //cubit.handleDateTimePressed();
                          cubit.lastedType = TypePickerDateTime.TIME_START;
                        },
                        child: StreamBuilder<String>(
                          stream: cubit.timeBeginSubject,
                          initialData: 'hh:mm',
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
                  stream: cubit.dateBeginSubject,
                  initialData: 'DD/MM/YYYY',
                  builder: (context, snapshot) {
                    final String date = snapshot.data ?? S.current.ddmmyy;
                    return GestureDetector(
                      onTap: () {
                        if (cubit.typePickerSubjectStart.value ==
                                TypePickerDateTime.DATE_START &&
                            keyExpandedBegin.currentState!.isExpandedGroup) {
                          keyExpandedBegin.currentState?.collapseGesture();
                        } else {
                          keyExpandedBegin.currentState?.expandGesture();
                        }
                        cubit.setTypePickerStart(TypePickerDateTime.DATE_START);
                        //cubit.handleDateTimePressed();
                        cubit.lastedType = TypePickerDateTime.DATE_START;
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
              stream: cubit.typePickerSubjectStart,
              initialData: TypePickerDateTime.TIME_START,
              builder: (context, snapshot) {
                final typePicker =
                    snapshot.data ?? TypePickerDateTime.TIME_START;
                return typePicker == TypePickerDateTime.TIME_START
                    ? SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                          maximumDate: DateTime(2099, 12, 30),
                          minimumDate: DateTime(1900),
                          maximumYear: 2099,
                          minimumYear: 1900,
                          backgroundColor: backgroundColorApp,
                          mode: cubit.getTypePicker(typePicker),
                          use24hFormat: true,
                          initialDateTime: widget.isEdit
                              ? '${cubit.dateBeginSubject.value} '
                                      '${cubit.timeBeginSubject.value}'
                                  .convertStringToDate(
                                  formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                                )
                              : null,
                          onDateTimeChanged: (value) {
                            debouncer.run(
                              () {
                                cubit.onTimeChanged(
                                  timeSelected: value,
                                  typePicker: typePicker,
                                );
                                cubit.checkTime();
                                widget.onDateTimeChanged(
                                  cubit.timeBeginSubject.valueOrNull ?? '00:00',
                                  cubit.timeEndSubject.valueOrNull ?? '00:00',
                                  cubit.dateBeginSubject.valueOrNull ??
                                      DateTime.now().dateTimeFormatter(
                                        pattern: DateFormatApp.date,
                                      ),
                                  cubit.dateEndSubject.valueOrNull ??
                                      DateTime.now().dateTimeFormatter(
                                        pattern: DateFormatApp.date,
                                      ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: DateTimeCus(
                          onDatePicked: (onDatePicked) {
                            final convertDate = timeFormat(
                              onDatePicked,
                              DateTimeFormat.DAY_MONTH_YEAR_BETWEEN,
                              DateTimeFormat.DAY_MONTH_YEAR,
                            );
                            cubit.dateBeginSubject.sink.add(convertDate);
                            cubit.checkTime();
                            widget.onDateTimeChanged(
                              cubit.timeBeginSubject.valueOrNull ?? '00:00',
                              cubit.timeEndSubject.valueOrNull ?? '00:00',
                              cubit.dateBeginSubject.valueOrNull ??
                                  DateTime.now().dateTimeFormatter(
                                    pattern: DateFormatApp.date,
                                  ),
                              cubit.dateEndSubject.valueOrNull ??
                                  DateTime.now().dateTimeFormatter(
                                    pattern: DateFormatApp.date,
                                  ),
                            );
                          },
                          initialDate: widget.initDateStart ?? DateTime.now(),
                        ),
                      );
              },
            ),
          ),
        ),
        Container(
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
                    stream: cubit.isSwitchBtnCheckedSubject,
                    builder: (context, snapshot) {
                      final bool isShowTime = snapshot.data ?? false;
                      return Visibility(
                        visible: !isShowTime,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (cubit.typePickerSubjectEnd.value ==
                                    TypePickerDateTime.TIME_END &&
                                keyExpandedEnd.currentState!.isExpandedGroup) {
                              keyExpandedEnd.currentState?.collapseGesture();
                            } else {
                              keyExpandedEnd.currentState?.expandGesture();
                            }
                            cubit.setTypePickerEnd(TypePickerDateTime.TIME_END);
                            //cubit.handleDateTimePressed(isBegin: false);
                            cubit.lastedType = TypePickerDateTime.TIME_END;
                          },
                          child: StreamBuilder<String>(
                            stream: cubit.timeEndSubject,
                            initialData: 'hh:mm',
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
                    stream: cubit.dateEndSubject.stream,
                    initialData: 'DD/MM/YYYY',
                    builder: (context, snapshot) {
                      final String date = snapshot.data ?? S.current.ddmmyy;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (cubit.typePickerSubjectEnd.value ==
                                  TypePickerDateTime.DATE_END &&
                              keyExpandedEnd.currentState!.isExpandedGroup) {
                            keyExpandedEnd.currentState?.collapseGesture();
                          } else {
                            keyExpandedEnd.currentState?.expandGesture();
                          }
                          cubit.setTypePickerEnd(TypePickerDateTime.DATE_END);
                          //cubit.handleDateTimePressed(isBegin: false);
                          cubit.lastedType = TypePickerDateTime.DATE_END;
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
                stream: cubit.typePickerSubjectEnd.stream,
                initialData: TypePickerDateTime.TIME_END,
                builder: (context, snapshot) {
                  final typePicker =
                      snapshot.data ?? TypePickerDateTime.TIME_END;
                  return typePicker == TypePickerDateTime.TIME_END
                      ? SizedBox(
                          height: 200,
                          child: CupertinoDatePicker(
                            key: UniqueKey(),
                            maximumDate: DateTime(2099, 12, 30),
                            maximumYear: 2099,
                            minimumYear: cubit.getYearNumber(),
                            backgroundColor: backgroundColorApp,
                            mode: cubit.getTypePicker(typePicker),
                            use24hFormat: true,
                            initialDateTime: widget.isEdit
                                ? '${cubit.dateEndSubject.value} '
                                        '${cubit.timeEndSubject.value}'
                                    .convertStringToDate(
                                    formatPattern: DateTimeFormat.DATE_DD_MM_HM,
                                  )
                                : null,
                            onDateTimeChanged: (value) {
                              debouncer.run(
                                () {
                                  cubit.onTimeChanged(
                                    timeSelected: value,
                                    typePicker: typePicker,
                                  );
                                  cubit.checkTime();
                                  widget.onDateTimeChanged(
                                    cubit.timeBeginSubject.valueOrNull ??
                                        '00:00',
                                    cubit.timeEndSubject.valueOrNull ?? '00:00',
                                    cubit.dateBeginSubject.valueOrNull ??
                                        DateTime.now().dateTimeFormatter(
                                            pattern: DateFormatApp.date),
                                    cubit.dateEndSubject.valueOrNull ??
                                        DateTime.now().dateTimeFormatter(
                                            pattern: DateFormatApp.date),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: DateTimeCus(
                            onDatePicked: (onDatePicked) {
                              final convertDate = timeFormat(
                                onDatePicked,
                                DateTimeFormat.DAY_MONTH_YEAR_BETWEEN,
                                DateTimeFormat.DAY_MONTH_YEAR,
                              );
                              cubit.dateEndSubject.sink.add(convertDate);
                              cubit.checkTime();
                              widget.onDateTimeChanged(
                                cubit.timeBeginSubject.valueOrNull ?? '00:00',
                                cubit.timeEndSubject.valueOrNull ?? '00:00',
                                cubit.dateBeginSubject.valueOrNull ??
                                    DateTime.now().dateTimeFormatter(
                                        pattern: DateFormatApp.date),
                                cubit.dateEndSubject.valueOrNull ??
                                    DateTime.now().dateTimeFormatter(
                                        pattern: DateFormatApp.date),
                              );
                            },
                            initialDate: widget.initDateEnd ?? DateTime.now(),
                          ),
                        );
                },
              )),
        ),
        spaceH12,
        StreamBuilder<String>(
          stream: cubit.validateTime.stream,
          builder: (context, snapshot) {
            widget.validateTime(snapshot.data ?? '');
            return Visibility(
              visible: (snapshot.data?.isNotEmpty) ?? false,
              child: Text(
                snapshot.data ?? '',
                style: textNormalCustom(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

String timeFormat(String time, String oldPattern, String newPattern) {
  return DateFormat(newPattern).format(DateFormat(oldPattern).parse(time));
}
