import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/danh_sach_cong_viec_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/danh_sach_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/bieu_do_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/cell_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NhiemVuDonViMobile extends StatefulWidget {
  final bool isCheck;

  const NhiemVuDonViMobile({
    Key? key,
    required this.isCheck,
  }) : super(key: key);

  @override
  _NhiemVuDonViMobileState createState() => _NhiemVuDonViMobileState();
}

class _NhiemVuDonViMobileState extends State<NhiemVuDonViMobile> {
  DanhSachCubit danhSachCubit = DanhSachCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    danhSachCubit.callApiDonVi(false);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {},
      error: AppException(
        S.current.error,
        S.current.error,
      ),
      stream: danhSachCubit.stateStream,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                    bottom: 20.0,
                  ),
                  child: StreamBuilder<List<ChartData>>(
                    stream: danhSachCubit.statusSuject,
                    initialData: danhSachCubit.chartDataNhiemVu,
                    builder: (context, snapshot) {
                      final data =
                          snapshot.data ?? danhSachCubit.chartDataNhiemVu;
                      return BieuDoNhiemVuMobile(
                        title: S.current.nhiem_vu,
                        chartData: data,
                        cubit: danhSachCubit,
                        ontap: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DanhSachNhiemVuMobile(
                                isCheck: widget.isCheck,
                                ngayBatDau: danhSachCubit.ngayDauTien,
                                ngayKetThuc: danhSachCubit.ngayKetThuc,
                                mangTrangThai: value.trangThaiBieuDoNhiemVu(),
                              ),
                            ),
                          );
                        },
                        onTapStatusBox: (value) {
                          print('************${value}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DanhSachNhiemVuMobile(
                                isCheck: widget.isCheck,
                                ngayBatDau: danhSachCubit.ngayDauTien,
                                ngayKetThuc: danhSachCubit.ngayKetThuc,
                                mangTrangThai: [],
                                trangThaiHanXuLy: value,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                    bottom: 20.0,
                  ),
                  child: StreamBuilder<List<ChartData>>(
                    stream: danhSachCubit.statusCongViecSuject,
                    initialData: danhSachCubit.chartDataNhiemVu,
                    builder: (context, snapshot) {
                      final data =
                          snapshot.data ?? danhSachCubit.chartDataNhiemVu;
                      return BieuDoCongViecMobile(
                        title: S.current.cong_viec,
                        chartData: data,
                        cubit: danhSachCubit,
                        ontap: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DanhSachCongViecMobile(
                                isCheck: widget.isCheck,
                                ngayKetThuc: danhSachCubit.ngayKetThuc,
                                ngayBatDau: danhSachCubit.ngayDauTien,
                                mangTrangThai: [value],
                                trangThaiHanXuLy: null,
                              ),
                            ),
                          );
                        },
                        onTapStatusBox: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DanhSachCongViecMobile(
                                isCheck: widget.isCheck,
                                ngayKetThuc: danhSachCubit.ngayKetThuc,
                                ngayBatDau: danhSachCubit.ngayDauTien,
                                mangTrangThai: [],
                                trangThaiHanXuLy: value,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.danh_sach_nhiem_vu,
                            style: textNormalCustom(
                              fontSize: 16,
                              color: textDropDownColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DanhSachNhiemVuMobile(
                                    isCheck: widget.isCheck,
                                    ngayBatDau: danhSachCubit.ngayDauTien,
                                    ngayKetThuc: danhSachCubit.ngayKetThuc,
                                    mangTrangThai: [],
                                  ),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(
                              ImageAssets.ic_next_color,
                              color: AppTheme.getInstance().colorField(),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StreamBuilder<List<PageData>>(
                          stream: danhSachCubit.dataSubject,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length < 3 ? data.length : 3,
                                itemBuilder: (context, index) {
                                  return NhiemVuItemMobile(
                                    data: data[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChiTietNhiemVuPhoneScreen(
                                            id: data[index].id ?? '',
                                            isCheck: widget.isCheck,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return SizedBox(
                              child: Text(
                                S.current.khong_co_du_lieu,
                                style: titleAppbar(fontSize: 16.0),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.current.danh_sach_cong_viec,
                            style: textNormalCustom(
                              fontSize: 16,
                              color: textDropDownColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DanhSachCongViecMobile(
                                    // cubit: danhSachCubit,
                                    isCheck: widget.isCheck,
                                    ngayKetThuc: danhSachCubit.ngayKetThuc,
                                    ngayBatDau: danhSachCubit.ngayDauTien,
                                    mangTrangThai: [], trangThaiHanXuLy: null,
                                  ),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(
                              ImageAssets.ic_next_color,
                              color: AppTheme.getInstance().colorField(),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: StreamBuilder<List<PageDatas>>(
                          stream: danhSachCubit.dataSubjects,
                          builder: (context, snapshot) {
                            final data = snapshot.data ?? [];
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length < 3 ? data.length : 3,
                                itemBuilder: (context, index) {
                                  return CellCongViec(
                                    data: data[index],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChitietCongViecNhiemVuMobile(
                                            id: data[index].id ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return SizedBox(
                              child: Text(
                                S.current.khong_co_du_lieu,
                                style: titleAppbar(fontSize: 16.0),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          TableCalendarWidget(
            onChange:
                (DateTime startDate, DateTime endDate, DateTime selectDay) {
              // danhSachCubit.ngayDauTien = startDate.formatApi;
              // danhSachCubit.ngayKetThuc = endDate.formatApi;
              danhSachCubit.callApiDashBroashDonVi(false);
            },
            onChangeRange:
                (DateTime? start, DateTime? end, DateTime? focusedDay) {
              danhSachCubit.ngayDauTien = (start ?? DateTime.now()).formatApi;
              danhSachCubit.ngayKetThuc = (end ?? DateTime.now()).formatApi;
              print("start ${start}");
              print("end-- ${end}");
              danhSachCubit.callApiDashBroashDonVi(false);
            },
            onChangeText: (String? value) {},
          ),
        ],
      ),
    );
  }
}
