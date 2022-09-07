import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_column_chart.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_widget.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class TinhHinhPAKNCuaCaNhanTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const TinhHinhPAKNCuaCaNhanTabletWidget({
    Key? key,
    required this.homeItemType,
  }) : super(key: key);

  @override
  State<TinhHinhPAKNCuaCaNhanTabletWidget> createState() =>
      _SituationOfHandlingPeopleWidgetState();
}

class _SituationOfHandlingPeopleWidgetState
    extends State<TinhHinhPAKNCuaCaNhanTabletWidget> {
  final TinhHinhXuLyPAKNCubit _yKienCubit = TinhHinhXuLyPAKNCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yKienCubit.callApi(isDonVi: false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _yKienCubit.callApi(isDonVi: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ContainerBackgroundTabletWidget(
        spacingTitle: 0,
        minHeight: 415,
        isShowSubtitle: false,
        title: S.current.situation_of_handling_people,
        onTapIcon: () {
          HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
        },
        selectKeyDialog: _yKienCubit,
        // dialogSelect: StreamBuilder(
        //     stream: _yKienCubit.selectKeyDialog,
        //     builder: (context, snapshot) {
        //       return DialogSettingWidget(
        //         type: widget.homeItemType,
        //         listSelectKey: <DialogData>[
        //           DialogData(
        //             onSelect: (value, startDate, endDate) {
        //               _yKienCubit.selectDate(
        //                   selectKey: value,
        //                   startDate: startDate,
        //                   endDate: endDate);
        //             },
        //             initValue: _yKienCubit.selectKeyTime,
        //             title: S.current.time,
        //             startDate: _yKienCubit.startDate,
        //             endDate: _yKienCubit.endDate,
        //           )
        //         ],
        //       );
        //     }),
        child: LoadingOnly(
          stream: _yKienCubit.stateStream,
          child: StreamBuilder<DocumentDashboardModel>(
            stream: _yKienCubit.getTinhHinhXuLy,
            builder: (context, snapshot) {
              final data = snapshot.data ?? DocumentDashboardModel();

              return Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
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
                          StatusColumnChart(listData: [
                            ChartData(
                              S.current.cho_tiep_nhan,
                              data.soLuongChoTiepNhan.toDouble(),
                              choTrinhKyColor,
                              SelectKey.CHO_TRINH_KY,
                            ),
                            ChartData(
                              S.current.phan_xu_ly,
                              data.soLuongPhanXuLy.toDouble(),
                              numberOfCalenders,
                              SelectKey.CHO_XU_LY,
                            ),
                            ChartData(
                              S.current.dang_xu_ly,
                              data.soLuongDangXuLy.toDouble(),
                              daXuLyColor,
                              SelectKey.DA_XU_LY,
                            ),
                            ChartData(
                              S.current.cho_duyet,
                              data.soLuongChoDuyet.toDouble(),
                              choCapSoColor,
                              SelectKey.CHO_CAP_SO,
                            ),
                            ChartData(
                              S.current.cho_bo_sung_thong_tin,
                              data.soLuongChoBoSungThongTin.toDouble(),
                              choBanHanhColor,
                              SelectKey.CHO_BAN_HANH,
                            )
                          ]),
                          const SizedBox(
                            height: 24,
                          ),
                          StatusWidget(
                            showZeroValue: false,
                            listData: [
                              ChartData(
                                S.current.qua_han,
                                data.soLuongQuaHan.toDouble(),
                                statusCalenderRed,
                                SelectKey.CHO_VAO_SO,
                              ),
                              ChartData(
                                S.current.den_han,
                                data.soLuongDenHan.toDouble(),
                                yellowColor,
                                SelectKey.DANG_XU_LY,
                              ),
                              ChartData(
                                S.current.trong_han,
                                data.soLuongTrongHan.toDouble(),
                                choTrinhKyColor,
                                SelectKey.DA_XU_LY,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 168,
                    ),
                    Expanded(
                      child: PieChart(
                        paddingTop: 0,
                        title: S.current.xu_ly,
                        chartData: [
                          ChartData(
                            S.current.cho_tiep_nhan_xu_ly,
                            data.soLuongChoTiepNhanXuLy.toDouble(),
                            choTrinhKyColor,
                          ),
                          ChartData(
                            S.current.cho_xu_ly,
                            data.soLuongChoXuLy.toDouble(),
                            numberOfCalenders,
                          ),
                          ChartData(
                            S.current.cho_phan_xu_ly,
                            data.soLuongChoPhanXuLy.toDouble(),
                            radioFocusColor,
                          ),
                          ChartData(
                            S.current.cho_duyet,
                            data.soLuongChoDuyet.toDouble(),
                            choCapSoColor,
                          ),
                          ChartData(
                            S.current.da_phan_cong,
                            data.soLuongDaPhanCong.toDouble(),
                            choBanHanhColor,
                          ),
                          ChartData(
                            S.current.da_hoan_thanh,
                            data.soLuongDaHoanThanh.toDouble(),
                            itemWidgetUsing,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
            },
          ),
        ),
      ),
    );
  }
}
