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
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/bieu_do_cong_viec_ca_nhan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/bieu_do_nhiem_vu_ca_nhan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/cell_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NhiemVuCaNhanMobile extends StatefulWidget {
  final bool isCheck;

  const NhiemVuCaNhanMobile({
    Key? key,
    required this.isCheck,
  }) : super(key: key);

  @override
  _NhiemVuCaNhanMobileState createState() => _NhiemVuCaNhanMobileState();
}

class _NhiemVuCaNhanMobileState extends State<NhiemVuCaNhanMobile> {
  final DanhSachCubit danhSachCubit = DanhSachCubit();
  late Function(int page) callBack;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    danhSachCubit.callApi(true);
    callBack = (page) {
      danhSachCubit.postDanhSachNhiemVu(
        index: page,
        isNhiemVuCaNhan: widget.isCheck,
        isSortByHanXuLy: true,
        mangTrangThai: [danhSachCubit.mangTrangThai],
        ngayTaoNhiemVu: {
          'FromDate': danhSachCubit.ngayDauTien,
          'ToDate': danhSachCubit.ngayKetThuc
        },
        size: danhSachCubit.pageSize,
        keySearch: danhSachCubit.keySearch,
        trangThaiHanXuLy: danhSachCubit.trangThaiHanXuLy,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return ComplexLoadMore(
      childrenView: [
        FilterDateTimeWidget(
          context: context,
          isMobile: true,
          onChooseDateFilter: (startDate, endDate) {
            danhSachCubit.ngayDauTien = startDate.formatApi;
            danhSachCubit.ngayKetThuc = endDate.formatApi;
            danhSachCubit.callApiDashBroash(true);
          },
        ),
        ExpandOnlyWidget(
          isPadingIcon: true,
          initExpand: true,
          header: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16.0),
                  child: Text(
                    // S.current.tong_hop,
                    'Tổng hợp tình hình xử lý nhiệm vụ',
                    style: textNormalCustom(color: titleColor, fontSize: 16),
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 16.0
                ),
                child: StreamBuilder<List<ChartData>>(
                  stream: danhSachCubit.statusNhiemVuCaNhanSuject,
                  initialData: danhSachCubit.chartDataNhiemVuCaNhan,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? danhSachCubit.chartDataNhiemVu;
                    return BieuDoNhiemVuCaNhan(
                      title: S.current.nhiem_vu,
                      chartData: data,
                      cubit: danhSachCubit,
                      ontap: (value) {
                        danhSachCubit.mangTrangThai = value;
                        danhSachCubit.trangThaiHanXuLy = null;
                        setState(() {
                          callBack;
                        });
                      },
                      onTapStatusBox: (value_status_box) {
                        danhSachCubit.mangTrangThai = '';
                        danhSachCubit.trangThaiHanXuLy = value_status_box;
                        setState(() {
                          callBack;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 6,
          color: homeColor,
        ),

      ],
      callApi: (page) {
        danhSachCubit.postDanhSachNhiemVu(
          index: page,
          isNhiemVuCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          mangTrangThai: [danhSachCubit.mangTrangThai],
          ngayTaoNhiemVu: {
            'FromDate': danhSachCubit.ngayDauTien,
            'ToDate': danhSachCubit.ngayKetThuc
          },
          size: danhSachCubit.pageSize,
          keySearch: danhSachCubit.keySearch,
          trangThaiHanXuLy: danhSachCubit.trangThaiHanXuLy,
        );
      },
      isListView: true,
      cubit: danhSachCubit,
      viewItem: (value, index) {
        try {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: NhiemVuItemMobile(
              data: value as PageData,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChiTietNhiemVuPhoneScreen(
                      id: value.id ?? '',
                      isCheck: widget.isCheck,
                    ),
                  ),
                );
              },
            ),
          );
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }

  Widget _content(List<String> mangTrangThai, int? trangThaiHanXuLy) {
    return ListViewLoadMore(
      cubit: danhSachCubit,
      isListView: true,
      callApi: (page) => {
        danhSachCubit.postDanhSachNhiemVu(
          index: page,
          isNhiemVuCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          mangTrangThai: mangTrangThai,
          ngayTaoNhiemVu: {
            'FromDate': danhSachCubit.ngayDauTien,
            'ToDate': danhSachCubit.ngayKetThuc
          },
          size: danhSachCubit.pageSize,
          keySearch: danhSachCubit.keySearch,
          trangThaiHanXuLy: trangThaiHanXuLy,
        )
      },
      viewItem: (value, index) {
        try {
          return NhiemVuItemMobile(
            data: value as PageData,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChiTietNhiemVuPhoneScreen(
                    id: value.id ?? '',
                    isCheck: widget.isCheck,
                  ),
                ),
              );
            },
          );
        } catch (e) {
          return const SizedBox();
        }
      },
    );
  }
}
