import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/config/resources/color.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/cubit/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/bao_cao_thong_ke/ui/widget/table_view_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../nhiem_vu/ui/mobile/bloc/danh_sach_cubit.dart';

class BaoCaoThongKeNhiemVuMobile extends StatefulWidget {
  final DanhSachCubit danhSachCubit;
  final NhiemVuCubit nhiemVuCubit;

  const BaoCaoThongKeNhiemVuMobile(
      {Key? key, required this.danhSachCubit, required this.nhiemVuCubit})
      : super(key: key);

  @override
  _BaoCaoThongKeNhiemVuMobileState createState() =>
      _BaoCaoThongKeNhiemVuMobileState();
}

class _BaoCaoThongKeNhiemVuMobileState
    extends State<BaoCaoThongKeNhiemVuMobile> {
  late BaoCaoThongKeCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = BaoCaoThongKeCubit();
    cubit.getDataTheoDonVi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.bao_cao_thong_ke,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              color: textBodyTime,
            ),
          ),
          IconButton(
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: NhiemVuMenuMobile(
                  cubit: widget.nhiemVuCubit,
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            top: 16,
            bottom: 16,
            right: 16,
          ),
          scrollDirection: Axis.horizontal,
          child: StreamBuilder<List<NhiemVuDonVi>>(
            stream: cubit.listBangThongKe,
            builder: (context, snapshot) {
              return TableViewNhiemVu(
                list: snapshot.data ?? [],
              );
            }
          ),
        ),
      ),
    );
  }
}
