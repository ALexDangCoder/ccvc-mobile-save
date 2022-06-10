import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class LoiChucCell extends StatelessWidget {
  const LoiChucCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle
          ),
          child: CachedNetworkImage(
            imageUrl: '',
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: Image.asset(ImageAssets.anhDaiDienMacDinh),
            ),
          ),
        ),
        SizedBox(
          width: 14,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên người gửi',
                style: textNormalCustom(fontSize: 14, color: textTitle),
              ),
              spaceH6,
              Text(
                'Nội dung lời chúc ẹqoiw uewqoi ueoiqwu oiqwue iơque oiqu ioqu ơique iơque oiqwue iơqeu ơ',
                style: textNormal(infoColor, 14),
                overflow: TextOverflow.ellipsis,
              ),
              spaceH6,
              Text(
                'Thời gian chúc (19/02/2022 10:22:11)',
                style: textNormal(infoColor, 14),
              )
            ],
          ),
        )
      ],
    );
  }
}
