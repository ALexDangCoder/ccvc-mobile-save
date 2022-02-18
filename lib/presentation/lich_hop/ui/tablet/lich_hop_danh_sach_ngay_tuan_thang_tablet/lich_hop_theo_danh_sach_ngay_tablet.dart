import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/widget_item_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class LichHopTheoDanhSachNgayTablet extends StatelessWidget {
  const LichHopTheoDanhSachNgayTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listLichHop.length,
              itemBuilder: (context, index) {
                return WidgetItemLichHop(
                  ontap: () {},
                  title: listLichHop[index].title,
                  dateTimeFrom: DateTime.parse(listLichHop[index].dateTimeFrom)
                      .toStringWithAMPM,
                  dateTimeTo: DateTime.parse(listLichHop[index].dateTimeTo)
                      .toStringWithAMPM,
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
