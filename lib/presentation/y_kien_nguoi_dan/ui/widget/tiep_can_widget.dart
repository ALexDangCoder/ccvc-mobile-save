import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

import 'bao_cao_thong_ke/status_widget.dart';
import 'status_pakn.dart';
class TiepCanWidget extends StatefulWidget {
  const TiepCanWidget({Key? key}) : super(key: key);

  @override
  _TiepCanWidgetState createState() => _TiepCanWidgetState();
}

class _TiepCanWidgetState extends State<TiepCanWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Text(
            S.current.tiep_nhan,
            style: textNormalCustom(
              color: color667793,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              height: 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  8,
                      (index) => const MySeparator(
                    color: colorECEEF7,
                    height: 2,
                  ),
                ),
              ),
            ),
            statusWidget([
              ChartData(
                S.current.cho_trinh_ky,
                30,
                color02C5DD,
              ),
              ChartData(
                S.current.cho_xu_ly,
                12,
                color5A8DEE,
              ),
              ChartData(
                S.current.da_xu_ly,
                14,
                color28C76F,
              ),
              ChartData(
                S.current.cho_cap_so,
                14,
                colorFF6D99,
              ),
              ChartData(
                S.current.cho_ban_hanh,
                14,
                color374FC7,
              )
            ]),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StatusWidget(
          listData: [
            ChartData(
              S.current.qua_han,
              14,
              colorEA5455,
            ),
            ChartData(
              S.current.den_han,
              14,
              colorD4DAE3,
            ),
            ChartData(
              S.current.trong_han,
              14,
              color02C5DD,
            ),
          ],
        ),
      ],
    );
  }
}
