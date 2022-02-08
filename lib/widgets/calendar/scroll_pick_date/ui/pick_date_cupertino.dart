import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/item_select_model.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/widget/title_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

class PicKDateCupertino extends StatefulWidget {
  final String title;
  final Function(DateTime value) onDateTimeChanged;
  final Color background;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final StartOfEnd startOfEnd;
  final CupertinoDatePickerMode mode;
  const PicKDateCupertino({
    Key? key,
    required this.title,
    this.maximumDate,
    this.minimumDate,
    this.background = bgBottomTab,
    required this.startOfEnd,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  _PicKDateCupertinoState createState() => _PicKDateCupertinoState();
}

class _PicKDateCupertinoState extends State<PicKDateCupertino> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(
          isLine: true,
          isColor: true,
          title: widget.title,
          optinal: widget.startOfEnd,
          child: SizedBox(
            height: 200.0.textScale(space: 20),
            child: CupertinoDatePicker(
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              backgroundColor: widget.background,
              mode: widget.mode,
              use24hFormat: true,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime value) {
                widget.onDateTimeChanged(value);
              },
            ),
          ),
        )
      ],
    );
  }
}
