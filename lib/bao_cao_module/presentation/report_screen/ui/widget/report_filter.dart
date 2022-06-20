import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/show_more_bottom_sheet.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReportFilter extends StatelessWidget {
  const ReportFilter({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ReportListCubit cubit;

  @override
  Widget build(BuildContext context) {
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
              isCheck: cubit.textFilter.value == S.current.tu_a_z,
              title: S.current.tu_a_z,
              iconSvg: ImageAssets.icArrowDownSvg,
              context: context,
            ),
          ),
          reportLine,
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
          reportLine,
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 18,
              top: 18,
            ),
            child: filterText(
              isCheck:
                  cubit.textFilter.value == S.current.sap_xep_theo_moi_nhat,
              title: S.current.sap_xep_theo_moi_nhat,
              iconSvg: ImageAssets.icTimeBaoCaoSvg,
              context: context,
            ),
          ),
          reportLine,
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
          reportLine,
          spaceH30,
        ],
      ),
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
