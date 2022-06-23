import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_detail_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/widget/item_list.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReportList extends StatelessWidget {
  final bool isListView;
  final List<ReportItem> listReport;
  final ScrollPhysics? scrollPhysics;
  final ReportListCubit cubit;
  final String idFolder;
  final bool isTree;

  const ReportList({
    Key? key,
    required this.isListView,
    required this.listReport,
    this.scrollPhysics,
    required this.cubit,
    required this.idFolder,
    this.isTree = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listReport.isNotEmpty
        ? isListView
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
                    onTap: () => clickItemDetail(
                      context: context,
                      idFolder: idFolder,
                      value: listReport[index],
                    ),
                    child: ItemGridView(
                      item: listReport[index],
                      cubit: cubit,
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
                      onTap: () => clickItemDetail(
                        context: context,
                        idFolder: idFolder,
                        value: listReport[index],
                      ),
                      child: ItemList(
                        item: listReport[index],
                        cubit: cubit,
                      ),
                    );
                  },
                ),
              )
        : const SizedBox.shrink();
  }

  void clickItemDetail({
    required BuildContext context,
    required String idFolder,
    required ReportItem value,
  }) {
    if (value.type == FOLDER) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ReportDetail(
              title: value.name ?? '',
              cubit: cubit,
              doanhId: value.id ?? '',
              isListView: isListView,
            );
          },
        ),
      ).then((v) {
        if (isTree) {
          cubit.getListReport(
            isTree: isTree,
            idFolder: idFolder,
          );
        }
      });
    } else {
      //todo report
    }
  }
}
