import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/cap_nhat_thong_tin_khach_hang/ui/widget/widget_pick_image_default.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/button/button_custom_bottom.dart';
import 'package:flutter/material.dart';

class CapNhatThongTinKhachHangMobile extends StatefulWidget {
  const CapNhatThongTinKhachHangMobile({Key? key}) : super(key: key);

  @override
  _CapNhatThongTinKhachHangMobileState createState() =>
      _CapNhatThongTinKhachHangMobileState();
}

class _CapNhatThongTinKhachHangMobileState
    extends State<CapNhatThongTinKhachHangMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(S.current.cap_nhat_nhan_dien_cmnd_cccd),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.anh_mat_truoc,
                style: textNormalCustom(
                  color: color3D5586,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceH16,
              PickImageDefault(
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  S.current.anh_mat_sau,
                  style: textNormalCustom(
                    color: color3D5586,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              PickImageDefault(
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, right: 16.0, left: 16.0),
        child: ButtonCustomBottom(
          isColorBlue: false,
          title: S.current.tiep_theo,
          onPressed: () {},
        ),
      ),
    );
  }
}
