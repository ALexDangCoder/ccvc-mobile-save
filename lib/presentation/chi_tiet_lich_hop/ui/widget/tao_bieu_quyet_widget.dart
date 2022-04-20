import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/chon_ngay_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/radio_button.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/timer/base_timer_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cac_lua_chon_don_vi_widget.dart';

class TaoBieuQuyetWidget extends StatefulWidget {
  final String id;

  const TaoBieuQuyetWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TaoBieuQuyetWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TaoBieuQuyetWidget> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();
  final _keyBaseTime = GlobalKey<BaseChooseTimerWidgetState>();
  final keyGroup = GlobalKey<FormGroupState>();

  @override
  Widget build(BuildContext context) {
    return FormGroup(
      key: keyGroup,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: FollowKeyBoardWidget(
          bottomWidget: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DoubleButtonBottom(
              title1: S.current.dong,
              title2: S.current.luu,
              onPressed1: () {
                Navigator.pop(context);
              },
              onPressed2: () {
                cubit.themBieuQuyetHop(
                  id: widget.id,
                  tenBieuQuyet: noiDungController.text,
                );
              },
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 24),
                  child: Text(
                    S.current.loai_bieu_quyet,
                    style: tokenDetailAmount(
                      color: dateColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                StreamBuilder<int>(
                  stream: cubit.checkRadioStream,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioButtonCheck(
                          isCheck: snapshot.data == 1 ? true : false,
                          allowUnSelect: true,
                          title: S.current.bo_khieu_kin,
                          onSelectItem: (item) {
                            cubit.checkRadioButton(1);
                          },
                          canSelect: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        RadioButtonCheck(
                          isCheck: snapshot.data == 2 ? true : false,
                          allowUnSelect: true,
                          title: S.current.bo_phieu_cong_khai,
                          onSelectItem: (item) {
                            cubit.checkRadioButton(2);
                          },
                          canSelect: true,
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: PickDateWidget(
                    title: S.current.ngay_bieu_quyet,
                    minimumDate: DateTime.now(),
                    onChange: (DateTime value) {
                      cubit.getDate(value.toString());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    child: BaseChooseTimerWidget(
                      onChange: (start, end) {
                        cubit.getTimeHour(
                          startT: start,
                          endT: end,
                        );
                      },
                      key: _keyBaseTime,
                      validator: () {},
                    ),
                  ),
                ),
                Flexible(
                  child: BlockTextView(
                    formKey: formKeyNoiDung,
                    contentController: noiDungController,
                    title: S.current.ten_bieu_quyet,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InputInfoUserWidget(
                    isObligatory: true,
                    title: S.current.cac_lua_chon_bieu_quyet,
                    child:
                        CacLuaChonDonViWidget(detailMeetCalenderCubit: cubit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
