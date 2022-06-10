import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/chi_tiet_pakn.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/mobile/widgets/y_kien_nguoi_dan_menu.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/expanded_pakn.dart';
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
    //  widget.cubit.callApi();
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
                              Icons.search,
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
                              widget.cubit.tuKhoa = searchText;
                              widget.cubit.clearDSPAKN();
                              widget.cubit.getDanhSachPAKN(isSearch: true);
                              widget.cubit.showCleanText = true;
                            });
                          }
                        },
                        onSubmitted: (searchText) {},
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
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        stream: widget.cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () {},
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (widget.cubit.canLoadMoreList &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              widget.cubit.loadMoreGetDSPAKN();
            }
            return true;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterDateTimeWidget(
                  initStartDate: widget.cubit.initStartDate,
                  context: context,
                  onChooseDateFilter: (DateTime startDate, DateTime endDate) {
                    widget.cubit.startDate = startDate.toStringWithListFormat;
                    widget.cubit.endDate = endDate.toStringWithListFormat;
                    widget.cubit.clearDSPAKN();
                    widget.cubit.getDanhSachPAKN();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ExpandPAKNWidget(
                    name: S.current.tinh_hinh_xu_ly_pakn,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        // TiepCanWidget(),
                        SizedBox(
                          height: 33,
                        ),
                        // XuLyWidget(),
                      ],
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
                      return Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                S.current.danh_sach_pakn,
                                style: textNormalCustom(
                                  color: textTitle,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
                                  fontSize: 16.0, color: grayChart),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              S.current.danh_sach_pakn,
                              style: textNormalCustom(
                                color: textTitle,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return _itemDanhSachPAKN(
                                  dsKetQuaPakn: data[index]);
                            },
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
                    '${S.current.ten_ca_nhan_tc}: ${dsKetQuaPakn.donViGuiYeuCau ?? 'trống'}',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statusTrangThai(dsKetQuaPakn.trangThai ?? 1).text,
                        style: textNormalCustom(
                          color: statusTrangThai(dsKetQuaPakn.trangThai ?? 1)
                              .color,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 15,
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: color5A8DEE,
                        ),
                        child: Text(
                          dsKetQuaPakn.trangThaiText ?? '',
                          style: textNormalCustom(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextTrangThai statusTrangThai(int trangThai) {
    switch (trangThai) {
      case YKienNguoiDanCubitt.TRONGHAN:
        {
          return TextTrangThai(S.current.trong_han, choTrinhKyColor);
        }
      case YKienNguoiDanCubitt.DENHAN:
        {
          return TextTrangThai(S.current.den_han, choVaoSoColor);
        }
      default:
        //QUA HAN
        return TextTrangThai(S.current.qua_han, statusCalenderRed);
    }
  }
}
