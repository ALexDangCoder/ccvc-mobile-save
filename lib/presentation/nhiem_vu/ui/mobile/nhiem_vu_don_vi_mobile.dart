import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/nhiem_vu_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_cong_viec_nhiem_vu/ui/mobile/chi_tiet_cong_viec_nhiem_vu.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/ui/mobile/danh_sach/danh_sach_cong_viec_mobile.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/ui/mobile/danh_sach/danh_sach_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NhiemVuDonViMobile extends StatefulWidget {
  final NhiemVuCubit cubit;

  const NhiemVuDonViMobile({Key? key, required this.cubit}) : super(key: key);

  @override
  _NhiemVuDonViMobileState createState() => _NhiemVuDonViMobileState();
}

class _NhiemVuDonViMobileState extends State<NhiemVuDonViMobile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                child: BieuDoNhiemVuMobile(
                  title: S.current.nhiem_vu,
                  nhiemVuDashBoardModel: nhiemVuDashBoardModel,
                  chartData: widget.cubit.chartDataNhiemVu,
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
                child: BieuDoNhiemVuMobile(
                  title: S.current.cong_viec,
                  nhiemVuDashBoardModel: nhiemVuDashBoardModel,
                  chartData: widget.cubit.chartDataCongViec,
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
                                builder: (context) =>
                                    const DanhSachNhiemVuMobile(),
                              ),
                            );
                          },
                          icon: SvgPicture.asset(ImageAssets.ic_next_color),
                        )
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listDanhSachNhiemVu.length < 3
                          ? listDanhSachNhiemVu.length
                          : 3,
                      itemBuilder: (context, index) {
                        return NhiemVuItemMobile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChiTietNhiemVuPhoneScreen(),
                              ),
                            );
                          },
                          title: listDanhSachNhiemVu[index].noiDung ?? '',
                          timeStart:
                              listDanhSachCongViec[index].timeStart ?? '',
                          timeEnd: listDanhSachCongViec[index].timeEnd ?? '',
                          userName: listDanhSachNhiemVu[index].nguoiTao ?? '',
                          status: listDanhSachNhiemVu[index].trangThai ?? '',
                          userImage:
                              'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
                        );
                      },
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
                                builder: (context) =>
                                    const DanhSachCongViecMobile(),
                              ),
                            );
                          },
                          icon: SvgPicture.asset(ImageAssets.ic_next_color),
                        )
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listDanhSachCongViec.length < 3
                          ? listDanhSachCongViec.length
                          : 3,
                      itemBuilder: (context, index) {
                        return NhiemVuItemMobile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ChitietCongViecNhiemVuMobile(),
                              ),
                            );
                          },
                          title: listDanhSachCongViec[index].noiDung ?? '',
                          timeStart:
                              listDanhSachCongViec[index].timeStart ?? '',
                          timeEnd: listDanhSachCongViec[index].timeEnd ?? '',
                          userName: listDanhSachCongViec[index].nguoiTao ?? '',
                          status: listDanhSachCongViec[index].trangThai ?? '',
                          userImage:
                              'https://th.bing.com/th/id/OIP.A44wmRFjAmCV90PN3wbZNgHaEK?pid=ImgDet&rs=1',
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
          onChange: (DateTime startDate, DateTime endDate) {},
          onChangeRange:
              (DateTime? start, DateTime? end, DateTime? focusedDay) {},
        ),
      ],
    );
  }
}
