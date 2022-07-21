import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/color.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/tablet/danh_sach_su_co_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/chart_thong_tin_chung.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_danh_sach_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/widget_tong_dai_tablet.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinChungTablet extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const ThongTinChungTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThongTinChungTablet> createState() => _ThongTinChungTabletState();
}

class _ThongTinChungTabletState extends State<ThongTinChungTablet> {
  @override
  void initState() {
    widget.cubit.getAllApiThongTinChung();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _appBarTablet(),
      floatingActionButton: floatingHTKTTablet(
        context,
        widget.cubit,
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          widget.cubit.getAllApiThongTinChung();
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await widget.cubit.getAllApiThongTinChung();
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  spaceH28,
                  Container(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: containerColorTab,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.current.thong_ke_su_co,
                          style: textNormalCustom(
                            color: AppTheme.getInstance().titleColor(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: widget.cubit.checkDataChart,
                          builder: (context, snapshot) {
                            final isCheck = snapshot.data ?? false;
                            return isCheck
                                ? ChartThongTinChung(
                                    chartFlex: 9,
                                    titleFlex: 2,
                                    listData: widget.cubit.listDataChart,
                                    listStatusData: widget.cubit.listStatusData,
                                    listTitle: widget.cubit.listTitle,
                                    cubit: widget.cubit,
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH28,
                  Container(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 28,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: backgroundColorApp,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: containerColorTab,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowContainerColor.withOpacity(0.05),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.current.danh_sach_ho_tro_ky_thuat,
                          style: textNormalCustom(
                            color: AppTheme.getInstance().titleColor(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        StreamBuilder<List<ThanhVien>>(
                          stream: widget.cubit.listCanCoHTKT,
                          builder: (context, snapshot) {
                            final list = snapshot.data ?? [];
                            return list.isNotEmpty
                                ? GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) => Container(
                                      margin: const EdgeInsets.only(
                                        top: 18,
                                      ),
                                      child: ItemDanhSachHoTro(
                                        isLine: list.length == index + 1 ||
                                            list.length == index + 2,
                                        objThanhVien: list[index],
                                        cubit: widget.cubit,
                                      ),
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 72.0,
                                      mainAxisExtent: 80.0,
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH28,
                  StreamBuilder<List<TongDaiModel>>(
                    stream: widget.cubit.listTongDai,
                    builder: (context, snapshot) {
                      return snapshot.data?.isNotEmpty ?? false
                          ? WidgetTongDaiTablet(
                              cubit: widget.cubit,
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  spaceH28,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BaseAppBarMobile _appBarTablet() => BaseAppBarMobile(
        title: S.current.thong_tin_chung,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: HoTroKyThuatMenuMobile(
                  cubit: widget.cubit,
                ),
              );
            },
            icon: SvgPicture.asset(
              ImageAssets.icMenuCalender,
            ),
          )
        ],
      );
}
