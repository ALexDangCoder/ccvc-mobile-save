import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/themes/app_theme.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/chart_data.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/danh_sach_su_co_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/chart_thong_tin_chung.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_collapse.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_danh_sach_ho_tro.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/widget_tong_dai_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/mobile/base_app_bar_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongTinChungMobile extends StatefulWidget {
  final HoTroKyThuatCubit cubit;

  const ThongTinChungMobile({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThongTinChungMobile> createState() => _ThongTinChungMobileState();
}

class _ThongTinChungMobileState extends State<ThongTinChungMobile> {
  @override
  void initState() {
    widget.cubit.getAllApiThongTinChung();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMobile(),
      floatingActionButton: floatingHTKT(),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          widget.cubit.getAllApiThongTinChung();
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await widget.cubit.getAllApiThongTinChung();
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ItemCollapse(
                          title: [
                            Expanded(
                              child: Text(
                                S.current.danh_sach_ho_tro_ky_thuat,
                                style: textNormalCustom(
                                  color: AppTheme.getInstance().titleColor(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          child: StreamBuilder<List<ThanhVien>>(
                            stream: widget.cubit.listCanCoHTKT,
                            builder: (context, snapshot) {
                              final list = snapshot.data ?? [];
                              return list.isNotEmpty
                                  ? ChartThongTinChung(
                                      listData: [//todo data
                                        [
                                          ChartData(
                                            S.current.all,
                                            11,
                                            Colors.black,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            1,
                                            Colors.red,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            11,
                                            Colors.black,
                                          ),
                                        ],
                                        [
                                          ChartData(
                                            S.current.all,
                                            22,
                                            Colors.black,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            1,
                                            Colors.red,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            11,
                                            Colors.black,
                                          ),
                                        ],
                                        [
                                          ChartData(
                                            S.current.all,
                                            11,
                                            Colors.black,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            1,
                                            Colors.black,
                                          ),
                                          ChartData(
                                            S.current.all,
                                            11,
                                            Colors.red,
                                          ),
                                        ]
                                      ],
                                      listStatusData: [
                                        ChartData(
                                          S.current.all,
                                          0,
                                          Colors.black,
                                        ),
                                        ChartData(
                                          S.current.all,
                                          1,
                                          Colors.black,
                                        ),
                                        ChartData(
                                          S.current.all,
                                          11,
                                          Colors.black,
                                        ),
                                      ],
                                      listTitle: [
                                        'doanh',
                                        'lại là doanh',
                                        'doanh 2'
                                      ],
                                      cubit: widget.cubit,
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ItemCollapse(
                          title: [
                            Expanded(
                              child: Text(
                                S.current.danh_sach_ho_tro_ky_thuat,
                                style: textNormalCustom(
                                  color: AppTheme.getInstance().titleColor(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          child: StreamBuilder<List<ThanhVien>>(
                            stream: widget.cubit.listCanCoHTKT,
                            builder: (context, snapshot) {
                              final list = snapshot.data ?? [];
                              return list.isNotEmpty
                                  ? ListView.builder(
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
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: StreamBuilder<List<TongDaiModel>>(
                stream: widget.cubit.listTongDai,
                builder: (context, snapshot) {
                  return snapshot.data?.isNotEmpty ?? false
                      ? WidgetTongDai(
                          cubit: widget.cubit,
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BaseAppBarMobile _appBarMobile() => BaseAppBarMobile(
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
