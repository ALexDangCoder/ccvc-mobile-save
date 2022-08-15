import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ThamGiaCuocHopWidget extends StatelessWidget {
  const ThamGiaCuocHopWidget(
      {Key? key, required this.link})
      : super(key: key);
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.getInstance().colorField(),
            ),
            child: Center(
              child: SvgPicture.asset(
                ImageAssets.icTaoBocBang,
                color: backgroundColorApp,
                width: 16.0.textScale(),
              ),
            ),
          ),
          spaceW14,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            launchURL(link);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getInstance().colorField(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: 160,
                            child: Center(
                              child: Text(
                                S.current.tham_gia_cuoc_hop,
                                style: textNormalCustom(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    spaceW12,
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: link),
                        );
                      },
                      child: SvgPicture.asset(
                        ImageAssets.icCoppy,
                        width: 16.0.textScale(),
                      ),
                    )
                  ],
                ),
                spaceH12,
                Text(
                  link,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().unselectColor(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
