import 'package:ccvc_mobile/home_module/domain/model/home/WidgetType.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/van_ban_don_vi_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/home_module/widgets/text/views/loading_only.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/config/resources/styles.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';

class VanBanDonViWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const VanBanDonViWidget({
    required this.homeItemType,
    Key? key,
  }) : super(key: key);

  @override
  State<VanBanDonViWidget> createState() => _VanBanDonViWidgetState();
}

class _VanBanDonViWidgetState extends State<VanBanDonViWidget> {
  late HomeCubit cubit;
  final VanBanDonViCubit _vanBanDonViCubit = VanBanDonViCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vanBanDonViCubit.getDocument();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _vanBanDonViCubit.getDocument();
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
    _vanBanDonViCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.tinh_hinh_xu_ly_vb_don_vi,
      child: Padding(
        padding: EdgeInsets.zero,
        child: LoadingOnly(
          stream: _vanBanDonViCubit.stateStream,
          child: StreamBuilder<VanBanDonViModel>(
            stream: _vanBanDonViCubit.getVanBanDonVi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data ??
                    VanBanDonViModel(
                      vbDen: DocumentDashboardModel(),
                      vbDi: DocumentDashboardModel(),
                    );
                final dataVBDen = data.vbDen;
                final dataVBDi = data.vbDi;
                final displayVBDen =
                    _vanBanDonViCubit.displaySubComeDocument(dataVBDen);
                final displayVBDi =
                    _vanBanDonViCubit.displaySubGoDocument(dataVBDi);
                final displayStatus =
                    _vanBanDonViCubit.displayStatus(dataVBDen);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleChart(
                      S.current.document_incoming,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: PieChart(
                              isSubjectInfo: displayVBDen,
                              paddingTop: 0,
                              chartData: [
                                ChartData(
                                  S.current.cho_vao_so,
                                  dataVBDen.soLuongChoVaoSo.toDouble(),
                                  choVaoSoColor,
                                  SelectKey.CHO_VAO_SO,
                                ),
                                ChartData(
                                  S.current.dang_xu_ly,
                                  dataVBDen.soLuongDangXuLy.toDouble(),
                                  dangXyLyColor,
                                  SelectKey.DANG_XU_LY,
                                ),
                                ChartData(
                                  S.current.da_xu_ly,
                                  dataVBDen.soLuongDaXuLy.toDouble(),
                                  daXuLyColor,
                                  SelectKey.DA_XU_LY,
                                ),
                              ],
                              onTap: (value, key) {},
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Visibility(
                            visible: displayStatus,
                            child: statusWidget(
                              [
                                ChartData(
                                  S.current.qua_han,
                                  dataVBDen.soLuongQuaHan.toDouble(),
                                  statusCalenderRed,
                                  SelectKey.CHO_VAO_SO,
                                ),
                                ChartData(
                                  S.current.den_han,
                                  dataVBDen.soLuongDenHan.toDouble(),
                                  yellowColor,
                                  SelectKey.DANG_XU_LY,
                                ),
                                ChartData(
                                  S.current.trong_han,
                                  dataVBDen.soLuongTrongHan.toDouble(),
                                  choTrinhKyColor,
                                  SelectKey.DA_XU_LY,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    titleChart(
                      S.current.document_out_going,
                      Center(
                        child: PieChart(
                          isSubjectInfo: displayVBDi,
                          chartData: [
                            ChartData(
                              S.current.cho_trinh_ky,
                              dataVBDi.soLuongChoTrinhKy.toDouble(),
                              choTrinhKyColor,
                              SelectKey.CHO_TRINH_KY,
                            ),
                            ChartData(
                              S.current.cho_xu_ly,
                              dataVBDi.soLuongChoXuLy.toDouble(),
                              choXuLyColor,
                              SelectKey.CHO_XU_LY,
                            ),
                            ChartData(
                              S.current.da_xu_ly,
                              dataVBDi.soLuongDaXuLy.toDouble(),
                              daXuLyColor,
                              SelectKey.DA_XU_LY,
                            ),
                            ChartData(
                              S.current.cho_cap_so,
                              dataVBDi.soLuongChoCapSo.toDouble(),
                              choCapSoColor,
                              SelectKey.CHO_CAP_SO,
                            ),
                            ChartData(
                              S.current.cho_ban_hanh,
                              dataVBDi.soLuongChoBanHanh.toDouble(),
                              choBanHanhColor,
                              SelectKey.CHO_BAN_HANH,
                            )
                          ],
                          onTap: (value, key) {},
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox(
                  height: 400,
                  child: NodataWidget(),
                );
              }
            },
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
                  (e) => Visibility(
                    visible: !(e.value.toInt() == 0),
                    child: Expanded(
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
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        GridView.count(
          padding: EdgeInsets.zero,
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
