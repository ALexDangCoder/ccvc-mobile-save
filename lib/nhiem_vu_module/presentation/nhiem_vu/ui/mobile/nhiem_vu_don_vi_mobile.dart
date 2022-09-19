import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/trang_thai_bieu_do_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_trang_thai_theo_loai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/state_select_bieu_do_trang_thai.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

class NhiemVuDonViMobile extends StatefulWidget {
  final String maTrangThai;
  final bool isCheck;
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;

  const NhiemVuDonViMobile({
    Key? key,
    required this.isCheck,
    required this.danhSachCubit,
    required this.nhiemVuCubit,
    this.maTrangThai = '',
  }) : super(key: key);

  @override
  _NhiemVuDonViMobileState createState() => _NhiemVuDonViMobileState();
}

class _NhiemVuDonViMobileState extends State<NhiemVuDonViMobile> {
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.danhSachCubit.mangTrangThai = widget.maTrangThai;
    if (widget.maTrangThai.isNotEmpty) {
      widget.danhSachCubit.callApiDonVi(false, canCallApi: false);
    } else {
      widget.danhSachCubit.callApiDonVi(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: widget.danhSachCubit.checkClickSearchStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: cellColorborder,
                        ),
                      ),
                      child: TextFormField(
                        controller: textcontroller,
                        // focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: colorBlack,
                        style: tokenDetailAmount(
                          color: colorBlack,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          suffixIcon: widget.danhSachCubit.isHideClearData
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {});
                                        textcontroller.clear();
                                        widget.danhSachCubit.isHideClearData =
                                            false;
                                        widget.danhSachCubit.keySearch = '';
                                        widget.danhSachCubit.mangTrangThai = '';
                                        widget.danhSachCubit.loadMoreList
                                            .clear();
                                        widget.danhSachCubit
                                            .postDanhSachNhiemVu(
                                          isNhiemVuCaNhan: widget.isCheck,
                                          isSortByHanXuLy: true,
                                          mangTrangThai: [
                                            widget.danhSachCubit.mangTrangThai
                                          ],
                                          ngayTaoNhiemVu: {
                                            'FromDate': widget
                                                .danhSachCubit.ngayDauTien,
                                            'ToDate':
                                                widget.danhSachCubit.ngayKetThuc
                                          },
                                          size: widget.danhSachCubit.pageSize,
                                          keySearch:
                                              widget.danhSachCubit.keySearch,
                                          trangThaiHanXuLy: widget
                                              .danhSachCubit.trangThaiHanXuLy,
                                        );
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        color: coloriCon,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          prefixIcon: GestureDetector(
                            onTap: () {
                              widget.danhSachCubit.setSelectSearch();
                            },
                            child: const Icon(
                              Icons.search,
                              color: coloriCon,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: S.current.tim_kiem,
                          hintStyle: const TextStyle(
                            color: coloriCon,
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (text) {
                          widget.danhSachCubit.loadMoreList.clear();
                          if (text.isEmpty) {
                            setState(() {});
                            widget.danhSachCubit.isHideClearData = false;
                            widget.danhSachCubit.keySearch = text;
                            widget.danhSachCubit.mangTrangThai = '';
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
                          } else {
                            widget.danhSachCubit.debouncer.run(() {
                              setState(() {});
                              widget.danhSachCubit.keySearch = text;
                              widget.danhSachCubit.mangTrangThai = '';
                              widget.danhSachCubit.isHideClearData = true;
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
                            // setState(() {});

                          }
                        },
                      ),
                    ),
                  )
                : AppBar(
                    elevation: 0.0,
                    title: Text(
                      S.current.nhiem_vu_don_vi,
                      style: titleAppbar(fontSize: 18.0.textScale(space: 6.0)),
                    ),
                    leading: IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: SvgPicture.asset(
                        ImageAssets.icBack,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          widget.danhSachCubit.setSelectSearch();
                        },
                        child: const Icon(
                          Icons.search,
                          color: textBodyTime,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          DrawerSlide.navigatorSlide(
                            context: context,
                            screen: NhiemVuMenuMobile(
                              cubit: widget.nhiemVuCubit,
                            ),
                          );
                        },
                        child: SvgPicture.asset(ImageAssets.icMenuCalender),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                    centerTitle: true,
                  );
          },
        ),
      ),
      body: ComplexLoadMore(
        childrenView: [
          FilterDateTimeWidget(
            initStartDate: DateTime.parse(widget.danhSachCubit.ngayDauTien),
            context: context,
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(widget.isCheck);
            },
          ),
          ExpandOnlyWidget(
            isPaddingIcon: true,
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
                      style:
                          textNormalCustom(color: color3D5586, fontSize: 16),
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
                    padding: const EdgeInsets.only(bottom: 20.0, left: 16.0),
                    child: StreamBuilder<List<ChartData>>(
                        stream: widget.danhSachCubit.statusSuject,
                        initialData: widget.danhSachCubit.chartDataTheoLoai,
                        builder: (context, snapshot) {
                          final data = snapshot.data ??
                              widget.danhSachCubit.chartDataTheoLoai;
                          return BieuDoTrangThaiTheoLoaiMobile(
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
                        }),
                  );
                } else if (data.map((e) => e.isCheck).elementAt(1) == true) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 16.0),
                    child: BieuDoNhiemVuMobile(
                      title: S.current.nhiem_vu,
                      chartData: widget.danhSachCubit.chartData,
                      cubit: widget.danhSachCubit,
                      ontap: (value) {
                        widget.danhSachCubit.trangThaiHanXuLy = null;
                        widget.danhSachCubit.mangTrangThai = value;
                        setState(() {
                          widget.danhSachCubit.loadMoreList.clear();
                          widget.danhSachCubit.postDanhSachNhiemVu(
                            isNhiemVuCaNhan: widget.isCheck,
                            isSortByHanXuLy: true,
                            ngayTaoNhiemVu: {
                              'FromDate': widget.danhSachCubit.ngayDauTien,
                              'ToDate': widget.danhSachCubit.ngayKetThuc
                            },
                            size: widget.danhSachCubit.pageSize,
                            keySearch: widget.danhSachCubit.keySearch,
                            trangThaiHanXuLy:
                                widget.danhSachCubit.trangThaiHanXuLy,
                            mangTrangThai: [value],
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
                          ? StatusWidget(
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
          Container(
            height: 6,
            color: homeColor,
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

class MySeparator extends StatelessWidget {
  const MySeparator({
    Key? key,
    this.width = 1,
    this.color = colorBlack,
    this.height = 10,
    required this.dashCountRow,
    required this.heSo,
    required this.scale,
  }) : super(key: key);
  final double width;
  final Color color;
  final double height;
  final int dashCountRow;
  final int heSo;
  final int scale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const dashHeight = 6.0;
        final dashWidth = width;
        final dashCount = (height / (dashHeight * 1.5)).floor() + 1;
        return Row(
          children: List.generate(dashCountRow, (index) {
            final String indexTrucHoanh = (index * scale).toString();
            return SizedBox(
              width: (heSo * scale).toDouble(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: List.generate(dashCount, (_) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: dashHeight / 2),
                        child: SizedBox(
                          height: dashHeight,
                          width: dashWidth,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: color),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    indexTrucHoanh,
                    style: textNormal(
                      coloriCon,
                      12,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class StatusWidget extends StatefulWidget {
  final List<List<ChartData>> listData;
  final List<ChartData> listStatusData;
  final List<String> title;
  final DanhSachCubit danhSachCubit;
  final bool isCheck;

  const StatusWidget({
    Key? key,
    required this.listData,
    required this.listStatusData,
    required this.title,
    required this.danhSachCubit,
    required this.isCheck,
  }) : super(key: key);

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
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
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: List.generate(widget.title.length, (index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 8, top: 20, left: 16),
                      child: Text(
                        widget.title[index],
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textNormal(
                          infoColor,
                          14.0,
                        ),
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
                          color: colorECEEF7,
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
            children: List.generate(widget.listStatusData.length, (index) {
              final result = widget.listStatusData[index];
              return GestureDetector(
                onTap: () {
                  widget.danhSachCubit.loadMoreList.clear();
                  widget.danhSachCubit.mangTrangThai = result.title
                      .split(' ')
                      .join('_')
                      .toUpperCase()
                      .vietNameseParse();
                  widget.danhSachCubit.trangThaiHanXuLy = null;
                  setState(() {
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
