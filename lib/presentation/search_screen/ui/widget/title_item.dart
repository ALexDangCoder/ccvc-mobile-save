import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

class TitleItem extends StatelessWidget {
  final String title;
  final String time;

  const TitleItem({Key? key, required this.title, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(
          height: 10.0.textScale(),
        ),
        Text(
          title,
          style: textNormalCustom(
            fontSize: 16.0.textScale(),
            fontWeight: FontWeight.w500,
            color: color3D5586,
          ),
        ),
        SizedBox(
          height: 3.0.textScale(),
        ),
        Text(
          time,
          style: textNormalCustom(
            fontSize: 12.0.textScale(),
            fontWeight: FontWeight.w400,
            color: colorA2AEBD,
          ),
        ),
        SizedBox(
          height: 10.0.textScale(),
        ),
      ],
    );
  }
}
