import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

class ItemThongBaoMobile extends StatefulWidget {
  final String id;
  final String image;
  final bool isImage;
  final String title;
  final int unreadCount;
  final bool isLine;
  final Function() onTap;
  final bool isSwitch;
  final bool valueSwitch;
  final Function(bool status) onChange;

  const ItemThongBaoMobile({
    Key? key,
    this.image = '',
    required this.title,
    required this.id,
    this.unreadCount = 0,
    this.isLine = true,
    required this.onTap,
    this.isSwitch = false,
    required this.onChange,
    this.valueSwitch = false,
    this.isImage = true,
  }) : super(key: key);

  @override
  State<ItemThongBaoMobile> createState() => _ItemThongBaoMobileState();
}

class _ItemThongBaoMobileState extends State<ItemThongBaoMobile> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
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
                      if (widget.isImage)
                        SvgPicture.asset(
                          widget.image,
                          height: 24.0,
                          width: 24.0,
                        )
                      else
                        Container(),
                      SizedBox(
                        width: 12.0.textScale(space: 8),
                      ),
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          color: selectColorTabbar,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                  if (widget.isSwitch)
                    CustomSwitch(
                      value: widget.valueSwitch,
                      onToggle: (value) {
                        isSwitch = value;
                        setState(() {});
                        widget.onChange(value);
                      },
                    )
                  else
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0.textScale(space: 3)),
                          decoration: BoxDecoration(
                            color: statusCalenderRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            widget.unreadCount > 99
                                ? '99+'
                                : widget.unreadCount.toString(),
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
            if (widget.isLine)
              Container(
                height: 1,
                width: double.maxFinite,
                color: colorECEEF7,
              )
            else
              Container()
          ],
        ),
      ),
    );
  }
}
