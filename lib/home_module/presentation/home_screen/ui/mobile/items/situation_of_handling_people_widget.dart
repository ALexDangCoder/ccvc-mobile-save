import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_widget.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class SituationOfHandlingPeopleWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const SituationOfHandlingPeopleWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<SituationOfHandlingPeopleWidget> createState() =>
      _SituationOfHandlingPeopleWidgetState();
}

class _SituationOfHandlingPeopleWidgetState
    extends State<SituationOfHandlingPeopleWidget> {
  final TinhHinhXuLyYKienCubit _yKienCubit = TinhHinhXuLyYKienCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yKienCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _yKienCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 420,
      title: S.current.tinh_hinh_pakn_ca_nhan,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isShowSubTitle: false,
      selectKeyDialog: _yKienCubit,
      child: LoadingOnly(
        stream: _yKienCubit.stateStream,
        child: StreamBuilder<List<TinhHinhYKienModel>>(
            stream: _yKienCubit.getTinhHinhXuLy,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <TinhHinhYKienModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      S.current.tiep_nhan,
                      style: textNormalCustom(
                        color: dateColor,
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
                              color: lineColor,
                              height: 2,
                            ),
                          ),
                        ),
                      ),
                      statusWidget([
                        ChartData(
                          S.current.cho_trinh_ky,
                          30,
                          choTrinhKyColor,
                          SelectKey.CHO_TRINH_KY,
                        ),
                        ChartData(
                          S.current.cho_xu_ly,
                          10,
                          choXuLyColor,
                          SelectKey.CHO_XU_LY,
                        ),
                        ChartData(
                          S.current.da_xu_ly,
                          10,
                          daXuLyColor,
                          SelectKey.DA_XU_LY,
                        ),
                        ChartData(
                          S.current.cho_cap_so,
                          14,
                          choCapSoColor,
                          SelectKey.CHO_CAP_SO,
                        ),
                        ChartData(
                          S.current.cho_ban_hanh,
                          14,
                          choBanHanhColor,
                          SelectKey.CHO_BAN_HANH,
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
                        statusCalenderRed,
                        SelectKey.CHO_VAO_SO,
                      ),
                      ChartData(
                        S.current.den_han,
                        14,
                        yellowColor,
                        SelectKey.DANG_XU_LY,
                      ),
                      ChartData(
                        S.current.trong_han,
                        14,
                        choTrinhKyColor,
                        SelectKey.DA_XU_LY,
                      ),
                    ],
                  ),
                  PieChart(
                    title: S.current.xu_ly,
                    chartData: [
                      ChartData(
                        S.current.cho_tiep_nhan_xu_ly,
                        14,
                        choTrinhKyColor,
                      ),
                      ChartData(
                        S.current.cho_xu_ly,
                        14,
                        numberOfCalenders,
                      ),
                      ChartData(
                        S.current.cho_phan_xu_ly,
                        14,
                        radioFocusColor,
                      ),
                      ChartData(
                        S.current.cho_duyet,
                        14,
                        choCapSoColor,
                      ),
                      ChartData(
                        S.current.da_phan_cong,
                        14,
                        choBanHanhColor,
                      ),
                      ChartData(
                        S.current.da_hoan_thanh,
                        14,
                        itemWidgetUsing,
                      ),
                    ],
                  )
                ],
              );
              // return PieChart(
              //   chartData: List.generate(
              //     data.length,
              //     (index) {
              //       final result = data[index];
              //       final color = TinhHinhYKienModel.listColor[index];
              //       return ChartData(
              //         result.status,
              //         result.soLuong.toDouble(),
              //         color,
              //       );
              //     },
              //   ),
              //   onTap: (value, key) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => DanhSachYKND(
              //           endDate: _yKienCubit.endDate.toString(),
              //           startDate: _yKienCubit.startDate.toString(),
              //         ),
              //       ),
              //     );
              //   },
              // );
            }),
      ),
    );
  }
}

Widget statusWidget(List<ChartData> listData) {
  final data = listData.map((e) => e.value).toList();
  final total = data.reduce((a, b) => a + b);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: listData
              .map(
                (e) => Row(
                  children: [
                    Container(
                      height: 260,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lineColor,
                      ),
                      // color: e.color,
                      child: Column(
                        children: [
                          Expanded(
                            flex: (total - (e.value)).toInt(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FittedBox(
                                  child: Text(
                                    e.value.toInt().toString(),
                                    style: textNormal(
                                      textTitleColumn,
                                      14.0.textScale(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: e.value.toInt(),
                            child: Container(
                              width: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: e.color,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 9,
        mainAxisSpacing: 10.0.textScale(space: 4),
        crossAxisSpacing: 10,
        children: List.generate(listData.length, (index) {
          final result = listData[index];
          // ignore: avoid_unnecessary_containers
          return GestureDetector(
            onTap: () {},
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
          );
        }),
      ),
    ],
  );
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
