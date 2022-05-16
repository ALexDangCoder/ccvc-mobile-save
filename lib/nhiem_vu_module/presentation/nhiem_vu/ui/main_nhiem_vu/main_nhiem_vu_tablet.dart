import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_state.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/menu/nhiem_vu_menu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/nhiem_vu_ca_nhan_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/nhiem_vu_don_vi_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainNhiemVuTablet extends StatefulWidget {
  const MainNhiemVuTablet({Key? key}) : super(key: key);

  @override
  _MainNhiemVuTabletState createState() => _MainNhiemVuTabletState();
}

class _MainNhiemVuTabletState extends State<MainNhiemVuTablet>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  late ScrollController scrollController;
  late NhiemVuCubit cubit;
  late String title;

  @override
  void initState() {
    cubit = NhiemVuCubit();
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    title = S.current.nhiem_vu_ca_nhan;
    cubit.emit(NhiemVuCaNhan());

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
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(
                ImageAssets.icBack,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NhiemVuMenuTablet(
                        cubit: cubit,
                      ),
                    ),
                  );
                },
                icon: SvgPicture.asset(ImageAssets.icMenuLichHopTablet),
              )
            ],
          ),
          body: BlocBuilder<NhiemVuCubit, NhiemVuState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is NhiemVuCaNhan) {
                return NhiemVuCaNhanTablet(
                  cubit: cubit,
                  isCheck: true,
                );
              } else {
                return NhiemVuDonViTablet(
                  cubit: cubit,
                  isCheck: false,
                );
              }
            },
          ),
        );
      },
    );
  }
}
