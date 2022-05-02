import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/items/situation_of_handling_people_widget.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_widget.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/ui/mobile/danh_sach_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/ui/tablet/danh_sach_yknd_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class SituationOfHandlingPeopleTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const SituationOfHandlingPeopleTabletWidget({
    Key? key,
    required this.homeItemType,
  }) : super(key: key);

  @override
  State<SituationOfHandlingPeopleTabletWidget> createState() =>
      _SituationOfHandlingPeopleWidgetState();
}

class _SituationOfHandlingPeopleWidgetState
    extends State<SituationOfHandlingPeopleTabletWidget> {
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
                return Padding(
                  padding: const EdgeInsets.only(left: 24),
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

                          ],
                        ),
                      ),
                      const SizedBox(width: 168,),
                      Expanded(child:  PieChart(
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
                      ),),
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
              }),
        ),
      ),
    );
  }
}
