import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemTinRadioTablet extends StatelessWidget {
  final String image;
  final String title;
  final String date;

  const ItemTinRadioTablet(this.image, this.title, this.date, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 104,
            height: 96,
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
            clipBehavior: Clip.antiAlias,
            decoration:  BoxDecoration(
              border: Border.all(color: cellColorborder),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SizedBox(
                width: 56,
                height: 56,
                child: Image.asset(
                  ImageAssets.icDongNai,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: textDefault,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textNormalCustom(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0.textScale(),
                                  color: titleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SvgPicture.asset(ImageAssets.icPlay),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageAssets.icCalendar),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        date,
                        style: textNormalCustom(
                          fontSize: 14.0.textScale(),
                          fontWeight: FontWeight.w400,
                          color: dateColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.current.kenh_phat_thanh_chinh_thuc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textNormalCustom(
                      fontSize: 14.0.textScale(),
                      fontWeight: FontWeight.w400,
                      color: dateColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}