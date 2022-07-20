import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_model.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class ItemYKien extends StatelessWidget {
  final YKienModel yKienModel;

  const ItemYKien({Key? key, required this.yKienModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: bgDropDown.withOpacity(0.1),
        border: Border.all(color: bgDropDown),
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
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  yKienModel.imgAvatar,
                  errorBuilder: (_, __, ___) =>
                      Image.asset(ImageAssets.anhDaiDienMacDinh),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                yKienModel.name,
                style: textNormalCustom(
                  color: color3D5586,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateTime.parse(yKienModel.time).toStringDMYHHMM,
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            yKienModel.content,
            style: textNormalCustom(
              color: color3D5586,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
