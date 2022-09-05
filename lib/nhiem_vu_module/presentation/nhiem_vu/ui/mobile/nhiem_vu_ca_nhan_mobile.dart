import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/danh_sach/widget/bieu_do_nhiem_vu_ca_nhan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/nhiem_vu_item_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listview/list_complex_load_more.dart';
import 'package:ccvc_mobile/widgets/listview/listview_loadmore.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NhiemVuCaNhanMobile extends StatefulWidget {
  final String maTrangThai;
  final bool isCheck;
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;

  const NhiemVuCaNhanMobile({
    Key? key,
    required this.isCheck,
    required this.danhSachCubit,
    required this.nhiemVuCubit,
    this.maTrangThai = '',
  }) : super(key: key);

  @override
  _NhiemVuCaNhanMobileState createState() => _NhiemVuCaNhanMobileState();
}

class _NhiemVuCaNhanMobileState extends State<NhiemVuCaNhanMobile> {
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.danhSachCubit.mangTrangThai = widget.maTrangThai;
    widget.danhSachCubit.keySearch = '';
    if (widget.maTrangThai.isNotEmpty) {
      widget.danhSachCubit.callApi(true, canCallApi: false);
    } else {
      widget.danhSachCubit.callApi(true);
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
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
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
                                        widget
                                            .danhSachCubit.checkClickSearch.sink
                                            .add(false);
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
                      S.current.nhiem_vu_ca_nhan,
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
                        child: Icon(
                          Icons.search,
                          color: AppTheme.getInstance().colorField(),
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
            initStartDate: DateTime.parse(widget.danhSachCubit.ngayDauTien),
            onChooseDateFilter: (startDate, endDate) {
              widget.danhSachCubit.ngayDauTien = startDate.formatApi;
              widget.danhSachCubit.ngayKetThuc = endDate.formatApi;
              widget.danhSachCubit.callApiDashBroash(true);
            },
          ),
          ExpandOnlyWidget(
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
                          textNormalCustom(color: color3D5586, fontSize: 16),
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
                    initialData: widget.danhSachCubit.chartDataNhiemVuCaNhan,
                    builder: (context, snapshot) {
                      final data = snapshot.data ??
                          widget.danhSachCubit.chartDataNhiemVuCaNhan;
                      return BieuDoNhiemVuCaNhan(
                        title: S.current.nhiem_vu,
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

  Widget _content(List<String> mangTrangThai, int? trangThaiHanXuLy) {
    return ListViewLoadMore(
      cubit: widget.danhSachCubit,
      isListView: true,
      callApi: (page) => {
        widget.danhSachCubit.postDanhSachNhiemVu(
          index: page,
          isNhiemVuCaNhan: widget.isCheck,
          isSortByHanXuLy: true,
          mangTrangThai: mangTrangThai,
          ngayTaoNhiemVu: {
            'FromDate': widget.danhSachCubit.ngayDauTien,
            'ToDate': widget.danhSachCubit.ngayKetThuc
          },
          size: widget.danhSachCubit.pageSize,
          keySearch: widget.danhSachCubit.keySearch,
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
