
import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';


import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WordProcessingStateTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const WordProcessingStateTabletWidget({
    Key? key,
    required this.homeItemType,
  }) : super(key: key);

  @override
  State<WordProcessingStateTabletWidget> createState() =>
      _WordProcessingStateWidgetState();
}

class _WordProcessingStateWidgetState
    extends State<WordProcessingStateTabletWidget> with AutomaticKeepAliveClientMixin{
  late HomeCubit cubit;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('message');
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit..getDocument();

  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.word_processing_state,
      onTapIcon: () {
        cubit.showDialog(widget.homeItemType);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            title: S.current.document,
            key: [
              SelectKey.HOM_NAY,
              SelectKey.TUAN_NAY,
              SelectKey.THANG_NAY,
              SelectKey.NAM_NAY
            ],
          )
        ],
      ),
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
                StreamBuilder<DocumentDashboardModel>(
                  stream: cubit.getDocumentVBDen,
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
                        onTap: (value) {},
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: NodataWidget(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: titleChart(
                S.current.document_out_going,
                StreamBuilder<DocumentDashboardModel>(
                  stream: cubit.getDocumentVBDi,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return PieChart(
                        paddingTop: 0,
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
                            data.soLuongChoTrinhKy?.toDouble() ?? 0,
                            choBanHanhColor,
                          )
                        ],
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: NodataWidget(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
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
              fontSize: 16.0.textScale(),
            ),
          ),
          child
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
