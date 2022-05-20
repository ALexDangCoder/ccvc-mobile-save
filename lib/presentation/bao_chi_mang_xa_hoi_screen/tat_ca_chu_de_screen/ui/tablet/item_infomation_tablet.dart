import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemInfomationTablet extends StatelessWidget {
  final ItemInfomationModel infomationModel;

  const ItemInfomationTablet({
    Key? key,
    required this.infomationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        border: Border.all(color: color05OpacityDBDFEF),
        borderRadius: BorderRadius.circular(12),
        color: colorFFFFFF,
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            infomationModel.image,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                infomationModel.title,
                style: textNormalCustom(
                  color: color3D5586,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0.textScale(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                infomationModel.index,
                style: textNormalCustom(
                  color: infomationModel.color,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

