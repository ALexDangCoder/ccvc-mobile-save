import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class LoiChucCell extends StatelessWidget {
  const LoiChucCell({
    Key? key,
    required this.data,
  }) : super(key: key);
  final BirthdayModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.0.textScale(space: 16),
          height: 40.0.textScale(space: 16),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CachedNetworkImage(
            imageUrl: data.avatar,
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: Image.asset(ImageAssets.anhDaiDienMacDinh),
            ),
          ),
        ),
        SizedBox(
          width: 14.0.textScale(space: 6),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.tenNguoiGui,
                style: textNormalCustom(fontSize: 14, color: textTitle),
              ),
              spaceH6,
              Text(
                data.loiChuc,
                style: textNormal(infoColor, 14),
                overflow: TextOverflow.ellipsis,
              ),
              spaceH6,
              Text(
                '${S.current.thoi_gian_chuc}(${data.ngayGuiLoiChuc})',
                style: textNormal(infoColor, 14),
              )
            ],
          ),
        )
      ],
    );
  }
}
