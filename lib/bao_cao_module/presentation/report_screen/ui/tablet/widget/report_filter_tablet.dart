import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_filter.dart';
import 'package:flutter/material.dart';

class ReportFilterTablet extends StatelessWidget {
  final ReportListCubit cubit;

  const ReportFilterTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: double.infinity / 2,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ItemFilter(
          cubit: cubit,
          isIconClose: true,
        ),
      ),
    );
  }
}
