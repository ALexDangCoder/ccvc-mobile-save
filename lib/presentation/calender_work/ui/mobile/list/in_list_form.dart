import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/extension/ultis_ext.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/list/widget/custom_item_calender_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/type_calendar.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InListForm extends StatefulWidget {
  final CalenderCubit cubit;
  final Type_Choose_Option_Day type;
  final Function onTap;

  const InListForm({
    Key? key,
    required this.cubit,
    required this.onTap,
    required this.type,
  }) : super(key: key);

  @override
  _InListFormState createState() => _InListFormState();
}

class _InListFormState extends State<InListForm> {
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
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cubit.changeItemMenuSubject.value.getHeader(
            cubit: _cubit,
            type: widget.type,
          ),
          const SizedBox(
            height: 10,
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
                      child: CustomItemCalenderMobile(
                        title: _cubit.dataLichLvModel.listLichLVModel?[index]
                                .title ??
                            '',
                        dateTimeFrom: DateTime.parse(
                          _cubit.dataLichLvModel.listLichLVModel?[index]
                                  .dateTimeFrom ??
                              '',
                        ).toStringWithAMPM,
                        dateTimeTo: DateTime.parse(
                          _cubit.dataLichLvModel.listLichLVModel?[index]
                                  .dateTimeTo ??
                              '',
                        ).toStringWithAMPM,
                        urlImage:
                            'https://th.bing.com/th/id/R.91e66c15f578d577c2b40dcf097f6a98?rik=41oluNFG8wUvYA&pid=ImgRaw&r=0',
                        onTap: () {
                          final String typeCalendar = _cubit.dataLichLvModel
                                  .listLichLVModel?[index].typeSchedule ??
                              'Schedule';

                          typeCalendar.getTypeCalendar
                              .navigatorDetail(context, _cubit, index);
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
          ),
        ],
      ),
    );
  }
}
