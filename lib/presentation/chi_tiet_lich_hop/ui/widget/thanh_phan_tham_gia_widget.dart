import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/thanh_phan_tham_gia_widget.dart';
import 'package:flutter/cupertino.dart';

import 'icon_with_title_widget.dart';

class ThemThanhPhanThamGiaWidget extends StatefulWidget {
  const ThemThanhPhanThamGiaWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemThanhPhanThamGiaWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<ThemThanhPhanThamGiaWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ThanhPhanThamGiaWidget(
              isPhuongThucNhan: true,
              onChange: (value) {},
              phuongThucNhan: (value) {},
            ),
            Text(
              S.current.don_vi_phoi_hop_khac,
              style: titleAppbar(
                fontSize: 14.0,
                color: dateColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IconWithTiltleWidget(
              icon: ImageAssets.ic_file,
              title: S.current.them_thanh_phan_tham_gia,
              onPress: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              S.current.khach_moi,
              style: titleAppbar(
                fontSize: 14.0,
                color: dateColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            IconWithTiltleWidget(
              icon: ImageAssets.ic_file,
              title: S.current.them_thong_tin_khach_moi,
              onPress: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InputInfoUserWidget(
                    isObligatory: true,
                    title: S.current.tong_so_luong_khach,
                    child: const SizedBox(),
                  ),
                ),
                Expanded(
                  child: TextFieldValidator(
                    hintText: S.current.nhap_so_luong,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.luu,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {},
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}