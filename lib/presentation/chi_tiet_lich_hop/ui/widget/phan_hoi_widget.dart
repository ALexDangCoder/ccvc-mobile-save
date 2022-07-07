import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/text_field_widget.dart';
import 'package:ccvc_mobile/widgets/button/double_button_bottom.dart';
import 'package:ccvc_mobile/widgets/textformfield/follow_key_board_widget.dart';
import 'package:flutter/material.dart';

class PhanHoiWidget extends StatefulWidget {
  final String id;
  final DetailMeetCalenderCubit cubit;

  const PhanHoiWidget({Key? key, required this.cubit, required this.id})
      : super(key: key);

  @override
  _PhanHoiWidgetState createState() => _PhanHoiWidgetState();
}

class _PhanHoiWidgetState extends State<PhanHoiWidget> {
  final TextEditingController yKien = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FollowKeyBoardWidget(
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: DoubleButtonBottom(
          title1: S.current.dong,
          title2: S.current.them,
          onPressed1: () {
            Navigator.pop(context);
          },
          onPressed2: () async {
            Navigator.pop(context);
            await widget.cubit.themYKien(
              yKien: yKien.text,
              idLichHop: widget.id,
              phienHopId: widget.cubit.getPhienHopId,
              scheduleOpinionId: '',
            );
            await widget.cubit.getDanhSachYKien(
              widget.id,
              widget.cubit.getPhienHopId,
            );
          },
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemTextFieldWidget(
            hint: '',
            title: S.current.y_kien_cuop_hop,
            controller: yKien,
            maxLine: 6,
            validator: (String? value) {},
            onChange: (String value) {},
          ),
          HeightSp(24),
        ],
      ),
    );
  }

  Widget HeightSp(double height) => SizedBox(
        height: height,
      );
}