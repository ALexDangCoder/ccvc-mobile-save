import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StatusType { home, report, calendarWork, internalInteraction, menu }

class BaoCaoItemTablet extends StatelessWidget {
  final String status;
  final String content;
  final Color statusColor;
  final List<String> fileNames;
  final Function() funcEdit;
  final Function() funcDelete;

  const BaoCaoItemTablet({
    Key? key,
    required this.status,
    required this.content,
    required this.statusColor,
    required this.fileNames,
    required this.funcEdit,
    required this.funcDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cellColorborder),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: shadowContainerColor
                  .withOpacity(0.05), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 108,
                  child: Text(
                    S.current.status,
                    style: textNormalCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        status,
                        style: textNormalCustom(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: statusColor,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(ImageAssets.ic_edit),
                            onTap: () {
                              funcEdit();
                            },
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(ImageAssets.ic_delete_do),
                            onTap: () {
                              funcDelete();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 108,
                  child: Text(
                    S.current.just_noi_dung,
                    style: textNormalCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    content,
                    style: textNormalCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: titleCalenderWork,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 108,
                  child: Text(
                    S.current.file,
                    style: textNormalCustom(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: infoColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: fileNames.map((e) {
                      return Column(
                        children: [
                          Text(
                            e,
                            style: textNormalCustom(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: numberOfCalenders,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          )
                        ],
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
