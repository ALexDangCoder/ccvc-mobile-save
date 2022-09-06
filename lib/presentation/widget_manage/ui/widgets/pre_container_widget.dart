import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreContainerWidget extends StatelessWidget {
  final String title;
  final bool isShowThreeDot;
  final bool showSubTitle;
  final Widget child;

  const PreContainerWidget({
    Key? key,
    required this.title,
    this.isShowThreeDot = false,
    this.showSubTitle = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textNormalCustom(
                    fontSize: 16,
                    color: textTitle,
                  ),
                ),
                if (isShowThreeDot)
                  const SizedBox()
                else
                  SvgPicture.asset(ImageAssets.ic_three_dot_doc),
              ],
            ),
          ),
          if (showSubTitle)
            const SizedBox()
          else
            Container(
              margin: const EdgeInsets.only(top: 6, bottom: 20),
            ),
          child,
        ],
      ),
    );
  }
}
