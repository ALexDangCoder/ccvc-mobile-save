import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/widgets/thiep_back_ground_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class ChiTietThiepChucMobileScreen extends StatefulWidget {
  const ChiTietThiepChucMobileScreen({Key? key}) : super(key: key);

  @override
  _ChiTietThiepChucMobileScreenState createState() =>
      _ChiTietThiepChucMobileScreenState();
}

class _ChiTietThiepChucMobileScreenState
    extends State<ChiTietThiepChucMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefaultBack(S.current.thiep_danh_toi_ban),
      body: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              ThiepBackgroundWidget(),
              Text('21321')
            ],
          )),
    );
  }
}

// Path path = Path();
// path.moveTo(0, size.height / 2);
// path.quadraticBezierTo(
// size.width / 2, size.height - 130, size.width, size.height / 2);
