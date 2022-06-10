import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemNguoiDung extends StatelessWidget {
  const ItemNguoiDung({
    Key? key,
    required this.name,
    required this.hasFunction,
    this.delete,
  }) : super(key: key);
  final String name;
  final bool hasFunction;
  final Function? delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 4.w,
        right: 12.w,
        bottom: 4.h,
        top: 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundRowColor,
        borderRadius: BorderRadius.all(
          Radius.circular(60.r),
        ),
        border: Border.all(color: containerColorTab),
      ),
      child: Row(
        children: [
          Container(
            height: 32.h,
            width: 32.w,
            decoration: const BoxDecoration(
              color: yellowColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name
                        .split(' ')
                        .elementAt(name.split(' ').length - 2)
                        .substring(0, 1) +
                    name
                        .split(' ')
                        .elementAt(name.split(' ').length - 1)
                        .substring(0, 1),
                style: textNormalCustom(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          spaceW8,
          Text(
            name,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 14,
            ),
          ),
          if (hasFunction)
            InkWell(
              onTap: () {
                delete!;
              },
              child: Icon(
                Icons.close,
                size: 11.sp,
              ),
            ),
        ],
      ),
    );
  }
}