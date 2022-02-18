import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class CustomItemCalenderWork extends StatelessWidget {
  final String image;
  final String typeName;
  final int numberOfCalendars;

  const CustomItemCalenderWork({
    Key? key,
    required this.image,
    required this.typeName,
    required this.numberOfCalendars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        height: 88.0,
        width: 274,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: backgroundItemCalender,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 56,
                width: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColorApp,
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
                    style: textNormalCustom(color: titleCalenderWork),
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
