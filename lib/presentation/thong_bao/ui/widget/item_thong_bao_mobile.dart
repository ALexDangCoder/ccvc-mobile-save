import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

class ItemThongBaoMobile extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final int unreadCount;
  final bool isLine;
  final Function() onTap;

  const ItemThongBaoMobile({
    Key? key,
    required this.image,
    required this.title,
    required this.id,
    required this.unreadCount,
    required this.isLine,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 19.0.textScale()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        image,
                        height: 24.0.textScale(space: 10),
                        width: 24.0.textScale(space: 10),
                      ),
                      SizedBox(
                        width: 12.0.textScale(space: 8),
                      ),
                      Text(
                        title,
                        style: textNormalCustom(
                          color: selectColorTabbar,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0.textScale(space: 10),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.0.textScale(space: 3)),
                        decoration: BoxDecoration(
                          color: statusCalenderRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: textNormalCustom(
                            color: statusCalenderRed,
                            fontSize: 12.0.textScale(space: 5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.0.textScale(),
                      ),
                      SizedBox(
                        height: 20.0.textScale(),
                        width: 20.0.textScale(),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.navigate_next_rounded,
                            color: textBodyTime,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isLine)
              Container(
                height: 1,
                width: double.maxFinite,
                color: lineColor,
              )
            else
              Container()
          ],
        ),
      ),
    );
  }
}
