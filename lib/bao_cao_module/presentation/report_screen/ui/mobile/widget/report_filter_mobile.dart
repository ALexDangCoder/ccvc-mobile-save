import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_filter.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class ReportFilterMobile extends StatelessWidget {
  const ReportFilterMobile({
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
          ItemFilter(cubit: cubit),
        ],
      ),
    );
  }
}
