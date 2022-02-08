import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/calender_work_day_list/mobile/widget/custom_item_calender_list.dart';
import 'package:ccvc_mobile/presentation/calender_work/calender_work_day/ui/widget/custom_item_calender_work_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InListFormTablet extends StatefulWidget {
  bool isHindText = false;

  InListFormTablet({Key? key, required this.isHindText}) : super(key: key);

  @override
  _InListFormTabletState createState() => _InListFormTabletState();
}

class _InListFormTabletState extends State<InListFormTablet> {
  final CalenderCubit _cubit = CalenderCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 88,
              width: MediaQuery.of(context).size.width - 16,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _cubit.list.length,
                itemBuilder: (context, index) {
                  return CustomItemCalenderWorkTablet(
                    image: _cubit.img[index],
                    typeName: _cubit.list[index].typeName,
                    numberOfCalendars: _cubit.list[index].numberOfCalendars,
                  );
                },
              ),
            ),
          ),
          spaceH28,
          Container(
            height: 1,
            color: bgDropDown,
          ),
          spaceH28,
          if (widget.isHindText)
            Container()
          else
            Container(
              padding: const EdgeInsets.only(bottom: 28),
              child: Text(
                _cubit.currentTime,
                style: textNormalCustom(color: textBodyTime),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _cubit.listMeeting.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomItemCalenderTablet(
                      title: _cubit.listMeeting[index].title,
                      dateTimeFrom: DateTime.parse(
                        _cubit.listMeeting[index].dateTimeFrom,
                      ).toStringWithAMPM,
                      dateTimeTo:
                          DateTime.parse(_cubit.listMeeting[index].dateTimeTo)
                              .toStringWithAMPM,
                      urlImage:
                          'https://lh3.googleusercontent.com/ogw/ADea4I7KuOHLBX4h7PqlUfbDpmYAuuvb9iBc5eaCvicoFg=s192-c-mo',
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
