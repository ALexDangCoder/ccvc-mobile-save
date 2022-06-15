import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_list.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/detail_item_mobile.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/report_item.dart';
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  final bool isCheckList;
  final List<ReportItem> listReport;
  final ScrollPhysics? scrollPhysics;

  const ReportList({
    Key? key,
    required this.isCheckList,
    required this.listReport,
    this.scrollPhysics,
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
            physics: scrollPhysics,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 17,
              crossAxisSpacing: 17,
              childAspectRatio: 1.5,
              mainAxisExtent: 130,
            ),
            itemCount: listReport.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DetailItemMobile(),
                    ),
                  );
                },
                child: ItemGridView(
                  item: listReport[index],
                ),
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
              physics: scrollPhysics,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DetailItemMobile(),
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
