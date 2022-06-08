import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/ui/menu/diem_danh_menu_mobile.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/ket_noi_module/widgets/app_bar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiemDanhCaNhanMobileScreen extends StatefulWidget {
  DiemDanhCubit cubit;

  DiemDanhCaNhanMobileScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _DiemDanhCaNhanMobileScreenState createState() =>
      _DiemDanhCaNhanMobileScreenState();
}

class _DiemDanhCaNhanMobileScreenState
    extends State<DiemDanhCaNhanMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: S.current.diem_danh_ca_nhan,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            DrawerSlide.navigatorSlide(
              context: context,
              screen: DiemDanhMenuMobile(
                cubit: widget.cubit,
              ),
            );
          }, icon: SvgPicture.asset(
            ImageAssets.icMenuCalender,
          ),)
        ],
      ),
      body: Container(
        child: Center(
          child: Text(S.current.diem_danh_ca_nhan,
            style: textNormalCustom(
              color: Colors.black54,
              fontSize: 16.0,
            ),),
        ),
      ),
    );
  }
}
