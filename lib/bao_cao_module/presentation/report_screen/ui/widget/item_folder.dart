import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemFolder extends StatelessWidget {
  final int type;
  final int fileNumber;
  final bool isShare;
  final bool isListView;

  const ItemFolder({
    Key? key,
    required this.type,
    this.fileNumber = 0,
    this.isShare = false,
    this.isListView = false,
    //   required this.funChiaSe,
  }) : super(key: key);

  //final Function funChiaSe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          type == FOLDER ? ImageAssets.icFileSvg : ImageAssets.icBaoCaoSvg,
          width: isListView
              ? type == FOLDER
                  ? 40
                  : 33.33
              : type == FOLDER
                  ? 44
                  : 40,
          height: isListView
              ? type == FOLDER
                  ? 36.38
                  : 33.33
              : type == FOLDER
                  ? 44
                  : 40,
        ),
        Positioned(
          left: -3,
          bottom: -2,
          child: isShare
              ? Container(
                  width: 16,
                  height: 16,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().colorField(),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    ImageAssets.icShareWhite,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        if (fileNumber > 0)
          Positioned(
            right: 2,
            bottom: 2,
            child: Text(
              fileNumber.toString(),
              style: textNormalCustom(
                fontSize: 12.0,
                color: titleCalenderWork,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
