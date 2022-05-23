import 'dart:io';
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
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class NhiemVuDonViMobile extends StatefulWidget {
  final bool isCheck;
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;

  const NhiemVuDonViMobile({
    Key? key,
    required this.isCheck,
    required this.danhSachCubit,
    required this.nhiemVuCubit,
  }) : super(key: key);

  @override
  _NhiemVuDonViMobileState createState() => _NhiemVuDonViMobileState();
}

class _NhiemVuDonViMobileState extends State<NhiemVuDonViMobile> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: widget.danhSachCubit.checkClickSearchStream,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? Platform.isIOS ? Padding(
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
                                      },
                                      child: const Icon(Icons.clear,
                                          color: coloriCon),
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
                          if (text.isEmpty) {
                            setState(() {});
                            widget.danhSachCubit.isHideClearData = false;
                          } else {
                            widget.danhSachCubit.debouncer.run(() {
                              setState(() {});
                              widget.danhSachCubit.keySearch = text;
                              widget.danhSachCubit.mangTrangThai = '';
                              widget.danhSachCubit.isHideClearData = true;
                            });
                            // setState(() {});

                          }
                        },
                      ),
                    ),
                ) : Container(
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
                        },
                        child: const Icon(Icons.clear,
                            color: coloriCon),
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
                  if (text.isEmpty) {
                    setState(() {});
                    widget.danhSachCubit.isHideClearData = false;
                  } else {
                    widget.danhSachCubit.debouncer.run(() {
                      setState(() {});
                      widget.danhSachCubit.keySearch = text;
                      widget.danhSachCubit.mangTrangThai = '';
                      widget.danhSachCubit.isHideClearData = true;
                    });
                    // setState(() {});

                  }
                },
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
      body: GestureDetector(
        onTap: (){
          if(widget.danhSachCubit.checkClickSearch.value==true) {
            widget.danhSachCubit.checkClickSearch.sink.add(false);
            widget.danhSachCubit.isHideClearData = false;
            widget.danhSachCubit.keySearch='';
            textcontroller.clear();
          }
        },
        child: ComplexLoadMore(
          childrenView: [
            FilterDateTimeWidget(
              initStartDate:DateTime.parse(widget.danhSachCubit.ngayDauTien) ,
              context: context,
              isMobile: true,
              onChooseDateFilter: (startDate, endDate) {
                widget.danhSachCubit.ngayDauTien = startDate.formatApi;
                widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
                widget.danhSachCubit.callApiDashBroash(true);
              },
            ),
            ExpandOnlyWidget(
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
                          style:
                              textNormalCustom(color: titleColor, fontSize: 16),
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
                              return BieuDoNhiemVuMobile(
                                title: S.current.nhiem_vu,
                                chartData: data,
                                cubit: widget.danhSachCubit,
                                ontap: (value) {
                                  widget.danhSachCubit.mangTrangThai = value;
                                  widget.danhSachCubit.trangThaiHanXuLy = null;
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
                        return StatusWidget(
                          listData: [
                            [
                              ChartData(
                                S.current.cho_phan_xu_ly,
                                8,
                                choXuLyColor,
                              ),
                              ChartData(
                                  S.current.chua_thuc_hien, 10, choVaoSoColor),
                              ChartData(
                                S.current.dang_thuc_hien,
                                4,
                                choTrinhKyColor,
                              ),
                              ChartData(
                                S.current.da_thuc_hien,
                                5,
                                daXuLyColor,
                              ),
                            ],
                            [
                              ChartData(
                                S.current.cho_phan_xu_ly,
                                8,
                                choXuLyColor,
                              ),
                              ChartData(
                                  S.current.chua_thuc_hien, 10, choVaoSoColor),
                              ChartData(
                                S.current.dang_thuc_hien,
                                4,
                                choTrinhKyColor,
                              ),
                              ChartData(
                                S.current.da_thuc_hien,
                                5,
                                daXuLyColor,
                              ),
                            ],
                            [
                              ChartData(
                                S.current.cho_phan_xu_ly,
                                6,
                                choXuLyColor,
                              ),
                              ChartData(
                                  S.current.chua_thuc_hien, 12, choVaoSoColor),
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
                            ],
                          ],
                          listStatusData: [
                            ChartData(
                              S.current.cho_phan_xu_ly,
                              30,
                              choXuLyColor,
                            ),
                            ChartData(S.current.chua_thuc_hien, 12, choVaoSoColor),
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
                          ],
                        );

                      }
                    })),
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
      ),
    );
  }
}

Widget statusWidget( // List<ChartData> listData,
    // List<ChartData> listTest,
    {
  required List<List<ChartData>> listData,
  required List<ChartData> listStatusData,
}) {
  final heSo = 10;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          Column(
            children: listData
                .map(
                  (element) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Trung tâm tin học",
                              textAlign: TextAlign.right,
                            ),
                          )),
                      // const SizedBox(width: 8,),
                      Expanded(
                        flex: 8,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              key:GlobalKey(),
                              child: Container(
                            ),),
                            // MySeparator(
                            //   color: lineColor,
                            // ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    children: element.reversed
                                        .map(
                                          (e) => Container(
                                            height: 28,
                                            width: (e.value) * heSo,
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
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
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
          children: List.generate(listStatusData.length, (index) {
            final result = listStatusData[index];
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

class MySeprator extends StatelessWidget {
  const MySeprator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.width = 1, this.color = Colors.black, this.height=10})
      : super(key: key);
  final double width;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashHeight = 6.0;
        final dashWidth = width;
        final dashCount = (height/(dashWidth *2)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: List.generate(dashCount, (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
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
          ],
        );
      },
    );
  }
}
class StatusWidget extends StatefulWidget {
  final List<List<ChartData>> listData;
  final  List<ChartData> listStatusData;
  const StatusWidget({Key? key, required this.listData, required this.listStatusData}) : super(key: key);

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  final heSo = 10;
  GlobalKey globalKey =GlobalKey();
  late double height=0;
  late int sumRowChart=0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
      height = renderBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              key:globalKey,
              height: 100,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.listData
                  .map(
                    (element) {
                      sumRowChart=0;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                 margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Trung tâm tin học",
                                  textAlign: TextAlign.right,
                                ),
                              )),
                          Expanded(
                            flex: 8,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: MySeparator(
                                      height: height,
                                      color: lineColor,
                                    )
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(right: 8.0,top: 8),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: element.reversed
                                                .map(
                                                    (e) {
                                                  sumRowChart+=e.value.toInt();
                                                  return  Container(
                                                    height: 28,
                                                    width: (e.value) * heSo,
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
                                                  );
                                                }
                                            )
                                                .toList(),
                                          ),
                                          SizedBox(width: 6,),
                                          Text(sumRowChart.toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
              )
                  .toList(),
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
}

