import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
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
              margin: const EdgeInsets.symmetric(vertical: 19),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(image),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        title,
                        style: textNormalCustom(
                          color: selectColorTabbar,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: statusCalenderRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: textNormalCustom(
                            color: statusCalenderRed,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
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
