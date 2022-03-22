import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemTableTopicTablet extends StatelessWidget {
  final String title;
  final String index;
  final InteractionStatisticModel dataItem;

  const ItemTableTopicTablet(this.title, this.index, this.dataItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          decoration: BoxDecoration(
            color: backgroundColorApp,
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                offset:  Offset(1, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: cellColorborder,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textNormalCustom(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: fontColorTablet2,
                ),
              ),
              const SizedBox(height: 24,),
              Row(
                children: [
                  Expanded(
                    child: ItemInTableTablet(
                      '${dataItem.articleCount}',
                      S.current.bai_viet,
                      ImageAssets.ic_circle_fb,
                    ),
                  ),
                  const SizedBox(width: 24,),
                  Expanded(
                    child: ItemInTableTablet(
                      '${dataItem.likeCount}',
                      S.current.like,
                      ImageAssets.ic_circle_like,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              Row(
                children: [
                  Expanded(
                    child: ItemInTableTablet(
                      '${dataItem.shareCount}',
                      S.current.share,
                      ImageAssets.ic_circle_share,
                    ),
                  ),
                  const SizedBox(width: 24,),
                  Expanded(
                    child: ItemInTableTablet(
                      '${dataItem.commentCount}',
                      S.current.comment,
                      ImageAssets.ic_circle_coment,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      S.current.bao_cao_chi_tiet,
                      style: textNormalCustom(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemInTableTablet extends StatelessWidget {
  final String index;
  final String content;
  final String icon;

  const ItemInTableTablet(this.index, this.content, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: greyHide,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index,
                style: textNormalCustom(
                  color: titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                content,
                style: textNormalCustom(
                  color: unselectLabelColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 56,
              width: 56,
              child: SvgPicture.asset(icon),
            ),
          ),

        ],
      ),
    );
  }
}