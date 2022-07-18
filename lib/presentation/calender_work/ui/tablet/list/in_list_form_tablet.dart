import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/ultis_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/list/widget/custom_item_calender_list.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/type_calendar.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InListFormTablet extends StatefulWidget {
  bool isHindText = false;
  final CalenderCubit cubit;
  final Function onTap;

  InListFormTablet({
    Key? key,
    required this.isHindText,
    required this.cubit,
    required this.onTap,
  }) : super(key: key);

  @override
  _InListFormTabletState createState() => _InListFormTabletState();
}

class _InListFormTabletState extends State<InListFormTablet> {
  late final CalenderCubit _cubit = widget.cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getDay();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.cubit.page < widget.cubit.totalPage) {
          widget.cubit.page = widget.cubit.page + 1;
          widget.cubit.getListLichLV();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH28,
          _cubit.changeItemMenuSubject.value.getHeaderTablet(
            cubit: _cubit,
            isHindText: widget.isHindText,
          ),
          Expanded(
            child: StreamBuilder<DataLichLvModel>(
              stream: _cubit.streamListLich,
              builder: (context, snapshot) {
                widget.cubit.getMatchDate(_cubit.dataLichLvModel);
                return ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount:
                  _cubit.dataLichLvModel.listLichLVModel?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CustomItemCalenderTablet(
                        title: _cubit.dataLichLvModel.listLichLVModel?[index]
                            .title ??
                            '',
                        dateTimeFrom: DateTime
                            .parse(
                          _cubit.dataLichLvModel.listLichLVModel?[index]
                              .dateTimeFrom ??
                              '',
                        )
                            .toStringWithAMPM,
                        dateTimeTo: DateTime
                            .parse(
                          _cubit.dataLichLvModel.listLichLVModel?[index]
                              .dateTimeTo ??
                              '',
                        )
                            .toStringWithAMPM,
                        urlImage:
                        'https://lh3.googleusercontent.com/ogw/ADea4I7KuOHLBX4h7PqlUfbDpmYAuuvb9iBc5eaCvicoFg=s192-c-mo',
                        onTap: () {
                          final String typeCalendar = _cubit.dataLichLvModel
                              .listLichLVModel?[index].typeSchedule ??
                              'Schedule';
                          typeCalendar.getTypeCalendar.navigatorDetailTablet(
                            context,
                            _cubit,
                            index,
                          );
                        },
                        isTrung: _cubit.dataLichLvModel.listLichLVModel?[index]
                            .isTrung ??
                            false,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
