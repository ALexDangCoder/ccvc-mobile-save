import 'package:ccvc_mobile/home_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/dash_broash/dash_broash_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoTrangThaiTheoLoaiMobile extends StatefulWidget {
  final DanhSachCubit cubit;
  final List<ChartData> chartData;
  final Function(String) ontap;


  const BieuDoTrangThaiTheoLoaiMobile({
    Key? key,
    required this.cubit,
    required this.chartData,
    required this.ontap,
  }) : super(key: key);

  @override
  _BieuDoTrangThaiTheoLoaiMobileState createState() => _BieuDoTrangThaiTheoLoaiMobileState();
}

class _BieuDoTrangThaiTheoLoaiMobileState extends State<BieuDoTrangThaiTheoLoaiMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChart(
            chartData: widget.chartData,
            onTap: (int value) {
              widget.ontap(widget.chartData[value].title
                  .split(' ')
                  .join('_')
                  .toUpperCase()
                  .vietNameseParse());
            },
          ),
        ],
      ),
    );
  }
}
