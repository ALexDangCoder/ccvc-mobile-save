import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/danh_sach_su_co_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/chart_thong_tin_chung.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_danh_sach_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/widget_tong_dai_mobile.dart';
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
      appBar: _appBarTablet(),
      floatingActionButton: floatingHTKT(
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
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await widget.cubit.getAllApiThongTinChung();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: StreamBuilder<bool>(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 28,
                          right: 28,
                          left: 28,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: const EdgeInsets.only(
                                            top: 18,
                                          ),
                                          child: ItemDanhSachHoTro(
                                            isLine: list.length == index + 1,
                                            objThanhVien: list[index],
                                            cubit: widget.cubit,
                                          ),
                                        ),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 0.0,
                                          mainAxisSpacing: 15.0,
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<List<TongDaiModel>>(
              stream: widget.cubit.listTongDai,
              builder: (context, snapshot) {
                return snapshot.data?.isNotEmpty ?? false
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: WidgetTongDai(
                          cubit: widget.cubit,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
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
