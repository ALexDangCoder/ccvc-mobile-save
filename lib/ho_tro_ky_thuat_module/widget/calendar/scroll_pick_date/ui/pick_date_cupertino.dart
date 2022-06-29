import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicKDateCupertino extends StatefulWidget {
  final String title;
  final String? title2;
  final Function(DateTime value) onDateTimeChanged;
  final Color background;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final StartOfEnd startOfEnd;
  final CupertinoDatePickerMode mode;
  final bool isUnderLine;

  const PicKDateCupertino({
    Key? key,
    required this.title,
    this.maximumDate,
    this.minimumDate,
    this.background = bgBottomTab,
    required this.startOfEnd,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    required this.onDateTimeChanged,
    this.title2,
    this.isUnderLine = false,
  }) : super(key: key);

  @override
  _PicKDateCupertinoState createState() => _PicKDateCupertinoState();
}

class _PicKDateCupertinoState extends State<PicKDateCupertino>
    with SingleTickerProviderStateMixin {
  late AnimationController? expandController;

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandOnlyWidget(
          isShowIcon: false,
          header: header(),
          initController: expandController,
          child: SizedBox(
            height: 200.0.textScale(space: 20),
            child: CupertinoDatePicker(
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              backgroundColor: widget.background,
              mode: widget.mode,
              use24hFormat: true,
              initialDateTime: widget.maximumDate,
              onDateTimeChanged: (DateTime value) {
                widget.onDateTimeChanged(value);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget header() {
    return AnimatedBuilder(
      animation: expandController!,
      builder: (BuildContext context, Widget? child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.5.textScale(),
                      ),
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          color: dateColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: widget.startOfEnd
                            .getText(context: context, title: widget.title2),
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
                )
              ],
            ),
          ),
          if (widget.isUnderLine)
            Container(
              margin: EdgeInsets.only(
                left: 32.5.textScale(),
                top: 11.0.textScale(),
              ),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: colorECEEF7)),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
