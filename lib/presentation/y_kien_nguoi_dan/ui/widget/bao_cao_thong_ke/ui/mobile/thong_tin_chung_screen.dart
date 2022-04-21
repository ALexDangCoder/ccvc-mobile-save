import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/ui/mobile/danh_sach_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/indicator_chart.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y__kien_nguoi_dan_item.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinChungYKNDScreen extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDScreenState createState() =>
      _ThongTinChungYKNDScreenState();
}

class _ThongTinChungYKNDScreenState extends State<ThongTinChungYKNDScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.initTimeRange();
    widget.cubit.callApi();
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
                screen: YKienNguoiDanMenu(
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
        stream: widget.cubit.stateStream,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      S.current.thong_tin_y_kien_nguoi_dan,
                      style: textNormalCustom(
                        color: textTitle,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        height: 88,
                        child: StreamBuilder<List<YKienNguoiDanDashBroadItem>>(
                          stream: widget.cubit.listItemDashboard,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return CustomItemCalenderWork(
                                  image: data[index].img ?? '',
                                  typeName: data[index].typeName ?? '',
                                  numberOfCalendars:
                                      data[index].numberOfCalendars ?? 0,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 6,
                    color: homeColor,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<List<ChartData>>(
                          stream: widget.cubit.chartTinhHinhXuLy,
                          builder: (context, snapshot) {
                            final listDataChart = snapshot.data ?? [];
                            return PieChart(
                              title: S.current.tinh_hinh_y_kien_nguoi_dan,
                              chartData: listDataChart,
                              onTap: (int value) {
                                final status = widget.cubit.getTrangThai(
                                  listDataChart[value].title,
                                );
                                widget.cubit.trangThai=status;
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => DanhSachYKND(
                                      startDate: widget.cubit.startDate,
                                      endDate: widget.cubit.endDate,
                                      trangThai: widget.cubit.trangThai,
                                    ),
                                  ),
                                );

                              },
                            );
                          },
                        ),
                        Container(height: 20),
                        StreamBuilder<DocumentDashboardModel>(
                          stream: widget.cubit.statusTinhHinhXuLyData,
                          builder: (context, snapshot) {
                            final data =
                                snapshot.data ?? DocumentDashboardModel();
                            return Row(
                              children: [
                                Expanded(
                                  child: BoxStatusVanBan(
                                    value: data.soLuongTrongHan ?? 0,
                                    onTap: () {
                                      final status = widget.cubit.getTrangThai(
                                        S.current.trong_han,
                                      );
                                      widget.cubit.trangThai=status;
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => DanhSachYKND(
                                            startDate: widget.cubit.startDate,
                                            endDate: widget.cubit.endDate,
                                            trangThai: widget.cubit.trangThai,
                                          ),
                                        ),
                                      );
                                      print('-----------------------status----------------');
                                      print(status);
                                    },
                                    color: numberOfCalenders,
                                    statusName: S.current.trong_han,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: BoxStatusVanBan(
                                    value: data.soLuongDenHan ?? 0,
                                    onTap: () {
                                      final status = widget.cubit.getTrangThai(
                                        S.current.den_han,
                                      );
                                      widget.cubit.trangThai=status;
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => DanhSachYKND(
                                            startDate: widget.cubit.startDate,
                                            endDate: widget.cubit.endDate,
                                            trangThai: widget.cubit.trangThai,
                                          ),
                                        ),
                                      );
                                      print('-----------------------status----------------');
                                      print(status);
                                    },
                                    color: labelColor,
                                    statusName: S.current.den_han,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: BoxStatusVanBan(
                                    value: data.soLuongQuaHan ?? 0,
                                    onTap: () {
                                      final status = widget.cubit.getTrangThai(
                                        S.current.qua_han,
                                      );
                                      widget.cubit.trangThai=status;
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => DanhSachYKND(
                                            startDate: widget.cubit.startDate,
                                            endDate: widget.cubit.endDate,
                                            trangThai: widget.cubit.trangThai,
                                          ),
                                        ),
                                      );
                                      print('-----------------------status----------------');
                                      print(status);
                                    },
                                    color: statusCalenderRed,
                                    statusName: S.current.qua_han,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    color: homeColor,
                    height: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        StreamBuilder<List<ChartData>>(
                          stream: widget.cubit.chartPhanLoai,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            return PieChart(
                              isSubjectInfo: false,
                              title: S.current.phan_loai_nguon_yknd,
                              chartData: data,
                              onTap: (int value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: widget.cubit.listIndicator.map((e) {
                            return IndicatorChart(itemIndicator: e);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    color: homeColor,
                    height: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.danh_sach_y_kien_nguoi_Dan,
                              style: textNormalCustom(
                                fontSize: 16,
                                color: textDropDownColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => DanhSachYKND(
                                      startDate: widget.cubit.startDate,
                                      endDate: widget.cubit.endDate,
                                    ),
                                  ),
                                );
                              },
                              icon: SvgPicture.asset(ImageAssets.ic_next_color),
                            )
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        StreamBuilder<List<YKienNguoiDanModel>>(
                          stream: widget.cubit.danhSachYKienNguoiDan,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length < 3 ? data.length : 3,
                              itemBuilder: (context, index) {
                                return YKienNguoiDanCell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChiTietYKNDScreen(
                                          iD: data[index].id ?? '',
                                          taskID: data[index].taskID ?? '',
                                        ),
                                      ),
                                    );
                                  },
                                  title: data[index].tieuDe ?? '',
                                  dateTime: data[index].ngayNhan ?? '',
                                  userName: data[index].tenNguoiPhanAnh ?? '',
                                  status: data[index].soNgayToiHan ?? 0,
                                  userImage:
                                      'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TableCalendarWidget(
              onChangeRange:
                  (DateTime? start, DateTime? end, DateTime? focusedDay) {
                widget.cubit.startDate = start?.toStringWithListFormat ??
                    DateTime.now().toStringWithListFormat;
                widget.cubit.endDate = end?.toStringWithListFormat ??
                    DateTime.now().toStringWithListFormat;
                widget.cubit.callApi();
              },
              onChange:
                  (DateTime startDate, DateTime endDate, DateTime selectDay) {
                widget.cubit.startDate = startDate.toStringWithListFormat;
                widget.cubit.endDate = endDate.toStringWithListFormat;
                widget.cubit.callApi();
              },
            ),
          ],
        ),
      ),
    );
  }
}
