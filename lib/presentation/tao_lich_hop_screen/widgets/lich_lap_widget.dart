import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/widgets/day_picker_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
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
  final Function(String, int)? onDayPicked;
  final Function(String)? onDateChange;

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
  }) : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<LichLapWidget>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<int> selectBloc = BehaviorSubject<int>();
  String valueSelect = '';
  late AnimationController? expandController;

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
                            onChange: (value, id) {
                              widget.onDayPicked?.call(value, id);
                            },
                            onDateChange: (value) {
                              widget.onDateChange?.call(value);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ]
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
              child: Row(
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
            ),
          ),
        ),
      ],
    );
  }
}
