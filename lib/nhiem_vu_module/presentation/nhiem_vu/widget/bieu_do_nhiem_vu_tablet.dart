import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/dash_broash/dash_broash_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoNhiemVuTablet extends StatefulWidget {
  final DanhSachCubit cubit;
  final String? title;
  final List<ChartData> chartData;
  final bool isCheck;

  const BieuDoNhiemVuTablet({
    Key? key,
    required this.cubit,
    this.title,
    required this.chartData,
    required this.isCheck,
  }) : super(key: key);

  @override
  _BieuDoNhiemVuTabletState createState() => _BieuDoNhiemVuTabletState();
}

class _BieuDoNhiemVuTabletState extends State<BieuDoNhiemVuTablet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isCheck)
                Flexible(
                  flex: 5,
                  child: PieChart(
                    title: widget.title ?? '',
                    chartData: widget.chartData,
                    onTap: (int value) {},
                  ),
                )
              else
                Flexible(
                  flex: 5,
                  child: PieChart(
                    title: widget.title ?? '',
                    chartData: widget.chartData,
                    onTap: (int value) {},
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              if (widget.isCheck)
                Expanded(
                  child: StreamBuilder<List<LoaiNhiemVuComomModel>>(
                    stream: widget.cubit.loaiNhiemVuCaNhanSuject,
                    initialData: listFakeData,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return Row(
                        children: data
                            .map(
                              (e) => Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: BoxStatusVanBan(
                                    value: e.value ?? 0,
                                    onTap: () {},
                                    color: (e.giaTri ?? '').status(),
                                    statusName: e.text ?? '',
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                )
              else
                Expanded(
                  child: StreamBuilder<List<LoaiNhiemVuComomModel>>(
                    stream: widget.cubit.loaiCongViecCaNhanSuject,
                    initialData: listFakeData,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      return Row(
                        children: data
                            .map(
                              (e) => Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 30,
                                    right: 20,
                                  ),
                                  child: BoxStatusVanBan(
                                    value: e.value ?? 0,
                                    onTap: () {},
                                    color: (e.giaTri ?? '').status(),
                                    statusName: e.text ?? '',
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
