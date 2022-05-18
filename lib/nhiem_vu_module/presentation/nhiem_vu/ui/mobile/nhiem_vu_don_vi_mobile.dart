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
import 'package:flutter/material.dart';
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
                ? Container(
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
      body: ComplexLoadMore(
        childrenView: [
          FilterDateTimeWidget(
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
                      return statusWidget([
                        ChartData(
                          S.current.cho_phan_xu_ly,
                          8,
                          choXuLyColor,
                        ),
                        ChartData(S.current.chua_thuc_hien, 8, choVaoSoColor),
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
                      ]);
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
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
