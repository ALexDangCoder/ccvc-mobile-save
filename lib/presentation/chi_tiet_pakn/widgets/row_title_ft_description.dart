import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class RowTitleFeatDescription extends StatelessWidget {
  const RowTitleFeatDescription({
    Key? key,
    required this.title,
    required this.description,
    this.descriptionStyle,
    this.titleStyle,
  }) : super(key: key);
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: (titleStyle != null)
                ? textNormalCustom(
                    color: dateColor,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  )
                : titleStyle,
          ),
        ),
        spaceW13,
        Expanded(
          flex: 3,
          child: Text(
            description,
            style: (descriptionStyle != null)
                ? textNormalCustom(
                    color: titleColor,
                    fontSize: 14.0.textScale(),
                    fontWeight: FontWeight.w400,
                  )
                : descriptionStyle,
          ),
        )
      ],
    );
  }
}
