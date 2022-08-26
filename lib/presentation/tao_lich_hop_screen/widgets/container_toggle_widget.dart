import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/material.dart';

class ContainerToggleWidget extends StatelessWidget {
  final bool initData;
  final String title;
  final Function(bool) onChange;
  final bool showDivider;

  const ContainerToggleWidget({
    Key? key,
    this.title = '',
    required this.onChange,
    this.initData = false,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.only(left: 28.0),
      decoration: showDivider ? const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorECEEF7),
        ),
      ) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textNormal(titleColumn, 16),
          ),
          CustomToggle(
            initValue: initData,
            onChange: onChange,
          )
        ],
      ),
    );
  }
}

class CustomToggle extends StatefulWidget {
  final bool initValue;
  final Function(bool) onChange;

  const CustomToggle({Key? key, this.initValue = false, required this.onChange})
      : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCheck = widget.initValue;
  }

  @override
  void didUpdateWidget(covariant CustomToggle oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    isCheck = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSwitch(
      value: isCheck,
      onToggle: (value) {
        isCheck = value;
        widget.onChange(isCheck);
        setState(() {});
      },
    );
  }
}
