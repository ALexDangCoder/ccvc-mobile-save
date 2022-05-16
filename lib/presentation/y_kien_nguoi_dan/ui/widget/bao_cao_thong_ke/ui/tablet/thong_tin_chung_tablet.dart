import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/filter_date_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/menu_y_kien_nguoi_dan_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongTinChungYKNDTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDTabletState createState() =>
      _ThongTinChungYKNDTabletState();
}

class _ThongTinChungYKNDTabletState extends State<ThongTinChungYKNDTablet>
    with SingleTickerProviderStateMixin {
  YKienNguoiDanCubitt cubit = YKienNguoiDanCubitt();
  ChooseTimeCubit chooseTimeScreen = ChooseTimeCubit();

  @override
  void initState() {
    super.initState();
    cubit.initTimeRange();
    cubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: MenuYKIenNguoiDanTablet(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', S.current.something_went_wrong),
          stream: cubit.stateStream,
          child: SizedBox.expand(
            child: Container(
              color: homeColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ChooseTimeScreen(
                    //   baseChooseTimeCubit: chooseTimeScreen,
                    //   today: DateTime.now(),
                    //   onChangTime: () {
                    //     cubit.startDate = DateTime.parse(chooseTimeScreen.startDate)
                    //         .formatApiDDMMYYYYSlash;
                    //     cubit.endDate = DateTime.parse(chooseTimeScreen.endDate)
                    //         .formatApiDDMMYYYYSlash;
                    //     cubit.callApi();
                    //   },
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16, left: 16),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: SizedBox(
                    //       height: 88,
                    //       child: StreamBuilder<List<YKienNguoiDanDashBroadItem>>(
                    //         initialData: cubit.listInitDashBoard,
                    //         stream: cubit.listItemDashboard,
                    //         builder: (context, snapshot) {
                    //           final data = snapshot.data ?? [];
                    //           return ListView.builder(
                    //             shrinkWrap: true,
                    //             scrollDirection: Axis.horizontal,
                    //             itemCount: data.length,
                    //             itemBuilder: (context, index) {
                    //               return CustomItemCalenderWork(
                    //                 image: data[index].img ?? '',
                    //                 typeName: data[index].typeName ?? '',
                    //                 numberOfCalendars:
                    //                     data[index].numberOfCalendars ?? 0,
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 12,),
                        decoration: BoxDecoration(
                          color: backgroundColorApp,
                          border: Border.all(
                            color: borderColor.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            FilterDateTablet(
                              onChooseDateFilter:
                                  (DateTime startDate, DateTime endDate) {},
                              context: context,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 4,
                              child: TextField(
                                onChanged: (text) {

                                },
                                onSubmitted: (text) {

                                },
                                decoration: InputDecoration(
                                  prefixIcon: SizedBox(
                                    width: 36,
                                    height: 14,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: SvgPicture.asset(
                                          ImageAssets.ic_KinhRong,
                                          color: AppTheme.getInstance().colorField(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 26,
                                    minHeight: 26,
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
                                  isCollapsed: true,
                                  fillColor: bgDropDown.withOpacity(0.1),
                                  filled: true,
                                  hintText: S.current.tiem_kiem,
                                  hintStyle: textNormal(
                                    sideTextInactiveColor,
                                    14,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: bgDropDown),
                                  ),
                                ),
                              ),
                            )
                            // Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 30,
                    //     vertical: 12,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(
                    //       color: borderColor.withOpacity(0.5),
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: shadowContainerColor.withOpacity(0.05),
                    //         offset: const Offset(0, 4),
                    //         blurRadius: 10,
                    //       )
                    //     ],
                    //   ),
                    //   child: FilterDateTimeWidget(
                    //     onChooseDateFilter:
                    //         (DateTime startDate, DateTime endDate) {},
                    //     context: context,
                    //     isMobile: false,
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 66),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: TiepCanWidget(),
                          ),
                          SizedBox(
                            width: 115,
                          ),
                          Expanded(
                            child: XuLyWidget(),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   color: bgQLVBTablet,
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(
                    //       horizontal: 30,
                    //       vertical: 20,
                    //     ),
                    //     padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(
                    //         color: borderColor.withOpacity(0.5),
                    //       ),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Flexible(
                    //               child: StreamBuilder<List<ChartData>>(
                    //                 stream: cubit.chartTinhHinhXuLy,
                    //                 builder: (context, snapshot) {
                    //                   final listDataChart = snapshot.data ?? [];
                    //                   return Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       PieChart(
                    //                         isSubjectInfo: false,
                    //                         title: S
                    //                             .current.tinh_hinh_y_kien_nguoi_dan,
                    //                         chartData: listDataChart,
                    //                         onTap: (int value) {},
                    //                       ),
                    //                       RowIndicatorSmallTablet(
                    //                         chartData: listDataChart,
                    //                       ),
                    //                     ],
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 100,
                    //             ),
                    //             Flexible(
                    //               child: StreamBuilder<List<ChartData>>(
                    //                 stream: cubit.chartPhanLoai,
                    //                 builder: (context, snapshot) {
                    //                   final chartData = snapshot.data ?? [];
                    //                   return Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       PieChart(
                    //                         isSubjectInfo: false,
                    //                         title: S.current.phan_loai_yknd,
                    //                         chartData: chartData,
                    //                         onTap: (int value) {},
                    //                       ),
                    //                       RowIndicatorTablet(
                    //                         paddingleft: 0,
                    //                         chartData: chartData,
                    //                       ),
                    //                       Container(height: 20),
                    //                     ],
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Row(
                    //           children: [
                    //             Flexible(
                    //               flex: 5,
                    //               child: StreamBuilder(
                    //                 stream: cubit.statusTinhHinhXuLyData,
                    //                 builder: (context, snapshot) {
                    //                   return Row(
                    //                     children: [
                    //                       Expanded(
                    //                         child: BoxStatusVanBan(
                    //                           value: cubit.dashboardModel
                    //                                   .soLuongTrongHan ??
                    //                               0,
                    //                           onTap: () {},
                    //                           color: numberOfCalenders,
                    //                           statusName: S.current.trong_han,
                    //                         ),
                    //                       ),
                    //                       const SizedBox(
                    //                         width: 16,
                    //                       ),
                    //                       Expanded(
                    //                         child: BoxStatusVanBan(
                    //                           value: cubit.dashboardModel
                    //                                   .soLuongDenHan ??
                    //                               0,
                    //                           onTap: () {},
                    //                           color: labelColor,
                    //                           statusName: S.current.den_han,
                    //                         ),
                    //                       ),
                    //                       const SizedBox(
                    //                         width: 16,
                    //                       ),
                    //                       Expanded(
                    //                         child: BoxStatusVanBan(
                    //                           value: cubit.dashboardModel
                    //                                   .soLuongQuaHan ??
                    //                               0,
                    //                           onTap: () {},
                    //                           color: statusCalenderRed,
                    //                           statusName: S.current.qua_han,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 100,
                    //             ),
                    //             Flexible(
                    //               flex: 6,
                    //               child: Row(
                    //                 children: [
                    //                   const Expanded(
                    //                     child: SizedBox(),
                    //                   ),
                    //                   Expanded(
                    //                     flex: 10,
                    //                     child: Row(
                    //                       children: [
                    //                         Expanded(
                    //                           child: BoxStatusVanBan(
                    //                             value: cubit.dashboardModel
                    //                                     .soLuongTrongHan ??
                    //                                 0,
                    //                             onTap: () {},
                    //                             color: numberOfCalenders,
                    //                             statusName: S.current.trong_han,
                    //                           ),
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 16,
                    //                         ),
                    //                         Expanded(
                    //                           child: BoxStatusVanBan(
                    //                             value: cubit.dashboardModel
                    //                                     .soLuongDenHan ??
                    //                                 0,
                    //                             onTap: () {},
                    //                             color: labelColor,
                    //                             statusName: S.current.den_han,
                    //                           ),
                    //                         ),
                    //                         const SizedBox(
                    //                           width: 16,
                    //                         ),
                    //                         Expanded(
                    //                           child: BoxStatusVanBan(
                    //                             value: cubit.dashboardModel
                    //                                     .soLuongQuaHan ??
                    //                                 0,
                    //                             onTap: () {},
                    //                             color: statusCalenderRed,
                    //                             statusName: S.current.qua_han,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   const Expanded(
                    //                     child: SizedBox(),
                    //                   ),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 28,
                    // ),
                    // Expanded(
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 30),
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               S.current.danh_sach_y_kien_nguoi_Dan,
                    //               style: textNormalCustom(
                    //                 color: textTitle,
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             buttonChitiet(S.current.xem_danh_sah_chi_tiet, () {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) => DanhSachYKNDTablet(
                    //                     startDate: cubit.startDate,
                    //                     endDate: cubit.endDate,
                    //                   ),
                    //                 ),
                    //               );
                    //             }),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 20,
                    //         ),
                    //         StreamBuilder<List<YKienNguoiDanModel>>(
                    //           stream: cubit.danhSachYKienNguoiDan,
                    //           builder: (context, snapshot) {
                    //             final data = snapshot.data ?? [];
                    //             return ListView.builder(
                    //               physics: const NeverScrollableScrollPhysics(),
                    //               shrinkWrap: true,
                    //               itemCount: data.length < 3 ? data.length : 3,
                    //               itemBuilder: (context, index) {
                    //                 return YKienNguoiDanCell(
                    //                   onTap: () {
                    //                     Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             ChiTietVanBanTabletScreen(
                    //                           iD: data[index].id ?? '',
                    //                           taskID: data[index].taskID ?? '',
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                   title: data[index].tieuDe ?? '',
                    //                   dateTime: data[index].ngayNhan ?? '',
                    //                   userName: data[index].tenNguoiPhanAnh ?? '',
                    //                   status: data[index].soNgayToiHan ?? 0,
                    //                   userImage:
                    //                       'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                    //                 );
                    //               },
                    //             );
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
