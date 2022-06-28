import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_report_share_favorite.dart';
import 'package:flutter/material.dart';

class ShowMoreBottomSheetTablet extends StatelessWidget {
  final ReportItem reportItem;
  final ReportListCubit cubit;
  final bool isFavorite;

  const ShowMoreBottomSheetTablet({
    Key? key,
    required this.cubit,
    required this.reportItem,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: MediaQuery.of(context).size.width/ 2,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ItemReportShareFavorite(
          isIconClose: true,
          cubit: cubit,
          isFavorite: isFavorite,
          reportItem: reportItem,
        ),
      ),
    );
  }
}
