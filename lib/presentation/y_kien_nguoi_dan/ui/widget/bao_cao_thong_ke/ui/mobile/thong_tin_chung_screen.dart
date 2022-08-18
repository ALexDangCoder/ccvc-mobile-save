import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/chi_tiet_pakn.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/dropdown_trang_thai_pakn.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/screen_controller.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinChungYKNDScreen extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDScreen({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDScreenState createState() =>
      _ThongTinChungYKNDScreenState();
}

class _ThongTinChungYKNDScreenState extends State<ThongTinChungYKNDScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cubit.initTimeRange();
    widget.cubit.getDashBoardPAKNTiepCanXuLy();
    widget.cubit.getDanhSachPAKN();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: StreamBuilder<bool>(
          initialData: false,
          stream: widget.cubit.selectSearch,
          builder: (context, snapshot) {
            final data = snapshot.data ?? false;
            return data
                ? SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: cellColorborder,
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        // focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.black,
                        style: tokenDetailAmount(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          prefixIcon: GestureDetector(
                            onTap: () {
                              widget.cubit.setSelectSearch();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: coloriCon,
                            ),
                          ),
                          suffixIcon: widget.cubit.showCleanText
                              ? GestureDetector(
                                  onTap: () {
                                    controller.clear();
                                    widget.cubit.tuKhoa = '';
                                    widget.cubit.clearDSPAKN();
                                    widget.cubit
                                        .getDanhSachPAKN(isSearch: true);
                                    widget.cubit.showCleanText = false;
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: coloriCon,
                                  ),
                                )
                              : const SizedBox(),
                          border: InputBorder.none,
                          hintText: S.current.tim_kiem,
                          hintStyle: const TextStyle(
                            color: coloriCon,
                            fontSize: 14,
                          ),
                        ),
                        onChanged: (searchText) {
                          if (searchText.isEmpty) {
                            setState(() {});
                            widget.cubit.showCleanText = false;
                            widget.cubit.tuKhoa = '';
                            widget.cubit.clearDSPAKN();
                            widget.cubit.getDanhSachPAKN(isSearch: true);
                          } else {
                            widget.cubit.debouncer.run(() {
                              setState(() {});
                              widget.cubit.tuKhoa = searchText.trim();
                              widget.cubit.clearDSPAKN();
                              widget.cubit.getDanhSachPAKN(isSearch: true);
                              widget.cubit.showCleanText = true;
                            });
                          }
                        },
                      ),
                    ),
                  )
                : AppBar(
                    elevation: 0.0,
                    title: Text(
                      S.current.thong_tin_pakn,
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
                          // widget.cubit.setSelectSearch();
                          widget.cubit.setSelectSearch();
                        },
                        child: SvgPicture.asset(ImageAssets.icSearchPAKN),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          DrawerSlide.navigatorSlide(
                            context: context,
                            screen: YKienNguoiDanMenu(
                              cubit: widget.cubit,
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
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.cubit.isShowFilterList.add(false);
        },
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          stream: widget.cubit.stateStream,
          error: AppException('', S.current.something_went_wrong),
          retry: () {
            widget.cubit.initTimeRange();
            widget.cubit.getDashBoardPAKNTiepCanXuLy();
            widget.cubit.getDanhSachPAKN();
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (widget.cubit.canLoadMoreList &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                if (!widget.cubit.isFilter) {
                  widget.cubit.loadMoreGetDSPAKN();
                } else {
                  if (widget.cubit.isFilterTiepNhan) {
                    widget.cubit.loadMorePAKNVanBanFilter();
                    widget.cubit.loadMorePAKNVanBanFilter();
                  } else if (widget.cubit.isFilterXuLy) {
                    widget.cubit.loadMorePAKNXuLyCacYKienFilter();
                  } else {
                    widget.cubit.loadMoreGetDSPAKNFilter();
                  }
                }
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                widget.cubit.resetBeforeRefresh();
                await widget.cubit.getDashBoardPAKNTiepCanXuLy();
                await widget.cubit.getDanhSachPAKN();
                widget.cubit.textFilter.sink.add(
                  TextTrangThai(
                    S.current.all,
                    color3D5586,
                  ),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterDateTimeWidget(
                      initStartDate: widget.cubit.initStartDate,
                      context: context,
                      onChooseDateFilter:
                          (DateTime startDate, DateTime endDate) async {
                        widget.cubit.startDate =
                            startDate.toStringWithListFormat;
                        widget.cubit.endDate = endDate.toStringWithListFormat;
                        widget.cubit.clearDSPAKN();
                        await widget.cubit.getDashBoardPAKNTiepCanXuLy();
                        if(widget.cubit.trangThaiFilter!=null){
                          await widget.cubit.getDanhSachPAKNFilterChart();
                        }
                        else{
                          await widget.cubit.getDanhSachPAKN();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ExpandPAKNWidget(
                        name: S.current.tinh_hinh_xu_ly_pakn,
                        child: StreamBuilder<DashBoardPAKNModel>(
                          stream:
                              widget.cubit.dashBoardPAKNTiepCanXuLyBHVSJ.stream,
                          builder: (context, snapshot) {
                            final data = snapshot.data ??
                                DashBoardPAKNModel(
                                  dashBoardHanXuLyPAKNModel:
                                      DashBoardHanXuLyPAKNModel(),
                                  dashBoardTiepNhanPAKNModel:
                                      DashBoardTiepNhanPAKNModel(),
                                  dashBoardXuLyPAKNModelModel:
                                      DashBoardXuLyPAKNModel(),
                                );
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                TiepCanWidget(
                                  model: data,
                                  cubit: widget.cubit,
                                ),
                                const SizedBox(
                                  height: 33,
                                ),
                                XuLyWidget(
                                  model: data,
                                  cubit: widget.cubit,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      color: homeColor,
                      height: 6,
                    ),
                    spaceH20,
                    StreamBuilder<List<DanhSachKetQuaPAKNModel>>(
                      stream: widget.cubit.listDanhSachKetQuaPakn.stream,
                      initialData: const [],
                      builder: (context, snapShot) {
                        final data = snapShot.data ?? [];
                        if (data.isEmpty) {
                          widget.cubit.isEmptyData = true;
                          return Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            S.current.danh_sach_pakn,
                                            style: textNormalCustom(
                                              color: textTitle,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: StreamBuilder<TextTrangThai>(
                                            stream:
                                                widget.cubit.textFilter.stream,
                                            builder: (context, snapshot) {
                                              return item(
                                                title:
                                                    snapshot.data?.text ?? '',
                                                callBack: (value) {
                                                  widget.cubit.isShowFilterList
                                                      .add(true);
                                                },
                                                colorBG: snapshot.data?.color ??
                                                    Colors.red,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  spaceH10,
                                  _noData(),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                child: StreamBuilder<bool>(
                                  stream: widget.cubit.isShowFilterList,
                                  builder: (context, snapshot) {
                                    final isShow = snapshot.data ?? false;
                                    return isShow
                                        ? DropDownTrangThaiPAKN(
                                            cubit: widget.cubit,
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            S.current.danh_sach_pakn,
                                            style: textNormalCustom(
                                              color: textTitle,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: StreamBuilder<TextTrangThai>(
                                            stream:
                                                widget.cubit.textFilter.stream,
                                            builder: (context, snapshot) {
                                              return item(
                                                title:
                                                    snapshot.data?.text ?? '',
                                                callBack: (value) {
                                                  widget.cubit.isShowFilterList
                                                      .add(true);
                                                },
                                                colorBG: snapshot.data?.color ??
                                                    Colors.red,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return _itemDanhSachPAKN(
                                        dsKetQuaPakn: data[index],
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                child: StreamBuilder<bool>(
                                  stream: widget.cubit.isShowFilterList,
                                  builder: (context, snapshot) {
                                    final isShow = snapshot.data ?? false;
                                    return isShow
                                        ? DropDownTrangThaiPAKN(
                                            cubit: widget.cubit,
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _noData() {
    return Column(
      children: [
        const SizedBox(
          height: 30.0,
        ),
        SvgPicture.asset(
          ImageAssets.icNoDataNhiemVu,
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          S.current.khong_co_thong_tin_pakn,
          style: textNormalCustom(
            fontSize: 16.0,
            color: grayChart,
          ),
        ),
        const SizedBox(
          height: 60.0,
        ),
      ],
    );
  }

  Widget _itemDanhSachPAKN({required DanhSachKetQuaPAKNModel dsKetQuaPakn}) {
    return InkWell(
      onTap: () {
        goTo(
          context,
          ChiTietPKAN(
            iD: dsKetQuaPakn.id ?? '',
            taskID: dsKetQuaPakn.taskId ?? '',
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(color: cellColorborder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dsKetQuaPakn.tieuDe ?? '',
              style: textNormalCustom(
                color: textTitle,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            spaceH8,
            Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    ImageAssets.icInformation,
                    height: 16,
                    width: 16,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    'Số: ${dsKetQuaPakn.soPAKN}',
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            spaceH8,
            Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    ImageAssets.icLocation,
                    height: 16,
                    width: 16,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    '${S.current.ten_ca_nhan_tc_full}: ${dsKetQuaPakn.donViGuiYeuCau ?? 'trống'}',
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            spaceH8,
            Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    ImageAssets.icTimeH,
                    height: 16,
                    width: 16,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    '${S.current.han_xu_ly}: ${dsKetQuaPakn.hanXuLy}',
                    style: textNormalCustom(
                      color: infoColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            spaceH10,
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        statusTrangThai(dsKetQuaPakn.soNgayToiHan ?? 1).text,
                        style: textNormalCustom(
                          color: statusTrangThai(dsKetQuaPakn.soNgayToiHan ?? 1)
                              .color,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      if ((dsKetQuaPakn.trangThaiText ?? '').isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: color5A8DEE,
                          ),
                          child: Center(
                            child: Text(
                              dsKetQuaPakn.trangThaiText ?? '',
                              style: textNormalCustom(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox.shrink()
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextTrangThai statusTrangThai(int soNgayToiHan) {
    if (soNgayToiHan < 0) {
      return TextTrangThai(S.current.qua_han, statusCalenderRed);
    } else if (soNgayToiHan > 3) {
      return TextTrangThai(S.current.trong_han, choTrinhKyColor);
    } else {
      return TextTrangThai(S.current.den_han, choVaoSoColor);
    }
  }

  Widget item({
    required Color colorBG,
    required String title,
    required Function(TextTrangThai) callBack,
  }) {
    return InkWell(
      onTap: () => callBack(TextTrangThai(title, colorBG)),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: AppTheme.getInstance().colorField(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                title,
                style: textNormalCustom(
                  color: AppTheme.getInstance().dfBtnTxtColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Expanded(
              child: Icon(Icons.keyboard_arrow_down_outlined, color: AqiColor),
            )
          ],
        ),
      ),
    );
  }
}
