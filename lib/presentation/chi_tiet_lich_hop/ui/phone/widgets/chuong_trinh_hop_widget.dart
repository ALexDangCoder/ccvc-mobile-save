import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/button/button_select_file.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/button/solid_button.dart';
import 'package:ccvc_mobile/widgets/dialog/show_dia_log_tablet.dart';
import 'package:ccvc_mobile/widgets/dropdown/drop_down_search_widget.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/selectdate/custom_selectdate.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/material.dart';

class ChuongTrinhHopWidget extends StatelessWidget {
  const ChuongTrinhHopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: ExpandOnlyWidget(
        header: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.transparent,
                child: Text(
                  S.current.chuong_trinh_hop,
                  style: textNormalCustom(color: titleColumn, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolidButton(
              onTap: () {
                showBottomSheetCustom(
                  context,
                  child: const ThemPhienHopScreen(),
                  title: S.current.them_phien_hop,
                );
              },
              text: S.current.them_phien_hop,
              urlIcon: ImageAssets.icAddButtonCalenderTablet,
            )
          ],
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SolidButton(
              onTap: () {
                showDiaLogTablet(
                  context,
                  title: S.current.them_phien_hop,
                  child: const ThemPhienHopScreen(),
                  isBottomShow: false,
                  funcBtnOk: () {
                    Navigator.pop(context);
                  },
                );
              },
              text: S.current.them_phien_hop,
              urlIcon: ImageAssets.icAddButtonCalenderTablet,
            )
          ],
        ),
      ),
    );
  }
}

class ThemPhienHopScreen extends StatefulWidget {
  const ThemPhienHopScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ThemPhienHopScreenState createState() => _ThemPhienHopScreenState();
}

class _ThemPhienHopScreenState extends State<ThemPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: DoubleButtonBottom(
            onPressed2: () {
              _keyBaseTime.currentState?.validator();
              if (_key.currentState?.validator() ?? false) {
                Navigator.pop(context);
              }
            },
            onPressed1: () {
              Navigator.pop(context);
            },
            title1: S.current.dong,
            title2: S.current.luu,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: FormGroup(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputInfoUserWidget(
                  title: S.current.them_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    hintText: S.current.nhap_ten_phien_hop,
                    onChange: (value) {},
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.thoi_gian_hop,
                  isObligatory: true,
                  child: CustomSelectDate(
                    value: DateTime.now().toString(),
                    onSelectDate: (value) {},
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  key: _keyBaseTime,
                  validator: () {},
                ),
                InputInfoUserWidget(
                  title: S.current.nguoi_chu_tri,
                  child: DropDownSearch(
                    title: S.current.nguoi_chu_tri,
                    hintText: S.current.chon_nguoi_chu_tri,
                    onChange: (value) {},
                    listSelect: ['qưe', 'qưewq'],
                  ),
                ),
                InputInfoUserWidget(
                  title: S.current.noi_dung_phien_hop,
                  isObligatory: true,
                  child: TextFieldValidator(
                    maxLine: 5,
                    onChange: (value) {},
                    validator: (value) {
                      return value?.checkNull();
                    },
                  ),
                ),
                spaceH20,
                ButtonSelectFile(
                  title: S.current.tai_lieu_dinh_kem,
                  onChange: (value) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
