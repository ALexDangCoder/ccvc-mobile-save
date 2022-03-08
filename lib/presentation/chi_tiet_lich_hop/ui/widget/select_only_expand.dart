import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class SelectOnlyWidget extends StatefulWidget {
  final String title;
  final Widget child;

  const SelectOnlyWidget({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  _SelectOnlyWidgetState createState() => _SelectOnlyWidgetState();
}

class _SelectOnlyWidgetState extends State<SelectOnlyWidget>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.0.textScale()),
      child: ExpandOnlyWidget(
        header: headerWidget(),
        child: widget.child,
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: textNormalCustom(
            fontWeight: FontWeight.w500,
            fontSize: 16.0.textScale(),
            color: dateColor,
          ),
        ),
      ],
    );
  }
}
