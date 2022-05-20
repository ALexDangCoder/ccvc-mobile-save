import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/chart_by_month_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/menu_my_calendar/co_cau_lich_hop_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/widget/ti_le_tham_du_widget.dart';
import 'package:flutter/material.dart';

class ThongKeLichHopTablet extends StatelessWidget {
  final LichHopCubit cubit;

  const ThongKeLichHopTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 28,
              mainAxisSpacing: 28,
              shrinkWrap: true,
              childAspectRatio: 4 / 5,
              children: [
                containerChart(
                  children: [
                    textviewTitle(
                      S.current.so_lich_hop_theo_thoi_gian_trong_nam,
                    ),
                    ChartByMonthWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
                Expanded(
                  child: containerChart(
                    children: [
                      textviewTitle(S.current.co_cau_lich_hop),
                      CoCauLichHopWidget(
                        cubit: cubit,
                      ),
                    ],
                  ),
                ),
                containerChart(
                  children: [
                    textviewTitle(S.current.ti_le_tham_du_cua_cac_don_vi),
                    TiLeThamDuWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
                containerChart(
                  children: [
                    textviewTitle(
                      S.current.so_lich_hop_theo_thoi_gian_trong_nam,
                    ),
                    ChartByMonthWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget containerChart({
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorDBDFEF.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: color6566E9.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
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
          fontSize: 18,
        ),
      ),
    );
  }
}
