import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/bloc/thiep_chuc_mung_cubit.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/phone/danh_sach_thiep_va_loi_chuc_mobile_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/tablet/danh_sach_thiep_va_loi_chuc_tablet_screen.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/material.dart';

class DanhSachThiepVaLoiChucScreen extends StatefulWidget {
  const DanhSachThiepVaLoiChucScreen({Key? key}) : super(key: key);

  @override
  _DanhSachThiepVaLoiChucScreenState createState() =>
      _DanhSachThiepVaLoiChucScreenState();
}

class _DanhSachThiepVaLoiChucScreenState
    extends State<DanhSachThiepVaLoiChucScreen> {
  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: DanhSachThiepVaLoiChucMobileScreen(
        cubit: ThiepChucMungCuBit(),
      ),
      tabletScreen: DanhSachThiepVaLoiChucTabletScreen(
        cubit: ThiepChucMungCuBit(),
      ),
    );
  }
}
