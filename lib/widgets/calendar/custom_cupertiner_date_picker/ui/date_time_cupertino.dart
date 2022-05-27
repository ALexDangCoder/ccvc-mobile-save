import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/custom_cupertiner_date_picker/bloc/date_time_cupertino_custom_cubit.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CupertinoTimePickerCustom extends StatefulWidget {
  const CupertinoTimePickerCustom({
    Key? key,
    this.isAddMargin = false,
    this.isSwitchButtonChecked = false,
    this.onSwitchPressed,
  }) : super(key: key);
  final bool isAddMargin;
  final bool isSwitchButtonChecked;
  final Function(bool)? onSwitchPressed;

  @override
  _CupertinoTimePickerCustomState createState() =>
      _CupertinoTimePickerCustomState();
}

class _CupertinoTimePickerCustomState extends State<CupertinoTimePickerCustom> {
  late final DateTimeCupertinoCustomCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = DateTimeCupertinoCustomCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Switch Button
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
                            if (widget.onSwitchPressed != null) {
                              widget.onSwitchPressed!(value);
                            }
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
        spaceH24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.current.bat_dau,
              style: textNormal(titleItemEdit, 16),
            ),
            StreamBuilder<bool>(
              stream: cubit.isSwitchBtnCheckedSubject,
              builder: (context, snapshot) {
                final bool isShowTime = snapshot.data ?? false;
                return Visibility(
                  visible: !isShowTime,
                  child: StreamBuilder<String>(
                    stream: cubit.timeSubject,
                    builder: (context, snapshot) {
                      final String time = snapshot.data ?? '';
                      return Text(
                        time,
                        style: textNormal(titleItemEdit, 16),
                      );
                    },
                  ),
                );
              },
            ),
            StreamBuilder<String>(
              stream: cubit.dateSubject,
              builder: (context, snapshot) {
                final String date = snapshot.data ?? S.current.ddmmyy;
                return Text(
                  date,
                  style: textNormal(titleItemEdit, 16),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
