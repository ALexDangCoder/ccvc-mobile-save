import 'package:ccvc_mobile/utils/extensions/size_extension.dart';

import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/domain/model/home/WidgetType.dart';

import '/generated/l10n.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';

import '/home_module/presentation/home_screen/ui/home_provider.dart';

import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/enum_ext.dart';

import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';
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
    extends State<WordProcessingStateTabletWidget> {
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
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
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
                      selectKey: value, startDate: startDate, endDate: endDate);
                },
                title: S.current.time,
                initValue: _xuLyCubit.selectKeyTime,
              )
            ],
          );
        }
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
            ),
            Expanded(
              child: titleChart(
                S.current.document_out_going,
                LoadingOnly(
                  stream: _xuLyCubit.stateStream,
                  child: StreamBuilder<DocumentDashboardModel>(
                    stream: _xuLyCubit.getDocumentVBDi,
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
                              data.soLuongChoBanHanh?.toDouble() ?? 0,
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
}
