import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/widget_item_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class LichHopTheoDanhSachNgay extends StatelessWidget {
  const LichHopTheoDanhSachNgay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LichHopCubit cubit = LichHopCubit();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Text(
              cubit.currentTime,
              style: textNormalCustom(color: textBodyTime),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listLichHop.length,
              itemBuilder: (context, index) {
                return WidgetItemLichHop(
                  ontap: () {},
                  title: listLichHop[index].title,
                  dateTimeFrom: DateTime.parse(
                    listLichHop[index].dateTimeFrom,
                  ).toStringWithAMPM,
                  dateTimeTo: DateTime.parse(
                    listLichHop[index].dateTimeTo,
                  ).toStringWithAMPM,
                  urlImage: listLichHop[index].urlImage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
