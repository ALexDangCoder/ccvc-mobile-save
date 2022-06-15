import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';

class ItemChiaSeCoTk extends StatefulWidget {
  const ItemChiaSeCoTk({Key? key}) : super(key: key);

  @override
  State<ItemChiaSeCoTk> createState() => _ItemChiaSeCoTkState();
}

class _ItemChiaSeCoTkState extends State<ItemChiaSeCoTk> {

  bool valueCkc = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: colorNumberCellQLVB,
        borderRadius: BorderRadius.circular(
          6,
        ),
        border: Border.all(color: borderItemCalender),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              RowTitleFeatDescription(
                title: S.current.ho_ten,
                titleStyle: textNormalCustom(
                  color: color667793,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                description: 'Hoàng Phương Thảo',
                descriptionStyle: textNormalCustom(
                  color: textTitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceH10,
              RowTitleFeatDescription(
                title: S.current.email,
                titleStyle: textNormalCustom(
                  color: color667793,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                description: 'acb@gmail.com',
                descriptionStyle: textNormalCustom(
                  color: textTitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceH10,
              RowTitleFeatDescription(
                title: S.current.chuc_vu,
                titleStyle: textNormalCustom(
                  color: color667793,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                description: 'Chuyên viên',
                descriptionStyle: textNormalCustom(
                  color: textTitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceH10,
              RowTitleFeatDescription(
                title: S.current.don_vi,
                titleStyle: textNormalCustom(
                  color: color667793,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                description: 'Bộ nội vụ',
                descriptionStyle: textNormalCustom(
                  color: textTitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                checkColor: AppTheme.getInstance().backGroundColor(),
                activeColor: textDefault,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                value: valueCkc,
                onChanged: (value) {
                  setState(() {
                    valueCkc = !valueCkc;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

