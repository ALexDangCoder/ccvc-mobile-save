import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/edit_hdsd/ui/widget/block_textview.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/radio/cuctom_radio_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaoBieuQuyetWidget extends StatefulWidget {
  const TaoBieuQuyetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TaoBieuQuyetWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TaoBieuQuyetWidget> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final cubit = DetailMeetCalendarInherited.of(context).cubit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 18),
          child: Text(
            S.current.loai_bieu_quyet,
            style: tokenDetailAmount(
              color: dateColor,
              fontSize: 14.0,
            ),
          ),
        ),
        StreamBuilder<int>(
          initialData: 1,
          stream: cubit.checkRadioStream,
          builder: (context, snapshot) {
            return Column(
              children: [
                CustomRadioButtonCheck(
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
                CustomRadioButtonCheck(
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
        const SizedBox(
          height: 24,
        ),
        BlockTextView(
          isObligatory: true,
          formKey: formKeyNoiDung,
          contentController: noiDungController,
          title: S.current.ten_bieu_quyet,
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
    );
  }
}
