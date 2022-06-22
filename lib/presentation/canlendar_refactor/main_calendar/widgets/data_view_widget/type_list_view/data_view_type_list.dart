import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DataViewTypeList extends StatefulWidget {
  const DataViewTypeList({Key? key, required this.cubit}) : super(key: key);

  final CalendarWorkCubit cubit;

  @override
  State<DataViewTypeList> createState() => _DataViewTypeListState();
}

class _DataViewTypeListState extends State<DataViewTypeList> {


  @override
  void initState() {
    widget.cubit.worksPagingController.addPageRequestListener((pageKey) {
      widget.cubit.getListWorkLoadMore(
        pageIndex: pageKey,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: widget.cubit.isLichDuocMoiStream,
              builder: (context, snapshot) {
                final isLichDuocMoi = snapshot.data ?? false;
                if (isLichDuocMoi) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: StreamBuilder<DashBoardLichHopModel>(
                        stream: widget.cubit.totalWorkStream,
                        builder: (context, snapshot) {
                          final data =
                              snapshot.data ?? DashBoardLichHopModel.empty();
                          return PopUpMenu(
                            data: [
                              ItemMenuData(
                                StateType.CHO_XAC_NHAN,
                                data.soLichChoXacNhan ?? 0,
                              ),
                              ItemMenuData(
                                StateType.THAM_GIA,
                                data.soLichThamGia ?? 0,
                              ),
                              ItemMenuData(
                                StateType.TU_CHOI,
                                data.soLichTuChoi ?? 0,
                              ),
                            ],
                            onChange: (type) {
                              widget.cubit.stateType = type;
                              widget.cubit.worksPagingController.refresh();
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            PagedListView<int, ListLichLVModel>(
              pagingController: widget.cubit.worksPagingController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<ListLichLVModel>(
                noItemsFoundIndicatorBuilder: (_) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: NodataWidget(),
                ),
                itemBuilder: (context, item, index) => Container(
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
