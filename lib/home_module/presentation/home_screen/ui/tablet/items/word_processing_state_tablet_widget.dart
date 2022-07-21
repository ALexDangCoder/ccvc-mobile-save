import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/widgets/han_xu_ly_widget.dart';
import 'package:ccvc_mobile/home_module/utils/enum_ext.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/tablet/imcoming_document_screen_dashboard_tablet.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/tablet/incoming_document_tablet.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 63,
            ),
            Flexible(
              child: titleChart(
                S.current.document_incoming,
                LoadingOnly(
                  stream: _xuLyCubit.stateStream,
                  child: StreamBuilder<DocumentDashboardModel>(
                    stream: _xuLyCubit.getDocumentVBDen,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? DocumentDashboardModel();
                      // if (snapshot.hasData) {
                      return Column(
                        children: [
                          PieChart(
                            isSubjectInfo: false,
                            paddingTop: 0,
                            chartData:
                                List.generate(data.listVBDen().length, (index) {
                              final result = data.listVBDen()[index];
                              return ChartData(result.key.getText(),
                                  result.value.toDouble(), result.color);
                            }),
                            onTap: (value, key) {
                              if (key != null) {
                                _xuLyCubit.selectTrangThaiVBDen(key);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        IncomingDocumentScreenTablet(
                                      startDate:
                                          _xuLyCubit.startDate.toString(),
                                      title: S.current.danh_sach_van_ban_den,
                                      endDate: _xuLyCubit.endDate.toString(),
                                      type: TypeScreen.VAN_BAN_DEN,
                                      maTrangThai: _xuLyCubit.maTrangThaiVBDen,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          GridView.count(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 9,
                            mainAxisSpacing: 14.0,
                            crossAxisSpacing: 10,
                            children: List.generate(
                                data.listVBDenSubjectInfo().length, (index) {
                              final result = data.listVBDenSubjectInfo()[index];
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
                                          '${result.key.getText()} (${result.value.toInt()})',
                                          style: textNormal(
                                            infoColor,
                                            16,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: HanXuLyWidget(
                              data: [
                                ChartData(
                                    S.current.qua_han,
                                    data.soLuongQuaHan.toDouble() ,
                                    statusCalenderRed),
                                ChartData(
                                    S.current.den_han,
                                    data.soLuongDenHan.toDouble() ,
                                    yellowColor),
                                ChartData(
                                    S.current.trong_han,
                                    data.soLuongTrongHan.toDouble(),
                                    choTrinhKyColor)
                              ],
                              onTap: (index) {},
                            ),
                          )
                        ],
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
                              data.soLuongChoTrinhKy.toDouble() ,
                              choTrinhKyColor,
                            ),
                            ChartData(
                              S.current.cho_xu_ly,
                              data.soLuongChoXuLy.toDouble(),
                              choXuLyColor,
                            ),
                            ChartData(
                              S.current.da_xu_ly,
                              data.soLuongDaXuLy.toDouble(),
                              daXuLyColor,
                            ),
                            ChartData(
                              S.current.cho_cap_so,
                              data.soLuongChoCapSo.toDouble() ,
                              choCapSoColor,
                            ),
                            ChartData(
                              S.current.cho_ban_hanh,
                              data.soLuongChoBanHanh.toDouble(),
                              choBanHanhColor,
                            )
                          ],
                          onTap: (value, key) {
                            if (key != null) {
                              _xuLyCubit.selectTrangThaiVBDi(key);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      IncomingDocumentScreenDashBoardTablet(
                                    startDate: _xuLyCubit.startDate.toString(),
                                    endDate: _xuLyCubit.endDate.toString(),
                                    title: S.current.danh_sach_van_ban_di,
                                    trangThaiFilter: _xuLyCubit.trangThaiFilter,
                                    isDanhSachChoTrinhKy:
                                        _xuLyCubit.isDanhSachChoTrinhKy,
                                    isDanhSachChoXuLy:
                                        _xuLyCubit.isDanhSachChoXuLy,
                                    isDanhSachDaXuLy:
                                        _xuLyCubit.isDanhSachDaXuLy,
                                    type: TypeScreen.VAN_BAN_DI,
                                  ),
                                ),
                              );
                            }
                          },
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
