import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemTableTopic extends StatelessWidget {
  final String title;
  final String index;
  final InteractionStatisticModel dataItem;

  const ItemTableTopic(this.title, this.index, this.dataItem, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: whiteHide,
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: whiteHide),
              ),
            ),
            child: Text(
              title,
              style: textNormalCustom(
                fontWeight: FontWeight.w500,
                fontSize: 16.0.textScale(space: 4),
                color: color3D5586,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ItemInTable(
                  '${dataItem.articleCount}',
                  S.current.bai_viet,
                  ImageAssets.icBaiViet,
                ),
              ),
              Expanded(
                child: ItemInTable(
                  '${dataItem.likeCount}',
                  S.current.like,
                  ImageAssets.icLike,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ItemInTable(
                  '${dataItem.shareCount}',
                  S.current.share,
                  ImageAssets.icShare,
                ),
              ),
              Expanded(
                child: ItemInTable(
                  '${dataItem.commentCount}',
                  S.current.comment,
                  ImageAssets.icComment,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.current.bao_cao_chi_tiet,
                style: textNormalCustom(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.getInstance().colorField(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemInTable extends StatelessWidget {
  final String index;
  final String content;
  final String icon;

  const ItemInTable(this.index, this.content, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: greyHide,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index,
            style: textNormalCustom(
              color: color3D5586,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                content,
                style: textNormalCustom(
                  color: colorA2AEBD,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(icon),
              )
            ],
          ),
        ],
      ),
    );
  }
}
