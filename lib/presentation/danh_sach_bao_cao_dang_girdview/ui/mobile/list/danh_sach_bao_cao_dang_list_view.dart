import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/list/widget/item_list.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/mobile/base_app_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DanhSachBaoCaoDangListViewMobile extends StatefulWidget {
  const DanhSachBaoCaoDangListViewMobile({Key? key}) : super(key: key);

  @override
  _DanhSachBaoCaoDangListViewMobileState createState() =>
      _DanhSachBaoCaoDangListViewMobileState();
}

class _DanhSachBaoCaoDangListViewMobileState
    extends State<DanhSachBaoCaoDangListViewMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarMobile(
        title: S.current.bac_cao,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(ImageAssets.icListHopMobile),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: ListView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ItemList();
            },
          ),
        ),
      ),
    );
  }
}
