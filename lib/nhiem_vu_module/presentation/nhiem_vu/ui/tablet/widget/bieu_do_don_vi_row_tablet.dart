import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/dash_broash/dash_broash_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoNhiemVuDonViRowTablet extends StatefulWidget {
  final DanhSachCubit cubit;
  final List<ChartData> chartData;
  final Function(String) ontap;
  final Function(int) onTapStatusBox;

  const BieuDoNhiemVuDonViRowTablet({
    Key? key,
    required this.cubit,
    required this.chartData,
    required this.ontap,
    required this.onTapStatusBox,
  }) : super(key: key);

  @override
  _BieuDoNhiemVuDonViRowTabletState createState() =>
      _BieuDoNhiemVuDonViRowTabletState();
}

class _BieuDoNhiemVuDonViRowTabletState
    extends State<BieuDoNhiemVuDonViRowTablet> {
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
            child: StreamBuilder<List<ChartData>>(
              stream: widget.cubit.statusSuject,
              initialData: widget.chartData,
              builder: (context, snapshot) {
                return PieChart(
                  isSubjectInfo: false,
                  chartData: widget.chartData,
                  onTap: (int value) {
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                StreamBuilder<List<LoaiNhiemVuComomModel>>(
                  stream: widget.cubit.loaiNhiemVuSuject,
                  initialData: listFakeData,
                  builder: (context, snapshot) {
                    final data = snapshot.data?.reversed ?? [];
                    return Row(
                      children: data
                          .map(
                            (e) => Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 16),
                                child: BoxStatusVanBan(
                                  value: e.value ?? 0,
                                  onTap: () {
                                    widget.onTapStatusBox(
                                        (e.giaTri ?? '').statusBox());
                                  },
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
                SizedBox(height: 28),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 9,
                  mainAxisSpacing: 10.0.textScale(space: 4),
                  crossAxisSpacing: 10,
                  children: List.generate(widget.chartData.length, (index) {
                    final result = widget.chartData[index];
                    return GestureDetector(
                      onTap: () {
                        widget.ontap(widget.cubit.chartData[index].title
                            .split(' ')
                            .join('_')
                            .toUpperCase()
                            .vietNameseParse());
                      },
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
                                '${result.title.split(' ').join('_').toUpperCase().vietNameseParse().titleTrangThai()} (${result.value.toInt()})',
                                style: textNormal(
                                  infoColor,
                                  14.0.textScale(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
