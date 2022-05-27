import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellListCaNhanFix extends StatefulWidget {
  final String? name;
  final String? phone;
  final Function() onTap;

  const CellListCaNhanFix({
    Key? key,
    required this.name,
    required this.phone,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CellListCaNhanFix> createState() => _CellListCaNhanFixState();
}

class _CellListCaNhanFixState extends State<CellListCaNhanFix> {
  DanhBaDienTuCubit cubit = DanhBaDienTuCubit();

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: borderButtomColor),
            color: bgDropDown.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: choTrinhKyColor,
                        ),
                        child: Center(
                          child: Text(
                            cubit.subStringFix(widget.name ?? ''),
                            style: titleText(fontSize: 24),
                          ),
                        ),
                      )
                      // SvgPicture.asset(ImageAssets.icTron),
                    ],
                  ),
                ),
                spaceW16,
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name ?? '',
                        style:
                            textNormalCustom(fontSize: 16, color: color3D5586),
                      ),
                      spaceH6,
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.icPhone),
                          spaceW16,
                          Flexible(
                            child: Text(
                              widget.phone ?? '',
                              style: tokenDetailAmount(
                                fontSize: 14,
                                color: dateColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      spaceH12,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      tabletScreen: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: borderColor.withOpacity(0.5)),
            color: backgroundColorApp,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: choTrinhKyColor,
                        ),
                        child: Center(
                          child: Text(
                            cubit.subStringFix(widget.name ?? ''),
                            style: titleText(fontSize: 24),
                          ),
                        ),
                      )
                      // SvgPicture.asset(ImageAssets.icTron),
                    ],
                  ),
                ),
                spaceW16,
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name ?? '',
                        style:
                            textNormalCustom(fontSize: 16, color: color3D5586),
                      ),
                      spaceH6,
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.icPhone),
                          spaceW16,
                          Flexible(
                            child: Text(
                              widget.phone ?? '',
                              style: tokenDetailAmount(
                                fontSize: 14,
                                color: dateColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      spaceH12,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
