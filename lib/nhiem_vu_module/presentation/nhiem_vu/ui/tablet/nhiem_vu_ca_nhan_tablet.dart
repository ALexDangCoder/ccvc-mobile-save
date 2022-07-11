import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/bieu_do_ca_nhan_row_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_tablet_new.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget_tablet.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class NhiemVuCaNhanTablet extends StatefulWidget {
  final String maTrangThai;
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit cubit;
  final bool isCheck;

  const NhiemVuCaNhanTablet({
    Key? key,
    required this.danhSachCubit,
    required this.cubit,
    required this.isCheck,
    this.maTrangThai='',
  }) : super(key: key);

  @override
  _NhiemVuCaNhanTabletState createState() => _NhiemVuCaNhanTabletState();
}

class _NhiemVuCaNhanTabletState extends State<NhiemVuCaNhanTablet> {
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.danhSachCubit.mangTrangThai =widget.maTrangThai;
    widget.danhSachCubit.keySearch = '';
    if(widget.maTrangThai.isNotEmpty){
      widget.danhSachCubit.callApi(true, canCallApi: false);
    }
    else{
      widget.danhSachCubit.callApi(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      body: ComplexLoadMore(
        childrenView: [
          FilterDateTimeWidgetTablet(
            isBtnClose: true,
            initStartDate: DateTime.parse(widget.danhSachCubit.ngayDauTien),
            context: context,
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(true);
            },
            onClose: (v) {
              textcontroller.clear();
              widget.danhSachCubit.keySearch = '';
              widget.danhSachCubit.mangTrangThai = '';
              widget.danhSachCubit.loadMoreList.clear();
              widget.danhSachCubit.postDanhSachNhiemVu(
                isNhiemVuCaNhan: widget.isCheck,
                isSortByHanXuLy: true,
                mangTrangThai: [widget.danhSachCubit.mangTrangThai],
                ngayTaoNhiemVu: {
                  'FromDate': widget.danhSachCubit.ngayDauTien,
                  'ToDate': widget.danhSachCubit.ngayKetThuc
                },
                size: widget.danhSachCubit.pageSize,
                keySearch: '',
                trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
              );
            },
            controller: textcontroller,
            onChange: (text) {
              widget.danhSachCubit.debouncer.run(() {
                setState(() {});
                widget.danhSachCubit.keySearch = text;
                widget.danhSachCubit.mangTrangThai = '';
                widget.danhSachCubit.postDanhSachNhiemVu(
                  isNhiemVuCaNhan: widget.isCheck,
                  isSortByHanXuLy: true,
                  mangTrangThai: [widget.danhSachCubit.mangTrangThai],
                  ngayTaoNhiemVu: {
                    'FromDate': widget.danhSachCubit.ngayDauTien,
                    'ToDate': widget.danhSachCubit.ngayKetThuc
                  },
                  size: widget.danhSachCubit.pageSize,
                  keySearch: widget.danhSachCubit.keySearch,
                  trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
                );
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 28.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: borderItemCalender),
                borderRadius: BorderRadius.circular(12.0),
                color: backgroundColorApp,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ExpandOnlyWidget(
                isPaddingIcon: true,
                initExpand: true,
                header: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16.0),
                        child: Text(
                          S.current.tong_hop_tinh_hinh_xu_ly_nhiem_vu,
                          style:
                              textNormalCustom(color: titleColor, fontSize: 20),
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
                      padding: const EdgeInsets.only(bottom: 20.0, left: 16.0),
                      child: StreamBuilder<List<ChartData>>(
                        stream: widget.danhSachCubit.statusNhiemVuCaNhanSuject,
                        initialData:
                            widget.danhSachCubit.chartDataNhiemVuCaNhan,
                        builder: (context, snapshot) {
                          final data = snapshot.data ??
                              widget.danhSachCubit.chartDataNhiemVuCaNhan;
                          return BieuDoNhiemVuCaNhanRowTablet(
                            chartData: data,
                            cubit: widget.danhSachCubit,
                            ontap: (value) {
                              widget.danhSachCubit.mangTrangThai = value;
                              widget.danhSachCubit.trangThaiHanXuLy = null;
                              setState(() {
                                widget.danhSachCubit.loadMoreList.clear();
                                widget.danhSachCubit.postDanhSachNhiemVu(
                                  isNhiemVuCaNhan: widget.isCheck,
                                  isSortByHanXuLy: true,
                                  mangTrangThai: [
                                    widget.danhSachCubit.mangTrangThai
                                  ],
                                  ngayTaoNhiemVu: {
                                    'FromDate':
                                        widget.danhSachCubit.ngayDauTien,
                                    'ToDate': widget.danhSachCubit.ngayKetThuc
                                  },
                                  size: widget.danhSachCubit.pageSize,
                                  keySearch: widget.danhSachCubit.keySearch,
                                  trangThaiHanXuLy:
                                      widget.danhSachCubit.trangThaiHanXuLy,
                                );
                              });
                            },
                            onTapStatusBox: (value_status_box) {
                              widget.danhSachCubit.mangTrangThai = '';
                              widget.danhSachCubit.trangThaiHanXuLy =
                                  value_status_box;
                              setState(() {
                                widget.danhSachCubit.loadMoreList.clear();
                                widget.danhSachCubit.postDanhSachNhiemVu(
                                  isNhiemVuCaNhan: widget.isCheck,
                                  isSortByHanXuLy: true,
                                  mangTrangThai: [
                                    widget.danhSachCubit.mangTrangThai
                                  ],
                                  ngayTaoNhiemVu: {
                                    'FromDate':
                                        widget.danhSachCubit.ngayDauTien,
                                    'ToDate': widget.danhSachCubit.ngayKetThuc
                                  },
                                  size: widget.danhSachCubit.pageSize,
                                  keySearch: widget.danhSachCubit.keySearch,
                                  trangThaiHanXuLy:
                                      widget.danhSachCubit.trangThaiHanXuLy,
                                );
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        callApi: (page) {
          widget.danhSachCubit.postDanhSachNhiemVu(
            index: page,
            isNhiemVuCaNhan: widget.isCheck,
            isSortByHanXuLy: true,
            mangTrangThai: [widget.danhSachCubit.mangTrangThai],
            ngayTaoNhiemVu: {
              'FromDate': widget.danhSachCubit.ngayDauTien,
              'ToDate': widget.danhSachCubit.ngayKetThuc
            },
            size: widget.danhSachCubit.pageSize,
            keySearch: widget.danhSachCubit.keySearch,
            trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
          );
        },
        isListView: true,
        cubit: widget.danhSachCubit,
        viewItem: (value, index) {
          try {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: NhiemVuItemTabletNew(
                data: value as PageData,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChiTietNhiemVuTabletScreen(
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
      ),
    );
  }
}
