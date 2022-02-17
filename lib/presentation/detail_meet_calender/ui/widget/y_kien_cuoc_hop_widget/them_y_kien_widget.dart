import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:flutter/material.dart';

class ThemYKienWidget extends StatefulWidget {
  const ThemYKienWidget({Key? key}) : super(key: key);

  @override
  _ThemYKienWidgetState createState() => _ThemYKienWidgetState();
}

class _ThemYKienWidgetState extends State<ThemYKienWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            S.current.cuoc_hop,
            style: tokenDetailAmount(
              color: dateColor,
              fontSize: 14.0,
            ),
          ),
        ),
        CustomDropDown(
          value: 'Cuộc họp',
          items: const ['Cuộc họp', 'Phiên họp'],
          onSelectItem: (value) {

          },
        ),
        const SizedBox(
          height: 24,
        ),
        DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.them,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: () {},
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
