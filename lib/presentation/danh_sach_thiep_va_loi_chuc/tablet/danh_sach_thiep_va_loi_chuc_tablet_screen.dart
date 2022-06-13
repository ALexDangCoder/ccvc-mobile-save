import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/mobile/chi_tiet_thiep_chuc_mung_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/widgets/loi_chuc_cell.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class DanhSachThiepVaLoiChucTabletScreen extends StatefulWidget {
  const DanhSachThiepVaLoiChucTabletScreen({Key? key}) : super(key: key);

  @override
  _DanhSachThiepVaLoiChucMobileScreenState createState() =>
      _DanhSachThiepVaLoiChucMobileScreenState();
}

class _DanhSachThiepVaLoiChucMobileScreenState
    extends State<DanhSachThiepVaLoiChucTabletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_thiep_va_loi_chuc),
      backgroundColor: bgTabletColor,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChiTietThiepChucMobileScreen()));
          },
          child: Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: Colors.white,
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                        color: shadowContainerColor.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 10)
                  ]),
              child: const LoiChucCell()),
        ),
      ),
    );
  }
}
