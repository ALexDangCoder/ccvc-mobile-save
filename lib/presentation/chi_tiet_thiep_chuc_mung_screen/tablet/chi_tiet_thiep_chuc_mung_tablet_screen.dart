import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/widgets/thiep_chuc_mung_sinh_nhat_widget.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_bottom.dart';
import 'package:flutter/material.dart';

class ChiTietThiepChucTabletScreen extends StatefulWidget {
  const ChiTietThiepChucTabletScreen({
    Key? key,
    required this.data,
  }) : super(key: key);
  final BirthdayModel data;

  @override
  _ChiTietThiepChucMobileScreenState createState() =>
      _ChiTietThiepChucMobileScreenState();
}

class _ChiTietThiepChucMobileScreenState
    extends State<ChiTietThiepChucTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: AppBarDefaultBack(S.current.thiep_danh_toi_ban),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all( 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: shadowContainerColor.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  )
                ],
              ),
              child: ThiepChucMungSinhNhatWidget(
                isTablet: true,
                data: widget.data,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Center(
          child: SizedBox (
            width: 170,
            child: ButtonBottom(
              text: S.current.dong,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
