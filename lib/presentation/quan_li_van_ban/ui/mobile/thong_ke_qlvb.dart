import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThongKeQlVB extends StatefulWidget {
  final QLVBCCubit qlvbCubit;

  const ThongKeQlVB({Key? key, required this.qlvbCubit}) : super(key: key);

  @override
  _ThongKeQlVBState createState() => _ThongKeQlVBState();
}

class _ThongKeQlVBState extends State<ThongKeQlVB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          S.current.bao_cao_thong_ke,
          style: TextStyle(color: Colors.red),

        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [

          GestureDetector(
            onTap: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: VanBanMenuMobile(
                  cubit: widget.qlvbCubit,
                ),
              );
            },
            child: SvgPicture.asset(ImageAssets.icMenuCalender),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
        centerTitle: true,
      ),
    );
    // return Center(
    //   child: Text("thong ke"),
    // );
  }
}
