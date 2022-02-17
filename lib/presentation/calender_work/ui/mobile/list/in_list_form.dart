import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/list/widget/custom_item_calender_work_mobile.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InListForm extends StatefulWidget {
  const InListForm({Key? key}) : super(key: key);

  @override
  _InListFormState createState() => _InListFormState();
}

class _InListFormState extends State<InListForm> {
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
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
            child: Text(
              _cubit.textDay,
              style: textNormalCustom(color: textBodyTime),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cubit.listMeeting.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomItemCalenderMobile(
                      title: _cubit.listMeeting[index].title,
                      dateTimeFrom:
                          DateTime.parse(_cubit.listMeeting[index].dateTimeFrom)
                              .toStringWithAMPM,
                      dateTimeTo:
                          DateTime.parse(_cubit.listMeeting[index].dateTimeTo)
                              .toStringWithAMPM,
                      urlImage:
                          'https://th.bing.com/th/id/R.91e66c15f578d577c2b40dcf097f6a98?rik=41oluNFG8wUvYA&pid=ImgRaw&r=0',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const ChiTietLichLamViecScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
