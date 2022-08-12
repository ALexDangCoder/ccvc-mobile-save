import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/widgets/han_xu_ly_widget.dart';
import 'package:ccvc_mobile/home_module/utils/enum_ext.dart';
import 'package:ccvc_mobile/presentation/incoming_document/bloc/incoming_document_cubit.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/mobile/incoming_document_screen.dart';
import 'package:ccvc_mobile/presentation/incoming_document/ui/mobile/incoming_document_screen_dashboard.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/document_dashboard_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
      // selectKeyDialog: _xuLyCubit,
      //
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
                    return Column(
                      children: [
                        PieChart(
                          isSubjectInfo: false,
                          paddingTop: 0,
                          chartData:
                              List.generate(data.listVBDen().length, (index) {
                            final result = data.listVBDen()[index];
                            return ChartData(
                              result.key.getText(),
                              result.value.toDouble(),
                              result.color,
                            );
                          }),
                          onTap: (value, key) {
                            if (key != null) {
                              _xuLyCubit.selectTrangThaiVBDen(key);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IncomingDocumentScreen(
                                    startDate: _xuLyCubit.startDate.toString(),
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
                          mainAxisSpacing: 10.0,
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
                                          14,
                                          // 14.0.textScale(),
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
                          height: 26,
                        ),
                        HanXuLyWidget(
                          onTap: (value) {},
                          data: [
                            ChartData(
                                S.current.qua_han,
                                data.soLuongQuaHan.toDouble(),
                                statusCalenderRed),
                            ChartData(S.current.den_han,
                                data.soLuongDenHan.toDouble(), yellowColor),
                            ChartData(
                                S.current.trong_han,
                                data.soLuongTrongHan.toDouble(),
                                choTrinhKyColor)
                          ],
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
                          data.soLuongChoTrinhKy.toDouble(),
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
                          data.soLuongChoCapSo.toDouble(),
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
                                  IncomingDocumentScreenDashBoard(
                                startDate: _xuLyCubit.startDate.toString(),
                                endDate: _xuLyCubit.endDate.toString(),
                                title: S.current.danh_sach_van_ban_di,
                                trangThaiFilter: _xuLyCubit.trangThaiFilter,
                                isDanhSachChoTrinhKy:
                                    _xuLyCubit.isDanhSachChoTrinhKy,
                                isDanhSachChoXuLy: _xuLyCubit.isDanhSachChoXuLy,
                                isDanhSachDaXuLy: _xuLyCubit.isDanhSachDaXuLy,
                              ),
                            ),
                          );
                        }
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
