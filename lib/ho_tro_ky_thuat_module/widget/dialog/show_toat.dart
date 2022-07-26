import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ShowToast extends StatelessWidget {
  final String text;
  final String icon;

  const ShowToast({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: traLaiColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(icon),
          ),
          spaceW12,
          Text(
            text,
            style: tokenDetailAmount(color: textTitle, fontSize: 14),
          )
        ],
      ),
    );
  }
}
