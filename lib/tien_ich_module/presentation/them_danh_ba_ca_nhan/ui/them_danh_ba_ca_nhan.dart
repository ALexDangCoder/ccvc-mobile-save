import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/bloc_danh_ba_dien_tu/bloc_danh_ba_dien_tu_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/chon_anh.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/them_danh_ba_ca_nhan/widget/select_date.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/button/double_button_bottom.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/folow_key_broard/follow_key_broad.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/form_group/form_group.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/radio_button/custom_radio_button.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/textformfield/text_form_field_them_moi.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDanhBaCaNhan extends StatefulWidget {
  const ThemDanhBaCaNhan({Key? key}) : super(key: key);

  @override
  _ThemDanhBaCaNhanState createState() => _ThemDanhBaCaNhanState();
}

class _ThemDanhBaCaNhanState extends State<ThemDanhBaCaNhan> {
  final keyGroup = GlobalKey<FormGroupState>();
  DanhBaDienTuCubit cubit = DanhBaDienTuCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FollowKeyBoardWidget(
        child: SingleChildScrollView(
          child: FormGroup(
            key: keyGroup,
            child: Column(
              children: [
                spaceH24,
                const AvatarDanhBa(),
                TextFieldStyle(
                  urlIcon: ImageAssets.icEditDb,
                  hintText: S.current.ho_ten_cb,
                  onChange: (value) {
                    cubit.hoTen = value;
                  },
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return S.current.khong_duoc_de_trong;
                    }
                    return null;
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icLocation,
                  hintText: S.current.dia_diem,
                  onChange: (value) {
                    cubit.diaChi = value;
                  },
                ),
                SelectDate(
                  leadingIcon: SvgPicture.asset(ImageAssets.icCalenderDb),
                  value: '',
                  onSelectDate: (dateTime) {
                    cubit.ngaySinh = dateTime;
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icMessage,
                  hintText: S.current.email,
                  onChange: (value) {
                    cubit.email = value;
                  },
                  validator: (value) {
                    return (value ?? '').checkEmail();
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icCmt,
                  hintText: S.current.so_cmt,
                  onChange: (value) {
                    cubit.cmtnd = value;
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icCalling,
                  hintText: S.current.so_dien_thoai,
                  onChange: (value) {
                    cubit.phoneDiDong = value;
                  },
                  validator: (value) {
                    return (value ?? '').checkSdt();
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icPhoneCp,
                  hintText: S.current.sdt_co_quan,
                  onChange: (value) {
                    cubit.phoneCoQuan = value;
                  },
                ),
                TextFieldStyle(
                  urlIcon: ImageAssets.icCallDb,
                  hintText: S.current.sdt_nha_rieng,
                  onChange: (value) {
                    cubit.phoneNhaRieng = value;
                  },
                ),
                spaceH16,
                CustomRadioButton(
                  title: S.current.gioi_tinh,
                  onchange: (value) {
                    if (value == S.current.Nam) {
                      cubit.gioiTinh = true;
                    }
                    return cubit.gioiTinh = false;
                  },
                ),
                spaceH16,
                DoubleButtonBottom(
                  onPressed2: () {
                    if (keyGroup.currentState!.validator()) {
                      cubit.callApi();
                    } else {}
                  },
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  title2: S.current.luu_danh_ba,
                  title1: S.current.huy,
                ),
                spaceH24
              ],
            ),
          ),
        ),
      ),
    );
  }
}
