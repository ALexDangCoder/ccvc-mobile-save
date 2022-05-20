import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowSumInfoWidget extends StatelessWidget {
  final List<DataInfo> data;
  final double padding;
  const RowSumInfoWidget({
    Key? key,
    required this.data,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final result = data[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? padding : 0,
              right: data.length - 1 == index ? padding : 16,
            ),
            child: Container(
              height: 88,
              constraints: const BoxConstraints(minWidth: 247),
              decoration: const BoxDecoration(
                color: colorF5F8FD,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: colorFFFFFF,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      result.urlIcon,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result.title,
                        style: textNormal(
                          AppTheme.getInstance().titleColor(),
                          16,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        result.value,
                        style: titleText(
                          color: AppTheme.getInstance().subTitleColor(),
                          fontSize: 26,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataInfo {
  final String urlIcon;
  final String title;
  final String value;
  DataInfo({required this.urlIcon, required this.title, required this.value});
}
