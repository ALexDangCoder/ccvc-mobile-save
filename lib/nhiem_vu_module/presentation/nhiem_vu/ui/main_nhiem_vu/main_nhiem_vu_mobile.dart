import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/bao_cao_thong_ke_nhiem_vu_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/nhiem_vu_ca_nhan_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/mobile/nhiem_vu_don_vi_mobile.dart';
import 'package:ccvc_mobile/nhiem_vu_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainNhieVuMobile extends StatefulWidget {
  const MainNhieVuMobile({Key? key}) : super(key: key);

  @override
  _MainNhieVuMobileState createState() => _MainNhieVuMobileState();
}

class _MainNhieVuMobileState extends State<MainNhieVuMobile> {
  late final NhiemVuCubit cubit;
  late String title;

  @override
  void initState() {
    cubit = NhiemVuCubit();
    cubit.emit(NhiemVuCaNhan());
    title = S.current.nhiem_vu_ca_nhan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NhiemVuCubit, NhiemVuState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is NhiemVuCaNhan) {
          title = S.current.nhiem_vu_ca_nhan;
        } else if(state is NhiemVuDonVi) {
          title = S.current.nhiem_vu_don_vi;
        }else{
          title = S.current.bao_cao_thong_ke;
        }

        return Scaffold(
          appBar: BaseAppBar(
            title: title,
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
                      cubit: cubit,
                    ),
                  );
                },
                icon: SvgPicture.asset(ImageAssets.icMenuCalender),
              )
            ],
          ),
          body: BlocBuilder<NhiemVuCubit, NhiemVuState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is NhiemVuCaNhan) {
                return const NhiemVuCaNhanMobile(
                  isCheck: true,
                );
              } else if(state is NhiemVuDonVi) {
                return const NhiemVuDonViMobile(
                  isCheck: false,
                );
              }else{
                return const BaoCaoThongKeNhiemVuMobile();
              }
            },
          ),
        );
      },
    );
  }
}
