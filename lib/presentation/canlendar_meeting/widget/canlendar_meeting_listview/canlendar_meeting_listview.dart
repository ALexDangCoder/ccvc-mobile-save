import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_lich_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class DataViewTypeList extends StatefulWidget {
  const DataViewTypeList({Key? key, required this.cubit}) : super(key: key);

  final CalendarMeetingCubit cubit;

  @override
  State<DataViewTypeList> createState() => _DataViewTypeListState();
}

DateTime getOnlyDate(String dateString) {
  final date = dateString.convertStringToDate(
    formatPattern: DateTimeFormat.DATE_TIME_RECEIVE,
  );
  return DateTime(date.year, date.month, date.day);
}

class _DataViewTypeListState extends State<DataViewTypeList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: StreamBuilder<DanhSachLichHopModel>(
        stream: widget.cubit.danhSachLichHopStream,
        builder: (context, snapshot) {
          final data = snapshot.data?.items ?? [];
          if (data.isNotEmpty) {
            return GroupedListView<ItemDanhSachLichHop, DateTime>(
              elements: data,
              groupBy: (e) => getOnlyDate(e.dateTimeTo ?? ''),
              itemBuilder: (_, element) {
                return itemList(element);
              },
              groupComparator: (value1, value2) => value1.compareTo(value2),
              groupSeparatorBuilder: (groupValue) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  groupValue.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,),
                ),
              ),
            );
          } else {
            return const NodataWidget();
          }
        },
      ),
    );
  }

  Widget itemList(ItemDanhSachLichHop item) {
    return GestureDetector(
      onTap: () {
        if (isMobile()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMeetCalenderScreen(
                id: item.id ?? '',
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMeetCalenderTablet(
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
                        child: item.isTrung ?? false
                            ? Container(
                                padding:
                                    const EdgeInsets.only(top: 3, left: 15),
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
                      '${item.dateTimeFrom?.changeToNewPatternDate(
                        DateTimeFormat.DATE_TIME_RECEIVE,
                        DateTimeFormat.DATE_DD_MM_HM,
                      )} - ${item.dateTimeTo?.changeToNewPatternDate(
                        DateTimeFormat.DATE_TIME_RECEIVE,
                        DateTimeFormat.DATE_DD_MM_HM,
                      )}',
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
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '',
                        ),
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
