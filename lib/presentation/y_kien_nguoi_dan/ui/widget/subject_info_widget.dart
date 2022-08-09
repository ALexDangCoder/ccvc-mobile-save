import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class SubjectInfoWidget extends StatefulWidget {
  final Color color;
  final String title;
  final double value;

  const SubjectInfoWidget({Key? key,
    required this.color,
    required this.title,
    required this.value,})
      : super(key: key);

  @override
  State<SubjectInfoWidget> createState() => _SubjectInfoWidgetState();
}

class _SubjectInfoWidgetState extends State<SubjectInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              '${widget.title} (${widget.value.toInt().toString()})',
              style: textNormal(
                infoColor,
                14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
