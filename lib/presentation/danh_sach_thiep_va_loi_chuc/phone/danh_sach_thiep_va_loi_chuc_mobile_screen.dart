import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_thiep_chuc_mung_screen/mobile/chi_tiet_thiep_chuc_mung_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/widgets/loi_chuc_cell.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:flutter/material.dart';

class DanhSachThiepVaLoiChucMobileScreen extends StatefulWidget {
  const DanhSachThiepVaLoiChucMobileScreen({Key? key}) : super(key: key);

  @override
  _DanhSachThiepVaLoiChucMobileScreenState createState() =>
      _DanhSachThiepVaLoiChucMobileScreenState();
}

class _DanhSachThiepVaLoiChucMobileScreenState
    extends State<DanhSachThiepVaLoiChucMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.danh_sach_thiep_va_loi_chuc),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChiTietThiepChucMobileScreen()));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: borderColor.withOpacity(0.5)))),
              child: const LoiChucCell()),
        ),
      ),
    );
  }
}
