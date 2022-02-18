import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThuHoiLichWidget extends StatefulWidget {
  const ThuHoiLichWidget({Key? key}) : super(key: key);

  @override
  _ThuHoiLichWidgetState createState() => _ThuHoiLichWidgetState();
}

class _ThuHoiLichWidgetState extends State<ThuHoiLichWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDropDown(
            items: const ['Thu hồi 1', 'Thu hồi 2'],
            onSelectItem: (value) {},
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.thu_hoi,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
