import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/danh_sach_ket_qua_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/tablet/chi_tiet_pakn_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/tablet/widgets/menu_y_kien_nguoi_dan_tablet.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/tiep_can_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/xu_ly_widget.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/screen_controller.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThongTinChungYKNDTablet extends StatefulWidget {
  final YKienNguoiDanCubitt cubit;

  const ThongTinChungYKNDTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThongTinChungYKNDTabletState createState() =>
      _ThongTinChungYKNDTabletState();
}

class _ThongTinChungYKNDTabletState extends State<ThongTinChungYKNDTablet>
    with SingleTickerProviderStateMixin {
  ChooseTimeCubit chooseTimeScreen = ChooseTimeCubit();
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.cubit.initTimeRange();
    //  cubit.callApi();
    widget.cubit.getDanhSachPAKN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: MenuYKIenNguoiDanTablet(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', S.current.something_went_wrong),
          stream: widget.cubit.stateStream,
          child: SizedBox.expand(
            child: Container(
              color: homeColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    FilterDateTimeWidgetTablet(
                      initStartDate: widget.cubit.initStartDate,
                      context: context,
                      onChooseDateFilter: (startDate, endDate) {
                        widget.cubit.startDate =
                            startDate.toStringWithListFormat;
                        widget.cubit.endDate = endDate.toStringWithListFormat;
                        //  widget.cubit.clearDSPAKN();
                        widget.cubit.getDanhSachPAKN();
                      },
                      controller: textcontroller,
                      onChange: (searchText) {
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
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 66),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor.withOpacity(0.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shadowContainerColor.withOpacity(0.05),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: TiepCanWidget(),
                          ),
                          SizedBox(
                            width: 115,
                          ),
                          Expanded(
                            child: XuLyWidget(),
                          ),
                        ],
                      ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.current.danh_sach_pakn,
                                  style: textNormalCustom(
                                    color: textTitle,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
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
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _itemDanhSachPAKN({required DanhSachKetQuaPAKNModel dsKetQuaPakn}) {
    return InkWell(
      onTap: () {
        goTo(
          context,
          ChiTietPKANTablet(
            iD: dsKetQuaPakn.id ?? '',
            taskID: dsKetQuaPakn.taskId ?? '',
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: backgroundColorApp,
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
                SvgPicture.asset(
                  ImageAssets.icInformation,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(
                  width: 16.0,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  ImageAssets.icLocation,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(
                  width: 16.0,
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
                SvgPicture.asset(
                  ImageAssets.icTimeH,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(
                  width: 16.0,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 32.0,
                ),
                Text(
                  statusTrangThai(dsKetQuaPakn.trangThai ?? 1).text,
                  style: textNormalCustom(
                    color: statusTrangThai(dsKetQuaPakn.trangThai ?? 1).color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 50.0,
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
                    textAlign: TextAlign.center,
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
