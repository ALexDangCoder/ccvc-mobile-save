import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/material.dart';

class ContainerToggleWidget extends StatelessWidget {
  final String title;
  final Function(bool) onChange;

  const ContainerToggleWidget({
    Key? key,
    this.title = '',
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.only(left: 29),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorECEEF7),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textNormal(titleColumn, 16),
          ),
          CustomToggle(
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
