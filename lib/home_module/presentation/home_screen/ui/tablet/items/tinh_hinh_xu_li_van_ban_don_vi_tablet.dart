import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_widget.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';

class TinhHInhXuLyVanBanDonViTablet extends StatefulWidget {
  final WidgetType homeItemType;

  const TinhHInhXuLyVanBanDonViTablet({
    required this.homeItemType,
    Key? key,
  }) : super(key: key);

  @override
  State<TinhHInhXuLyVanBanDonViTablet> createState() =>
      _VanBanDonViTabletState();
}

class _VanBanDonViTabletState extends State<TinhHInhXuLyVanBanDonViTablet> {
  // late HomeCubit cubit;
  final VanBanDonViCubit _vanBanDonViCubit = VanBanDonViCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        // _vanBanDonViCubit.getDocument();
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // cubit = HomeProvider.of(context).homeCubit;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _vanBanDonViCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ContainerBackgroundTabletWidget(
        title: S.current.van_ban_don_vi,
        onTapIcon: () {
          // cubit.showDialog(widget.homeItemType);
        },
        selectKeyDialog: _vanBanDonViCubit,
        dialogSelect: StreamBuilder(
            stream: _vanBanDonViCubit.selectKeyDialog,
            builder: (context, snapshot) {
              return DialogSettingWidget(
                type: widget.homeItemType,
                listSelectKey: <DialogData>[
                  DialogData(
                    onSelect: (value, startDate, endDate) {
                      _vanBanDonViCubit.selectDate(
                          selectKey: value,
                          startDate: startDate,
                          endDate: endDate);
                    },
                    title: S.current.time,
                    initValue: _vanBanDonViCubit.selectKeyTime,
                    startDate: _vanBanDonViCubit.startDate,
                    endDate: _vanBanDonViCubit.endDate,
                  )
                ],
              );
            }),
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 63,
              ),
              Expanded(
                child: titleChart(
                  S.current.document_incoming,
                  Column(
                    children: [
                      PieChart(
                        paddingTop: 0,
                        chartData: [
                          ChartData(
                            S.current.cho_vao_so,
                            14,
                            choVaoSoColor,
                            SelectKey.CHO_VAO_SO,
                          ),
                          ChartData(
                            S.current.dang_xu_ly,
                            7,
                            dangXyLyColor,
                            SelectKey.DANG_XU_LY,
                          ),
                          ChartData(
                            S.current.da_xu_ly,
                            7,
                            daXuLyColor,
                            SelectKey.DA_XU_LY,
                          ),
                        ],
                        onTap: (value, key) {},
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      StatusWidget(
                        showZeroValue: false,
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
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: titleChart(
                  S.current.document_out_going,
                  PieChart(
                    chartData: [
                      ChartData(
                        S.current.cho_trinh_ky,
                        30,
                        choTrinhKyColor,
                        SelectKey.CHO_TRINH_KY,
                      ),
                      ChartData(
                        S.current.cho_xu_ly,
                        12,
                        choXuLyColor,
                        SelectKey.CHO_XU_LY,
                      ),
                      ChartData(
                        S.current.da_xu_ly,
                        14,
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
                    ],
                    onTap: (value, key) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusWidget(List<ChartData> listData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            children: listData
                .map(
                  (e) => Expanded(
                    flex: e.value.toInt(),
                    child: Container(
                      color: e.color,
                      child: Center(
                        child: Text(
                          e.value.toInt().toString(),
                          style: textNormal(
                            backgroundColorApp,
                            14.0.textScale(),
                          ),
                        ),
                      ),
                    ),
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

  Widget titleChart(String title, Widget child) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textNormalCustom(
              color: infoColor,
              fontSize: 16,
            ),
          ),
          child
        ],
      ),
    );
  }
}
