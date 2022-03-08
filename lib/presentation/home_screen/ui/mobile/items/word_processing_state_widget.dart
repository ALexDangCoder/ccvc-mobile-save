import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';

import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class WordProcessingStateWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const WordProcessingStateWidget({
    Key? key,
    required this.homeItemType,
  }) : super(key: key);

  @override
  State<WordProcessingStateWidget> createState() =>
      _WordProcessingStateWidgetState();
}

class _WordProcessingStateWidgetState extends State<WordProcessingStateWidget> {
  late HomeCubit cubit;
  final TinhHinhXuLyCubit _xuLyCubit = TinhHinhXuLyCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xuLyCubit.getDocument();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _xuLyCubit.getDocument();
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _xuLyCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.word_processing_state,
      onTapIcon: () {
        cubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _xuLyCubit,
      dialogSelect: StreamBuilder(
          stream: _xuLyCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: <DialogData>[
                DialogData(
                  onSelect: (value, startDate, endDate) {
                    _xuLyCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate);
                  },
                  title: S.current.time,
                  initValue: _xuLyCubit.selectKeyTime,
                )
              ],
            );
          }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleChart(
            S.current.document_incoming,
            LoadingOnly(
              stream: _xuLyCubit.stateStream,
              child: StreamBuilder<DocumentDashboardModel>(
                stream: _xuLyCubit.getDocumentVBDen,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? DocumentDashboardModel();
                  if (snapshot.hasData) {
                    return PieChart(
                      paddingTop: 0,
                      chartData: [
                        ChartData(
                          S.current.cho_xu_ly,
                          data.soLuongChoXuLy?.toDouble() ?? 0,
                          choXuLyColor,
                        ),
                        ChartData(
                          S.current.dang_xu_ly,
                          data.soLuongDangXuLy?.toDouble() ?? 0,
                          dangXyLyColor,
                        ),
                        ChartData(
                          S.current.da_xu_ly,
                          data.soLuongDaXuLy?.toDouble() ?? 0,
                          daXuLyColor,
                        ),
                        ChartData(
                          S.current.cho_vao_so,
                          data.soLuongChoVaoSo?.toDouble() ?? 0,
                          choVaoSoColor,
                        ),
                      ],
                      onTap: (value) {
                      },
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: NodataWidget(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          titleChart(
            S.current.document_out_going,
            LoadingOnly(
              stream: _xuLyCubit.stateStream,
              child: StreamBuilder<DocumentDashboardModel>(
                stream: _xuLyCubit.getDocumentVBDi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return PieChart(
                      chartData: [
                        ChartData(
                          S.current.cho_trinh_ky,
                          data.soLuongChoTrinhKy?.toDouble() ?? 0,
                          choTrinhKyColor,
                        ),
                        ChartData(
                          S.current.cho_xu_ly,
                          data.soLuongChoXuLy?.toDouble() ?? 0,
                          choXuLyColor,
                        ),
                        ChartData(
                          S.current.da_xu_ly,
                          data.soLuongDaXuLy?.toDouble() ?? 0,
                          daXuLyColor,
                        ),
                        ChartData(
                          S.current.cho_cap_so,
                          data.soLuongChoCapSo?.toDouble() ?? 0,
                          choCapSoColor,
                        ),
                        ChartData(
                          S.current.cho_ban_hanh,
                          data.soLuongChoBanHanh?.toDouble() ?? 0,
                          choBanHanhColor,
                        )
                      ],
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: NodataWidget(),
                  );
                },
              ),
            ),
          )
        ],
      ),
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
