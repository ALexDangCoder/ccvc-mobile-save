import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/bloc/danh_sach_bao_cao_dang_girdview_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/widget/xem_them_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

class FilterBaoCao extends StatelessWidget {
  const FilterBaoCao({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final DanhSachBaoCaoCubit cubit;

  @override
  Widget build(BuildContext context) {
    Widget filterText(
      bool isCheck,
      String title,
      String iconSvg,
    ) {
      return InkWell(
        onTap: () {
          cubit.textFilter.add(title);
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconSvg,
                  width: 16,
                  height: 16,
                  color: isCheck
                      ? AppTheme.getInstance().colorField()
                      : AppTheme.getInstance().unselectColor(),
                ),
                spaceW13,
                Text(
                  title,
                  style: textNormalCustom(
                    color: isCheck
                        ? AppTheme.getInstance().colorField()
                        : AppTheme.getInstance().unselectColor(),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (isCheck)
              SvgPicture.asset(
                ImageAssets.icCheck,
                width: 14,
                height: 14,
                color: AppTheme.getInstance().colorField(),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      );
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH20,
          Center(
            child: Container(
              height: 6,
              width: 48,
              decoration: const BoxDecoration(
                color: colorECEEF7,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 22,
            ),
            child: Text(
              S.current.sap_xep,
              style: textNormalCustom(
                color: AppTheme.getInstance().titleColor(),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 18,
              top: 22,
            ),
            child: filterText(
              cubit.textFilter.value == S.current.tu_a_z,
              S.current.tu_a_z,
              ImageAssets.icArrowDownSvg,
            ),
          ),
          lineBaoCao(),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 18,
              top: 18,
            ),
            child: filterText(
              cubit.textFilter.value == S.current.tu_z_a,
              S.current.tu_z_a,
              ImageAssets.icArrowUpSvg,
            ),
          ),
          lineBaoCao(),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 18,
              top: 18,
            ),
            child: filterText(
              cubit.textFilter.value == S.current.sap_xep_theo_moi_nhat,
              S.current.sap_xep_theo_moi_nhat,
              ImageAssets.icTimeBaoCaoSvg,
            ),
          ),
          lineBaoCao(),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 18,
              top: 18,
            ),
            child: filterText(
              cubit.textFilter.value == S.current.sap_xep_theo_cu_nhat,
              S.current.sap_xep_theo_cu_nhat,
              ImageAssets.icTimeBaoCaoSvg,
            ),
          ),
          lineBaoCao(),
          spaceH30,
        ],
      ),
    );
  }
}
