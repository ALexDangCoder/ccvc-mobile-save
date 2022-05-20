import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ItemHuongDanSuDung extends StatelessWidget {
  final String url;
  final String title;
  final Function onTap;

  const ItemHuongDanSuDung({
    Key? key,
    required this.title,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: colorFFFFFF,
          border: Border.all(color: colorDBDFEF.withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: color6566E9.withOpacity(0.05),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              url,
              width: 43.sp.textScale(),
              height: 43.sp.textScale(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                title,
                style: textNormalCustom(
                    fontSize: 16.0.textScale(),
                    color: color3D5586,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
