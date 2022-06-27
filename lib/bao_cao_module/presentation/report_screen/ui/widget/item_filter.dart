import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_report_share_favorite.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemFilter extends StatelessWidget {
  final ReportListCubit cubit;
  final bool isIconClose;

  const ItemFilter({
    Key? key,
    required this.cubit,
    this.isIconClose = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            top: 22,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.sap_xep,
                style: textNormalCustom(
                  color: AppTheme.getInstance().titleColor(),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              if (isIconClose)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    ImageAssets.icClose,
                    width: 16,
                    height: 16,
                    color: AppTheme.getInstance().unselectColor(),
                  ),
                ),
            ],
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
            isCheck: cubit.textFilter.value == S.current.tu_a_z,
            title: S.current.tu_a_z,
            iconSvg: ImageAssets.icArrowDownSvg,
            context: context,
          ),
        ),
        reportLine(),
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 18,
            top: 18,
          ),
          child: filterText(
            isCheck: cubit.textFilter.value == S.current.tu_z_a,
            title: S.current.tu_z_a,
            iconSvg: ImageAssets.icArrowUpSvg,
            context: context,
          ),
        ),
        reportLine(),
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 18,
            top: 18,
          ),
          child: filterText(
            isCheck: cubit.textFilter.value == S.current.sap_xep_theo_moi_nhat,
            title: S.current.sap_xep_theo_moi_nhat,
            iconSvg: ImageAssets.icTimeBaoCaoSvg,
            context: context,
          ),
        ),
        reportLine(),
        Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 18,
            top: 18,
          ),
          child: filterText(
            isCheck: cubit.textFilter.value == S.current.sap_xep_theo_cu_nhat,
            title: S.current.sap_xep_theo_cu_nhat,
            iconSvg: ImageAssets.icTimeBaoCaoSvg,
            context: context,
          ),
        ),
        reportLine(),
        spaceH30,
      ],
    );
  }

  Widget filterText({
    required bool isCheck,
    required String title,
    required String iconSvg,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        cubit.textFilter.add(title);
        cubit.getStatus(title);
        cubit.getListReport();
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
}
