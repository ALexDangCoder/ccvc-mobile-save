import 'package:ccvc_mobile/config/resources/color.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/thong_tin_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailMeetCalenderTablet extends StatefulWidget {
  final String id;
  const DetailMeetCalenderTablet({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet> {
  late DetailMeetCalenderCubit cubit;

  @override
  void initState() {
    cubit = DetailMeetCalenderCubit();

    cubit.initData(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_hop,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          MenuSelectWidget(
            listSelect: [
              QData(
                urlImage: ImageAssets.icHuy,
                text: S.current.huy_lich_hop,
                onTap: () {},
              ),
              QData(
                  urlImage: ImageAssets.ic_delete_do,
                  text: S.current.xoa_lich,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {}),
              QData(
                urlImage: ImageAssets.icThuHoi,
                text: S.current.xoa_lich,
                onTap: () {},
              ),
              QData(
                  urlImage: ImageAssets.icPhanCongThuKy,
                  text: S.current.phan_cong_thu_ky,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icTaoBocBang,
                  text: S.current.phan_cong_thu_ky,
                  onTap: () {}),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 28, left: 28, right: 28),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColorApp,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(color: borderColor.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                  color: shadowContainerColor.withOpacity(0.05))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ThongTinCuocHopWidget(
                      cubit: cubit,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
