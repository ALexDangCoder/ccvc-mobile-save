import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/tab_danh_ba_ca_nhan.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/tab_danh_ba_ca_nhan_fix/phone/tab_danh_ba_ca_nhan_fix.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/widget/tab_danh_ba_to_chuc.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DanhBaDienTuMobile extends StatefulWidget {
  const DanhBaDienTuMobile({Key? key}) : super(key: key);

  @override
  _DanhBaDienTuMobileState createState() => _DanhBaDienTuMobileState();
}

class _DanhBaDienTuMobileState extends State<DanhBaDienTuMobile> {
  var _controller = TabController(vsync: AnimatedListState(), length: 2);

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: AnimatedListState(), length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          S.current.danh_ba_dien_tu,
          style: titleAppbar(),
        ),
        centerTitle: true,
        actions: const [],
        leading: IconButton(
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: indicatorColor,
          unselectedLabelColor: unselectLabelColor,
          labelColor: numberColorTablet,
          tabs: [
            Tab(
              child: Text(
                S.current.danh_ba_to_chuc,
              ),
            ),
            Tab(
              child: Text(S.current.danh_ba_ca_nhan),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [DanhBaToChuc(), DanhBaCaNhanFix()],
      ),
    );
  }
}
