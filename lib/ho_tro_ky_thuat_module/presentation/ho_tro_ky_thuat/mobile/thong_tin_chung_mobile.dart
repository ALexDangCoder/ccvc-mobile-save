import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/resources/styles.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/bloc/ho_tro_ky_thuat_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/menu/ho_tro_ky_thuat_menu_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/mobile/danh_sach_su_co_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/item_collapse.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/presentation/ho_tro_ky_thuat/widget/widget_tong_dai_mobile.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/widget/appbar/mobile/base_app_bar_mobile.dart';
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
    widget.cubit.getTongDai();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMobile(),
      floatingActionButton: floatingHTKT(),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ItemCollapse(
                title: [
                  Expanded(
                    child: Text(
                      'Danh uật Danh sách thông tin cán bộ hỗ trợ kỹ thuật',
                      style: textNormalCustom(
                        color: AppTheme.getInstance().titleColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                child: Container(
                  color: Colors.blue,
                  height: 100,
                  width: 100,
                  child: Text('asdfsadfsadfsad'),
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
