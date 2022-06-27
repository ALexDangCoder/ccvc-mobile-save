import 'package:ccvc_mobile/bao_cao_module/config/resources/color.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_report_share_favorite.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:flutter/material.dart';

class ShowMoreBottomSheetMobile extends StatefulWidget {
  const ShowMoreBottomSheetMobile({
    Key? key,
    required this.reportItem,
    required this.cubit,
    required this.isFavorite,
  }) : super(key: key);
  final ReportItem reportItem;
  final ReportListCubit cubit;
  final bool isFavorite;

  @override
  State<ShowMoreBottomSheetMobile> createState() =>
      _ShowMoreBottomSheetMobileState();
}

class _ShowMoreBottomSheetMobileState extends State<ShowMoreBottomSheetMobile> {
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
          ItemReportShareFavorite(
            reportItem: widget.reportItem,
            cubit: widget.cubit,
            isFavorite: widget.isFavorite,
          ),
        ],
      ),
    );
  }
}
