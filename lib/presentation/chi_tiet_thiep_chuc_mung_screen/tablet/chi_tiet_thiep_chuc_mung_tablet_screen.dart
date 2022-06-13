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
      backgroundColor: Colors.white,
      appBar: AppBarDefaultBack(S.current.thiep_danh_toi_ban),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                data: widget.data,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ButtonBottom(
            text: S.current.dong,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
