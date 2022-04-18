import 'package:ccvc_mobile/home_module/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CoCauLichHopWidget extends StatelessWidget {
  final LichHopCubit cubit;

  const CoCauLichHopWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: StreamBuilder<List<ChartData>>(
        stream: cubit.coCauLichHopSubject.stream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return PieChart(
            chartData: data,
            onTap: (value) {
              cubit.chooseTypeList(
                Type_Choose_Option_List.DANG_LIST,
              );
              cubit.postDanhSachThongKe(data[value].id ?? '');
            },
            isThongKeLichHop: false,
          );
        },
      ),
    );
  }
}
