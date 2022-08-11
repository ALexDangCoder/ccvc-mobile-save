
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/day_picker_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/debouncer.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/rxdart.dart';

class LichLapWidget extends StatefulWidget {
  final bool initExpand;
  final List<String> listSelect;
  final String value;
  final String title;
  final String urlIcon;
  final bool isShowValue;
  final Widget? customValue;
  final Function(int)? onChange;
  final Function(List<int>)? onDayPicked;
  final Function(String)? onDateChange;
  final DateTime? initDate;
  final List<int>? initDayPicked;
  final bool isUpdate;
  final String? miniumDate;

  const LichLapWidget({
    Key? key,
    this.initExpand = false,
    this.listSelect = const [],
    this.value = '',
    this.isShowValue = true,
    this.title = '',
    required this.urlIcon,
    this.customValue,
    this.onChange,
    this.onDayPicked,
    this.onDateChange,
    this.initDate,
    this.isUpdate = false,
    this.initDayPicked,
    this.miniumDate,
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<LichLapWidget>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<int> selectBloc = BehaviorSubject<int>();
  String valueSelect = '';
  late AnimationController? expandController;
  bool isShowDatePicker = false;
  String date = '';
  final Debouncer deboucer = Debouncer();
  String? minimunDate;

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.listSelect.isNotEmpty) {
      final index =
          widget.listSelect.indexWhere((element) => element == widget.value);
      if (index != -1) {
        valueSelect = widget.listSelect[index];
        widget.onChange?.call(index);
        selectBloc.sink.add(index);
      }
    }

    if(date.isEmpty){
      date = DateTime.now().dateTimeFormatter(
        pattern: DateFormatApp.date,
      );
    }

  }

  @override
  void didUpdateWidget(covariant LichLapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listSelect.isNotEmpty) {
      final index =
          widget.listSelect.indexWhere((element) => element == widget.value);
      if (index != -1) {
        valueSelect = widget.listSelect[index];
      } else {
        valueSelect = '';
      }
      selectBloc.sink.add(index);
    } else {
      valueSelect = '';
    }

    if (widget.miniumDate != null) {
      minimunDate = widget.miniumDate?.changeToNewPatternDate(
        DateFormatApp.pickDateSearchFormat,
        DateFormatApp.date,
      );
      final dateMinium = minimunDate!.convertStringToDate(
        formatPattern: DateFormatApp.date,
      );
      if (dateMinium.isAfter(
        date.convertStringToDate(
          formatPattern: DateFormatApp.date,
        ),
      )) {
        date = minimunDate!;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    selectBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      initExpand: widget.initExpand,
      isShowIcon: false,
      initController: expandController,
      header: headerWidget(),
      child: widget.listSelect.isEmpty
          ? const NodataWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  widget.listSelect.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      top: index == 0 ? 0 : 8,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        valueSelect = widget.listSelect[index];
                        widget.onChange?.call(index);
                        selectBloc.sink.add(index);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.listSelect[index],
                                style: textNormal(color3D5586, 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.isShowValue)
                              StreamBuilder<int>(
                                stream: selectBloc.stream,
                                builder: (context, snapshot) {
                                  final data = snapshot.data;
                                  return data == index && data != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4),
                                          child: SvgPicture.asset(
                                            ImageAssets.icCheck,
                                            color: AppTheme.getInstance()
                                                .colorField(),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              )
                            else
                              const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ...[
                  StreamBuilder<int>(
                    stream: selectBloc,
                    builder: (context, snapshot) {
                      return Visibility(
                        visible: valueSelect == 'Tùy chỉnh',
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 28.0,
                            right: 6,
                            top: 24,
                          ),
                          child: DayPickerWidget(
                            isUpdate: widget.isUpdate,
                            initDayPicked: widget.initDayPicked,
                            onChange: (listId) {
                              widget.onDayPicked?.call(listId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
                spaceH24,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    isShowDatePicker = !isShowDatePicker;
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.lap_den,
                        style: textNormal(color586B8B, 16),
                      ),
                      Row(
                        children: [
                          Text(
                            date,
                            style: textNormal(color586B8B, 16),
                          ),
                          spaceW25,
                          ImageAssets.svgAssets(
                            ImageAssets.icDropDown,
                            color: colorA2AEBD,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  key: UniqueKey(),
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  height: isShowDatePicker ? 200 : 1,
                  child: isShowDatePicker
                      ? CupertinoDatePicker(
                          key: UniqueKey(),
                          maximumDate: DateTime(2099, 12, 30),
                          maximumYear: 2099,
                          // minimumYear: DateTime.now().year,
                          minimumDate: minimunDate
                              ?.convertStringToDate(
                                formatPattern: DateFormatApp.date,
                              ),
                          backgroundColor: backgroundColorApp,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          initialDateTime: date.convertStringToDate(
                            formatPattern: DateFormatApp.date,
                          ).add(const Duration(minutes: 5)),
                          onDateTimeChanged: (value) {
                            deboucer.run(() {
                              date = value.dateTimeFormatter(
                                pattern: DateFormatApp.date,
                              );
                              widget.onDateChange?.call(date);
                              setState(() {});
                            });
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                Visibility(
                  visible: !isShowDatePicker,
                  child: Container(
                    margin: const EdgeInsets.only(top: 11),
                    height: 1,
                    color: colorA2AEBD.withOpacity(0.1),
                  ),
                ),
              ],
            ),
    );
  }

  Widget headerWidget() {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: Colors.transparent,
          child: SvgPicture.asset(
            widget.urlIcon,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: expandController!,
            builder: (context, _) => Container(
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: expandController!.value == 0
                        ? colorECEEF7
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: textNormal(titleColumn, 16),
                        ),
                      ),
                      Expanded(
                        child: widget.customValue ??
                            StreamBuilder<int>(
                              stream: selectBloc.stream,
                              builder: (context, snapshot) {
                                return screenDevice(
                                  mobileScreen: Text(
                                    valueSelect,
                                    style: textNormal(color3D5586, 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  tabletScreen: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 26),
                                      child: Text(
                                        valueSelect,
                                        style: textNormal(color3D5586, 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                      ),
                      if (expandController!.value == 0)
                        const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AqiColor,
                        )
                      else
                        const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: AqiColor,
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
