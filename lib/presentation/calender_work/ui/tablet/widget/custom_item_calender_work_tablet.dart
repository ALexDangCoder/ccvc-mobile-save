import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class CustomItemCalenderWorkTablet extends StatelessWidget {
  final String image;
  final String typeName;
  final int numberOfCalendars;

  const CustomItemCalenderWorkTablet({
    Key? key,
    required this.image,
    required this.typeName,
    required this.numberOfCalendars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30.0),
      child: Container(
        height: 116,
        width: 319,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cellColorborder),
          color: bgGridView,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorImageLichHop,
                ),
                child: Center(
                  child: SvgPicture.asset(image),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    typeName,
                    softWrap: true,
                    maxLines: 2,
                    style: textNormalCustom(
                      fontWeight: FontWeight.w400,
                      color: titleCalenderWork,
                      fontSize: 16.0.textScale(),
                    ),
                  ),
                  Text(
                    numberOfCalendars.toString(),
                    style: titleText(color: numberOfCalenders, fontSize: 26.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
