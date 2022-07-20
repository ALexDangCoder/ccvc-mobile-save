import 'package:cached_network_image/cached_network_image.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/ellipsis_character_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';

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
            fit: BoxFit.cover,
            imageUrl: Get.find<AppConstants>().baseImageUrl+ data.avatar,
            errorWidget: (context, url, error) => Container(
              color: colorBlack,
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
              EllipsisDoubleLineText(
                data.loiChuc,
                style: textNormal(infoColor, 14),
                maxLines: 2,
              ),
              spaceH6,
              Text(
                DateFormat(DateFormatApp.dateSecondBackEnd)
                    .parse(data.ngayGuiLoiChuc)
                    .formatApiDDMMYYYYHHSS,
                style: textNormal(infoColor, 14),
              )
            ],
          ),
        )
      ],
    );
  }
}
