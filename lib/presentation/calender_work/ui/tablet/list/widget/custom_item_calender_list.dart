import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomItemCalenderTablet extends StatelessWidget {
  final String title;
  final String dateTimeFrom;
  final String dateTimeTo;
  final String urlImage;
  final Function onTap;
  final bool isTrung;

  const CustomItemCalenderTablet({
    Key? key,
    required this.title,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.urlImage,
    required this.onTap,
    required this.isTrung,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: bgGridView,
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
            spaceW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textNormalCustom(
                            color: titleCalenderWork,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: isTrung
                            ? Container(
                                padding: const EdgeInsets.only(top: 3),
                                decoration: BoxDecoration(
                                  color: statusCalenderRed.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: statusCalenderRed.withOpacity(0.1),
                                  ),
                                ),
                                height: 24,
                                child: Text(
                                  S.current.trung,
                                  style: textNormalCustom(
                                    color: statusCalenderRed,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(),
                      ),
                      spaceW16
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
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
            ),
          ],
        ),
      ),
    );
  }
}
