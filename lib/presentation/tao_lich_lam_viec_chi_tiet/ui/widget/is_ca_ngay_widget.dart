import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/scroll_pick_date/ui/start_end_date_widget.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IsCaNgayWidget extends StatefulWidget {
  final bool isMargin;
  final Function(bool value) isCheck;
  final bool isChecked;

  const IsCaNgayWidget({
    Key? key,
    this.isMargin = true,
    required this.isCheck,
    this.isChecked = true,
  }) : super(key: key);

  @override
  State<IsCaNgayWidget> createState() => _IsCaNgayWidgetState();
}

class _IsCaNgayWidgetState extends State<IsCaNgayWidget> {
  late bool isCheck;

  @override
  void initState() {
    super.initState();
    isCheck = widget.isChecked;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.isMargin
          ? EdgeInsets.only(top: 12.0.textScale())
          : EdgeInsets.zero,
      child: Row(
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
                vertical: widget.isMargin ? 16.0.textScale() : 14.0.textScale(),
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
                  CustomSwitch(
                    value: isCheck,
                    onToggle: (bool value) {
                      isCheck = !isCheck;
                      StartEndDateInherited.of(context)
                          .picKDateCupertinoCubit
                          .isDateTimeSubject
                          .sink
                          .add(isCheck);
                      widget.isCheck(value);
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
