import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/input_infor_user/input_info_user_widget.dart';
import 'package:ccvc_mobile/widgets/textformfield/block_textview.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
import 'package:flutter/cupertino.dart';

class DangKyPhatBieuWidget extends StatefulWidget {
  const DangKyPhatBieuWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DangKyPhatBieuWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<DangKyPhatBieuWidget> {
  DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
  GlobalKey<FormState> formKeyNoiDung = GlobalKey<FormState>();
  TextEditingController noiDungController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            S.current.phien_hop,
            style: tokenDetailAmount(
              color: dateColor,
              fontSize: 14.0,
            ),
          ),
        ),
        CustomDropDown(
          items: cubit.dataDropdown,
          onSelectItem: (value) {},
        ),
        Column(
          children: [
            InputInfoUserWidget(
              isObligatory: true,
              title: S.current.thoi_gian_phat_bieu,
              child: const SizedBox(),
            ),
            Row(
              children: [
                const Expanded(
                  child: TextFieldValidator(),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: InputInfoUserWidget(
                    title: S.current.phut,
                    child: const SizedBox(),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Flexible(
          child: BlockTextView(
            formKey: formKeyNoiDung,
            contentController: noiDungController,
            title: S.current.noi_dung_phat_bieu,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.xac_nhan,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
