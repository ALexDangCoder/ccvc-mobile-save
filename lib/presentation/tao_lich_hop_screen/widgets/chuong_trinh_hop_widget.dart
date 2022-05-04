import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/bloc/tao_lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
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
import 'package:flutter_svg/flutter_svg.dart';

class ChuongTrinhHopWidget extends StatelessWidget {
  final TaoLichHopCubit cubit;

  const ChuongTrinhHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.chuong_trinh_hop,
                style: textNormalCustom(
                  color: titleColumn,
                  fontSize: 16.0.textScale(),
                ),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 0.0.textScale(space: 10),
          ),
          SolidButton(
            onTap: () {
              showDialog(context);
            },
            text: S.current.them_phien_hop,
            urlIcon: ImageAssets.icAddButtonCalenderTablet,
          )
        ],
      ),
    );
  }

  void showDialog(BuildContext context) {
    if (isMobile()) {
      showBottomSheetCustom(
        context,
        child: ThemPhienHopScreen(
          cubit: cubit,
        ),
        title: S.current.them_phien_hop,
      );
    } else {
      showDiaLogTablet(
        context,
        title: S.current.them_phien_hop,
        isBottomShow: false,
        child: ThemPhienHopScreen(
          cubit: cubit,
        ),
        funcBtnOk: () {},
      );
    }
  }
}

class ThemPhienHopScreen extends StatefulWidget {
  final TaoLichHopCubit cubit;

  const ThemPhienHopScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  _ThemPhienHopScreenState createState() => _ThemPhienHopScreenState();
}

class _ThemPhienHopScreenState extends State<ThemPhienHopScreen> {
  final _key = GlobalKey<FormGroupState>();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();

  @override
  void initState() {
    super.initState();
    widget.cubit.getChuongTrinhHop('7b4f68c6-f835-4bea-b6f2-06250412ae70');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: FollowKeyBoardWidget(
        bottomWidget: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile() ? 24 : 0),
          child: DoubleButtonBottom(
            isTablet: isMobile() == false,
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
                    value: DateTime.now(),
                    onSelectDate: (value) {},
                    paddings: 12,
                    leadingIcon: SvgPicture.asset(
                      isMobile()
                          ? ImageAssets.icCalenders
                          : ImageAssets.icCanlendarTablet,
                    ),
                  ),
                ),
                spaceH20,
                BaseChooseTimerWidget(
                  key: _keyBaseTime,
                  validator: () {},
                ),
                InputInfoUserWidget(
                  title: S.current.nguoi_chu_tri,
                  child: StreamBuilder<ChuongTrinhHopModel>(
                    stream: widget.cubit.chuongTrinhHopStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? ChuongTrinhHopModel.empty();
                      final dataString = data.listCanBo
                              ?.map((e) => e.tenCanBo ?? '')
                              .toList() ??
                          [];

                      return DropDownSearch(
                        title: S.current.nguoi_chu_tri,
                        hintText: S.current.chon_nguoi_chu_tri,
                        onChange: (value) {},
                        listSelect: dataString,
                      );
                    },
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
                  spacingFile: 16,
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
