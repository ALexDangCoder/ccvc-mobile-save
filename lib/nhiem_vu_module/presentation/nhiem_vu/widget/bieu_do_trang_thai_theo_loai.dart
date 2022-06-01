import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/cupertino.dart';
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
  _BieuDoTrangThaiTheoLoaiMobileState createState() =>
      _BieuDoTrangThaiTheoLoaiMobileState();
}

class _BieuDoTrangThaiTheoLoaiMobileState
    extends State<BieuDoTrangThaiTheoLoaiMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              isSubjectInfo: false,
              chartData: widget.chartData,
              onTap: (int value) {
                widget.ontap(widget.chartData[value].title
                    .split(' ')
                    .join('_')
                    .toUpperCase()
                    .vietNameseParse());
              },
            ),
          ),
          Expanded(
              child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.chartData.length,
                itemBuilder: (context, index) {
                  final result = widget.chartData[index];
                  return GestureDetector(
                    onTap: () {
                      widget.ontap(widget.chartData[index].title
                          .split(' ')
                          .join('_')
                          .toUpperCase()
                          .vietNameseParse());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                              color: result.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                '${result.title} (${result.value.toInt()})',
                                style: textNormal(
                                  infoColor,
                                  14.0.textScale(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
