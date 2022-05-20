import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/chart_by_group_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/chart_by_month_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/menu_my_calendar/co_cau_lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/ti_le_tham_du_widget.dart';
import 'package:flutter/material.dart';

class ThongKeLichHopScreen extends StatefulWidget {
  final LichHopCubit cubit;

  const ThongKeLichHopScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThongKeLichHopScreenState createState() => _ThongKeLichHopScreenState();
}

class _ThongKeLichHopScreenState extends State<ThongKeLichHopScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textviewTitle(S.current.so_lich_hop_theo_thoi_gian_trong_nam),
          ChartByMonthWidget(
            cubit: widget.cubit,
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: colorEEF3FF,
          ),
          textviewTitle(S.current.so_lich_hop_duoc_to_chuc_boi_cac_don_vi),
          ChartByGroupWidget(
            cubit: widget.cubit,
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: colorEEF3FF,
          ),
          textviewTitle(S.current.co_cau_lich_hop),
          CoCauLichHopWidget(
            cubit: widget.cubit,
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: colorEEF3FF,
          ),
          textviewTitle(S.current.ti_le_tham_du_cua_cac_don_vi),

          TiLeThamDuWidget(cubit: widget.cubit,),
        ],
      ),
    );
  }

  Widget textviewTitle(String title) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Text(
        title,
        style: textNormalCustom(
          color: color3D5586,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.cubit.listDSLH.clear();
  }
}
