import 'package:ccvc_mobile/bao_cao_module/domain/model/report_item.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/bloc/report_list_cubit.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_detail_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_screen_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_web_view_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_gridview.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/widget/item_list.dart';
import 'package:ccvc_mobile/bao_cao_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ReportListMobile extends StatelessWidget {
  final bool isListView;
  final List<ReportItem> listReport;
  final ScrollPhysics? scrollPhysics;
  final ReportListCubit cubit;
  final String idFolder;
  final bool isTree;

  const ReportListMobile({
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
        : noData();
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
            return ReportDetailMobile(
              title: value.name ?? '',
              cubit: cubit,
              idFolder: value.id ?? '',
              isListView: isListView,
            );
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ReportWebViewMobile(
              cubit: cubit,
              idReport: value.id ?? '',
              title: value.name ?? '',
            );
          },
        ),
      );
    }
  }
}
