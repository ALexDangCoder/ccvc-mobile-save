import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomItemCalenderMobile extends StatelessWidget {
  final String title;
  final String dateTimeFrom;
  final String dateTimeTo;
  final String urlImage;

  const CustomItemCalenderMobile({
    Key? key,
    required this.title,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColorApp,
        border: Border.all(color: cellColorborder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusCalenderRed,
                  ),
                ),
              ),
            ],
          ),
          spaceW8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textNormalCustom(
                  color: titleCalenderWork,
                  fontSize: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  '$dateTimeFrom - $dateTimeTo',
                  style: textNormalCustom(
                    color: textBodyTime,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 4.0),
                height: 24.0,
                width: 24.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(urlImage),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
