import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class SelectKeyRow extends StatefulWidget {
  final List<SelectKey> listSelect;
  final Function(SelectKey) onChange;
  const SelectKeyRow({
    Key? key,
    required this.listSelect,
    required this.onChange,
  }) : super(key: key);

  @override
  _SelectKeyRowState createState() => _SelectKeyRowState();
}

class _SelectKeyRowState extends State<SelectKeyRow> {
  int selectKey = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.listSelect.length,
        itemBuilder: (context, index) {
          final data = widget.listSelect[index];
          return GestureDetector(
            onTap: () {
              selectKey = index;
              widget.onChange(data);
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == widget.listSelect.length - 1 ? 16 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: index == selectKey ? labelColor : unFocusColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                data.getText(),
                style: textNormalCustom(
                  fontSize: 14.0.textScale(),
                  color: index == selectKey ? backgroundColorApp : labelColor,
                ),
              ),
            ),
          );
        });
  }
}
