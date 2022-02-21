import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:flutter/material.dart';

class TaoBocBangWidget extends StatefulWidget {
  const TaoBocBangWidget({Key? key}) : super(key: key);

  @override
  _TaoBocBangWidgetState createState() => _TaoBocBangWidgetState();
}

class _TaoBocBangWidgetState extends State<TaoBocBangWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDropDown(
            items: const [],
            onSelectItem: (value) {},
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.xac_nhan,
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
