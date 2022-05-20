import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/trang_thai_bieu_do_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/bieu_do_don_vi_row_tablet.dart';import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/bieu_do_don_vi_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_trang_thai_theo_loai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_tablet_new.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/state_select_bieu_do_trang_thai.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget_tablet.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';

class NhiemVuDonViTablet extends StatefulWidget {
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit cubit;
  final bool isCheck;

  const NhiemVuDonViTablet({
    Key? key,
    required this.danhSachCubit,
    required this.cubit,
    required this.isCheck,
  }) : super(key: key);

  @override
  _NhiemVuDonViTabletState createState() => _NhiemVuDonViTabletState();
}

class _NhiemVuDonViTabletState extends State<NhiemVuDonViTablet> {
  TextEditingController textcontroller = TextEditingController();
  late Function(int page) callBack;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.danhSachCubit.callApiDonVi(false);
    callBack = (page) {
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
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      body: ComplexLoadMore(
        childrenView: [
          FilterDateTimeWidgetTablet(
            initStartDate:DateTime.parse(widget.danhSachCubit.ngayDauTien) ,
            context: context,
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(true);
            },
            controller: textcontroller,
            onChange: (text) {
              widget.danhSachCubit.debouncer.run(() {
                setState(() {});
                widget.danhSachCubit.keySearch = text;
                widget.danhSachCubit.mangTrangThai = '';
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
                  isPadingIcon: true,
                  initExpand: true,
                  header: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16.0),
                          child: Text(
                            S.current.tong_hop_tinh_hinh_xu_ly_nhiem_vu,
                            style: textNormalCustom(
                                color: titleColor, fontSize: 16),
                          ),
                        ),
                        StateSelectBieuDoTrangThaiWidget(
                          cubit: widget.danhSachCubit,
                        ),
                      ],
                    ),
                  ),
                  child: StreamBuilder<List<ItemSellectBieuDo>>(
                      stream: widget.danhSachCubit.selectBieuDoModelSubject,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        if (data.isEmpty) {
                          return const SizedBox();
                        }
                        if (data.map((e) => e.isCheck).first == true) {
                          return Container(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, left: 16.0),
                            child: StreamBuilder<List<ChartData>>(
                              stream: widget.danhSachCubit.statusSuject,
                              initialData:
                                  widget.danhSachCubit.chartDataTheoLoai,
                              builder: (context, snapshot) {
                                final data = snapshot.data ??
                                    widget.danhSachCubit.chartDataTheoLoai;
                                return BieuDoNhiemVuDonViRowTablet(
                                  chartData: data,
                                  cubit: widget.danhSachCubit,
                                  ontap: (value) {
                                    widget.danhSachCubit.mangTrangThai = value;
                                    widget.danhSachCubit.trangThaiHanXuLy =
                                        null;
                                    setState(() {
                                      callBack;
                                    });
                                  },
                                  onTapStatusBox: (value_status_box) {
                                    widget.danhSachCubit.mangTrangThai = '';
                                    widget.danhSachCubit.trangThaiHanXuLy =
                                        value_status_box;
                                    setState(() {
                                      callBack;
                                    });
                                  },
                                );
                              },
                            ),
                          );
                        } else if (data.map((e) => e.isCheck).elementAt(1) ==
                            true) {
                          return Container(
                            padding:
                                const EdgeInsets.only(bottom: 20.0, left: 16.0),
                            child: BieuDoTrangThaiTheoLoaiMobile(
                              chartData: widget.danhSachCubit.chartDataTheoLoai,
                              cubit: widget.danhSachCubit,
                              ontap: (value) {
                                widget.danhSachCubit.mangTrangThai = value;
                                widget.danhSachCubit.trangThaiHanXuLy = null;
                                setState(() {
                                  callBack;
                                });
                              },
                            ),
                          );
                        } else {
                          return statusWidget([
                            ChartData(
                              S.current.cho_phan_xu_ly,
                              8,
                              choXuLyColor,
                            ),
                            ChartData(
                                S.current.chua_thuc_hien, 8, choVaoSoColor),
                            ChartData(
                              S.current.dang_thuc_hien,
                              5,
                              choTrinhKyColor,
                            ),
                            ChartData(
                              S.current.da_thuc_hien,
                              8,
                              daXuLyColor,
                            ),
                          ], [
                            ChartData(
                              S.current.cho_phan_xu_ly,
                              30,
                              choXuLyColor,
                            ),
                            ChartData(
                                S.current.chua_thuc_hien, 12, choVaoSoColor),
                            ChartData(
                              S.current.dang_thuc_hien,
                              14,
                              choTrinhKyColor,
                            ),
                            ChartData(
                              S.current.da_thuc_hien,
                              12,
                              daXuLyColor,
                            ),
                          ]);
                        }
                      })),
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
              padding: const EdgeInsets.symmetric(horizontal: 30),
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

Widget statusWidget(
  List<ChartData> listData,
  List<ChartData> listData2,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          const Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Trung tâm tin học",
                  textAlign: TextAlign.right,
                ),
              )),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: listData.reversed
                        .map(
                          (e) => Expanded(
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
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 24,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 20.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 9,
          mainAxisSpacing: 10.0.textScale(space: 4),
          crossAxisSpacing: 10,
          children: List.generate(listData2.length, (index) {
            final result = listData2[index];
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
      ),
    ],
  );
}
