import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/trang_thai_bieu_do_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/nhiem_vu_don_vi_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/bieu_do_don_vi_row_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_trang_thai_theo_loai_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_tablet_new.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/state_select_bieu_do_trang_thai.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget_tablet.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rxdart/rxdart.dart';

class NhiemVuDonViTablet extends StatefulWidget {
  final String maTrangThai;
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit cubit;
  final bool isCheck;

  const NhiemVuDonViTablet({
    Key? key,
    required this.danhSachCubit,
    required this.cubit,
    required this.isCheck,
    this.maTrangThai='',
  }) : super(key: key);

  @override
  _NhiemVuDonViTabletState createState() => _NhiemVuDonViTabletState();
}

class _NhiemVuDonViTabletState extends State<NhiemVuDonViTablet> {
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.danhSachCubit.mangTrangThai = widget.maTrangThai;
    widget.danhSachCubit.keySearch = '';
    if(widget.maTrangThai.isNotEmpty){
      widget.danhSachCubit.callApiDonVi(false,canCallApi: false);
    }
    else{
      widget.danhSachCubit.callApiDonVi(false);
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
                keySearch: widget.danhSachCubit.keySearch,
                trangThaiHanXuLy: widget.danhSachCubit.trangThaiHanXuLy,
              );
            },
            initStartDate: DateTime.parse(widget.danhSachCubit.ngayDauTien),
            context: context,
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(widget.isCheck);
            },
            controller: textcontroller,
            onChange: (text) {
              widget.danhSachCubit.debouncer.run(() {
                setState(() {});
                widget.danhSachCubit.keySearch = text;
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 24.0),
                        child: Text(
                          S.current.tong_hop_tinh_hinh_xu_ly_nhiem_vu,
                          style: textNormalCustom(
                              color: titleColor, fontSize: 16.0.textScale()),
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
                            initialData: widget.danhSachCubit.chartDataTheoLoai,
                            builder: (context, snapshot) {
                              final data = snapshot.data ??
                                  widget.danhSachCubit.chartDataTheoLoai;
                              return BieuDoTrangThaiTheoLoaiTablet(
                                chartData: data,
                                cubit: widget.danhSachCubit,
                                ontap: (value) {
                                  widget.danhSachCubit.trangThaiHanXuLy = null;
                                  widget.danhSachCubit.loaiNhiemVuId = value;
                                  widget.danhSachCubit.loadMoreList.clear();
                                  setState(() {
                                    widget.danhSachCubit.postDanhSachNhiemVu(
                                      isNhiemVuCaNhan: widget.isCheck,
                                      isSortByHanXuLy: true,
                                      mangTrangThai: [],
                                      ngayTaoNhiemVu: {
                                        'FromDate':
                                            widget.danhSachCubit.ngayDauTien,
                                        'ToDate':
                                            widget.danhSachCubit.ngayKetThuc
                                      },
                                      size: widget.danhSachCubit.pageSize,
                                      keySearch: widget.danhSachCubit.keySearch,
                                      trangThaiHanXuLy:
                                          widget.danhSachCubit.trangThaiHanXuLy,
                                    );
                                  });
                                },
                              );
                            }),
                      );
                    } else if (data.map((e) => e.isCheck).elementAt(1) ==
                        true) {
                      return Container(
                        padding:
                            const EdgeInsets.only(bottom: 20.0, left: 16.0),
                        child: BieuDoNhiemVuDonViRowTablet(
                          chartData: widget.danhSachCubit.chartData,
                          cubit: widget.danhSachCubit,
                          ontap: (value) {
                            widget.danhSachCubit.mangTrangThai = value;
                            widget.danhSachCubit.trangThaiHanXuLy = null;
                            widget.danhSachCubit.loadMoreList.clear();
                            setState(() {
                              widget.danhSachCubit.postDanhSachNhiemVu(
                                isNhiemVuCaNhan: widget.isCheck,
                                isSortByHanXuLy: true,
                                mangTrangThai: [
                                  widget.danhSachCubit.mangTrangThai
                                ],
                                ngayTaoNhiemVu: {
                                  'FromDate': widget.danhSachCubit.ngayDauTien,
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
                            widget.danhSachCubit.loadMoreList.clear();
                            setState(() {
                              widget.danhSachCubit.postDanhSachNhiemVu(
                                isNhiemVuCaNhan: widget.isCheck,
                                isSortByHanXuLy: true,
                                mangTrangThai: [
                                  widget.danhSachCubit.mangTrangThai
                                ],
                                ngayTaoNhiemVu: {
                                  'FromDate': widget.danhSachCubit.ngayDauTien,
                                  'ToDate': widget.danhSachCubit.ngayKetThuc
                                },
                                size: widget.danhSachCubit.pageSize,
                                keySearch: widget.danhSachCubit.keySearch,
                                trangThaiHanXuLy:
                                    widget.danhSachCubit.trangThaiHanXuLy,
                              );
                            });
                          },
                        ),
                      );
                    } else {
                      return StreamBuilder<bool>(
                        stream: widget.danhSachCubit.isCheckDataNVDV,
                        builder: (context, snapshot) {
                          final checkListData = snapshot.data ?? false;
                          return checkListData
                              ? StatusWidgetTablet(
                                  listData: widget.danhSachCubit.listData,
                                  listStatusData:
                                      widget.danhSachCubit.listStatusData,
                                  title: widget.danhSachCubit.titleNhiemVu,
                                  danhSachCubit: widget.danhSachCubit,
                                  isCheck: widget.isCheck,
                                )
                              : const NodataWidget(
                                  height: 250,
                                );
                        },
                      );
                    }
                  },
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
                        donViId: value.phamViId,
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

class StatusWidgetTablet extends StatefulWidget {
  final List<List<ChartData>> listData;
  final List<ChartData> listStatusData;
  final List<String> title;
  final DanhSachCubit danhSachCubit;
  final bool isCheck;

  const StatusWidgetTablet({
    Key? key,
    required this.listData,
    required this.listStatusData,
    required this.title,
    required this.danhSachCubit,
    required this.isCheck,
  }) : super(key: key);

  @override
  _StatusWidgetTabletState createState() => _StatusWidgetTabletState();
}

class _StatusWidgetTabletState extends State<StatusWidgetTablet> {
  final heSo = 10;
  final scale = 5;
  GlobalKey globalKey = GlobalKey();
  late double height = 10;
  late int sumRowChart = 0;
  late double countRangeChart = 0;
  final BehaviorSubject<double> setHeight = BehaviorSubject.seeded(0);

  @override
  void initState() {
    super.initState();
    countRangeChart = getMaxRow(widget.listData);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final renderBox =
          globalKey.currentContext?.findRenderObject() as RenderBox;
      height = renderBox.size.height;
      setHeight.sink.add(height);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  children: List.generate(widget.title.length, (index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 8, top: 17, left: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title[index],
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textNormal(
                                infoColor,
                                14.0.textScale(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Stack(
                  children: [
                    StreamBuilder<double>(
                      stream: setHeight.stream,
                      builder: (context, snapshot) {
                        final height = snapshot.data ?? 0;
                        return MySeparator(
                          heSo: heSo,
                          scale: scale,
                          dashCountRow: countRangeChart.floor(),
                          height: height,
                          color: lineColor,
                        );
                      },
                    ),
                    Column(
                      key: globalKey,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: widget.listData.map((element) {
                              sumRowChart = 0;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                          top: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Row(
                                              children:
                                                  element.reversed.map((e) {
                                                sumRowChart += e.value.toInt();
                                                return GestureDetector(
                                                  onTap: () {
                                                    widget.danhSachCubit
                                                            .mangTrangThai =
                                                        e.title
                                                            .split(' ')
                                                            .join('_')
                                                            .toUpperCase()
                                                            .vietNameseParse();
                                                    widget.danhSachCubit
                                                            .trangThaiHanXuLy =
                                                        null;
                                                    setState(() {
                                                      widget.danhSachCubit
                                                          .loadMoreList
                                                          .clear();
                                                      widget.danhSachCubit
                                                          .postDanhSachNhiemVu(
                                                        isNhiemVuCaNhan:
                                                            widget.isCheck,
                                                        isSortByHanXuLy: true,
                                                        mangTrangThai: [
                                                          widget.danhSachCubit
                                                              .mangTrangThai
                                                        ],
                                                        ngayTaoNhiemVu: {
                                                          'FromDate': widget
                                                              .danhSachCubit
                                                              .ngayDauTien,
                                                          'ToDate': widget
                                                              .danhSachCubit
                                                              .ngayKetThuc
                                                        },
                                                        size: widget
                                                            .danhSachCubit
                                                            .pageSize,
                                                        keySearch: widget
                                                            .danhSachCubit
                                                            .keySearch,
                                                        trangThaiHanXuLy: widget
                                                            .danhSachCubit
                                                            .trangThaiHanXuLy,
                                                      );
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 28,
                                                    width: (e.value) * heSo,
                                                    color: e.color,
                                                    child: Center(
                                                      child: Text(
                                                        e.value
                                                            .toInt()
                                                            .toString(),
                                                        style: textNormal(
                                                          backgroundColorApp,
                                                          14.0.textScale(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              sumRowChart.toString(),
                                              style: textNormal(
                                                infoColor,
                                                14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(
        //   height: 24,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.listStatusData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      widget.danhSachCubit.mangTrangThai = widget
                          .listStatusData[index].title
                          .split(' ')
                          .join('_')
                          .toUpperCase()
                          .vietNameseParse();
                      widget.danhSachCubit.trangThaiHanXuLy = null;
                      setState(() {
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
                          keySearch: widget.danhSachCubit.keySearch,
                          trangThaiHanXuLy:
                              widget.danhSachCubit.trangThaiHanXuLy,
                        );
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: widget.listStatusData[index].color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              '${widget.listStatusData[index].title} (${widget.listStatusData[index].value.toInt()})',
                              style: textNormal(
                                infoColor,
                                14.0.textScale(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  double getTotalRow(List<ChartData> data) {
    double total = 0;
    for (final element in data) {
      total += element.value;
    }
    return total;
  }

  double getMaxRow(List<List<ChartData>> listData) {
    double value = 0;
    for (final element in listData) {
      final double max = getTotalRow(element);
      if (value < max) {
        value = max;
      }
    }
    final double range = value % 10;
    return (value + (10.0 - range)) / scale;
  }
}
