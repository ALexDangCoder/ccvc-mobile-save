import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/mobile/grid_view/widget/item_gridview.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/mobile/grid_view/widget/item_list.dart';
import 'package:ccvc_mobile/presentation/bao_cao/ui/widget/item_chi_tiet.dart';
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  final bool isCheckList;
  final List<ReportItem> listReport;

  const ReportList({
    Key? key,
    required this.isCheckList,
    required this.listReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCheckList
        ? GridView.builder(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 17,
              crossAxisSpacing: 17,
              childAspectRatio: 1.5,
              mainAxisExtent: 130,
            ),
            itemCount: listReport.length,
            itemBuilder: (context, index) {
              return ItemGridView(
                item: listReport[index],
              );
            },
          )
        : Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: ListView.builder(
              itemCount: listReport.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ItemChiTiet(),
                      ),
                    );
                  },
                  child: ItemList(
                    item: listReport[index],
                  ),
                );
              },
            ),
          );
  }
}
