import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/type_list_view/pop_up_menu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
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
                itemBuilder: (context, item, index) => GestureDetector(
                  onTap: () {
                    // push detail screen
                  },
                  child: itemList(item),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemList(ListLichLVModel item) {
    return GestureDetector(
      onTap: (){
        final TypeCalendar typeAppointment =
        getType(item.typeSchedule ?? 'Schedule');
        if (typeAppointment == TypeCalendar.Schedule) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietLichLamViecScreen(
                id: item.id  ?? '',
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMeetCalenderScreen(
                id: item.id ?? '',
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 21),
        padding: const EdgeInsets.only(top: 16, left: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColorApp,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: borderItemCalender),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusCalenderRed,
                    ),
                  ),
                ),
              ],
            ),
            spaceW8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          item.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textNormalCustom(
                            color: titleCalenderWork,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: item.isTrung
                            ? Container(
                                padding: const EdgeInsets.only(top: 3, left: 15),
                                decoration: BoxDecoration(
                                  color: statusCalenderRed.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: statusCalenderRed.withOpacity(0.1),
                                  ),
                                ),
                                height: 24,
                                child: Text(
                                  S.current.trung,
                                  style: textNormalCustom(
                                    color: statusCalenderRed,
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      spaceW16
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      '${item.dateTimeFrom} - ${item.dateTimeTo}',
                      style: textNormalCustom(
                        color: textBodyTime,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    height: 24.0,
                    width: 24.0,
                    decoration: const  BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('',),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
