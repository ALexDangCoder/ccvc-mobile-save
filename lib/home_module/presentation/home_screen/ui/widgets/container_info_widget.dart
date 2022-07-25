import 'package:ccvc_mobile/home_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';

class ContainerInfoWidget extends StatelessWidget {
  final List<InfoData> listData;
  final String title;
  final String status;
  final Color? colorStatus;
  final bool backGroundStatus;
  final bool? nonStatus;
  final String status2;
  final Color? colorStatus2;
  final bool backGroundStatus2;
  final bool choTrinhKy;
  final String trichYeu;

  const ContainerInfoWidget({
    Key? key,
    required this.listData,
    this.title = '',
    this.status = '',
    this.colorStatus,
    this.backGroundStatus = false,
    this.status2 = '',
    this.colorStatus2,
    this.nonStatus = false,
    this.backGroundStatus2 = false,
    this.choTrinhKy = false,
    this.trichYeu = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColorApp,
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormal(
              textTitle,
              16.0.textScale(),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
          if (choTrinhKy) ...[
            Text(
              trichYeu.parseHtml().toLowerCase(),
              style: textNormal(
                textTitle,
                16.0.textScale(),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(
            height: 12,
          ),
          Column(
            children: List.generate(listData.length, (index) {
              final data = listData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    if (data.urlIcon.isEmpty)
                      const SizedBox()
                    else
                      SvgPicture.asset(data.urlIcon),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        '${data.key}: ${data.value}',
                        style: textNormal(infoColor, 14.0.textScale()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          if (!(nonStatus ?? false))
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 28, top: backGroundStatus ? 4 : 0),
                  child: Container(
                    padding: !backGroundStatus
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          backGroundStatus ? colorStatus : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      status,
                      style: textNormalCustom(
                        color:
                            backGroundStatus ? backgroundColorApp : colorStatus,
                        fontSize: backGroundStatus
                            ? 12.0.textScale()
                            : 14.0.textScale(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: backGroundStatus2 ? 4 : 0),
                  child: Container(
                    padding: !backGroundStatus2
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          backGroundStatus2 ? colorStatus2 : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      status2,
                      style: textNormalCustom(
                        color: backGroundStatus2
                            ? backgroundColorApp
                            : colorStatus2,
                        fontSize: backGroundStatus2
                            ? 12.0.textScale()
                            : 14.0.textScale(),
                      ),
                    ),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class InfoData {
  final String key;
  final String value;
  final String urlIcon;

  const InfoData({this.key = '', this.value = '', this.urlIcon = ''});
}
