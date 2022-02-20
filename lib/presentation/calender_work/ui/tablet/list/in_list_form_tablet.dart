import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/tablet/list/widget/custom_item_calender_list.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.getDay();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH28,
          if (widget.isHindText)
            Container()
          else
            Container(
              padding: const EdgeInsets.only(bottom: 28),
              child: Text(
                _cubit.textDay,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const ChiTietLamViecTablet(),
                          ),
                        );
                      },
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
