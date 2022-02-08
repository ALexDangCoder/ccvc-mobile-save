import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

class ItemYKienTablet extends StatelessWidget {
  final String name;
  final String imgAvatar;
  final String? nameFile;
  final String time;

  const ItemYKienTablet({
    Key? key,
    required this.name,
    required this.imgAvatar,
    required this.time,
    this.nameFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:bgTabletItem,
        border: Border.all(color: cellColorborder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   image: NetworkImage(''),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                name,
                style: textNormalCustom(
                  fontSize: 16,
                  color: titleColor,
                ),
              ),
               Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    time,
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0.textScale(),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12,),
          Text(
            S.current.thong_tin_bo_sung,
            style: textNormalCustom(
              color: titleColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.0.textScale(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            S.current.van_ban_dinh_kem,
            style: textNormalCustom(
              color: titleColor,
              fontWeight: FontWeight.w400,
              fontSize: 12.0.textScale(),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            nameFile ?? 'link',
            style: textNormalCustom(
              color: textColorMangXaHoi,
              fontWeight: FontWeight.w400,
              fontSize: 12.0.textScale(),
            ),
          ),
        ],
      ),
    );
  }
}
