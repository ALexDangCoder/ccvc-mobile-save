import 'package:ccvc_mobile/domain/model/lich_hop/lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/widget_item_lich_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DanhSachLichHopTablet extends StatefulWidget {
  const DanhSachLichHopTablet({Key? key}) : super(key: key);

  @override
  _DanhSachLichHopTabletState createState() => _DanhSachLichHopTabletState();
}

class _DanhSachLichHopTabletState extends State<DanhSachLichHopTablet> {
  LichHopCubit cubit = LichHopCubit();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.only( right: 30.0, left: 30.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listLichHop.length,
              itemBuilder: (context, index) {
                return WidgetItemLichHop(
                  ontap: () {},
                  title: listLichHop[index].title,
                  dateTimeFrom:
                  DateTime.parse(listLichHop[index].dateTimeFrom)
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
