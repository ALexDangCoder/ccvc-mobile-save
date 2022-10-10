import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

class CapNhatThongTinKhachHangTablet extends StatefulWidget {
  const CapNhatThongTinKhachHangTablet({Key? key}) : super(key: key);

  @override
  _CapNhatThongTinKhachHangTabletState createState() =>
      _CapNhatThongTinKhachHangTabletState();
}

class _CapNhatThongTinKhachHangTabletState
    extends State<CapNhatThongTinKhachHangTablet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.cap_nhat_nhan_dien_cmnd_cccd),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              S.current.anh_mat_truoc,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              S.current.anh_mat_sau,
              style: textNormalCustom(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ButtonCustomBottom(
        isColorBlue: false,
        title: S.current.tiep_theo,
        onPressed: () {},
      ),
    );
  }
}
