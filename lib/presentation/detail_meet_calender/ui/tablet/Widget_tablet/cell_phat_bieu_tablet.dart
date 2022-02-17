import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellPhatBieu extends StatefulWidget {
  final PhatBieuModel infoModel;
  final DetailMeetCalenderCubit cubit;
  final int index;

  const CellPhatBieu({
    Key? key,
    required this.infoModel,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  @override
  State<CellPhatBieu> createState() => _CellPhatBieuState();
}

class _CellPhatBieuState extends State<CellPhatBieu> {
  @override
  Widget build(BuildContext context) {
    // final isChecked = widget.cubit.checkIsSelected(widget.infoModel.id ?? '');
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: borderItemCalender),
          color: borderItemCalender.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  if (widget.cubit.typeStatus.value != S.current.danh_sach_phat_bieu)
                    CustomCheckBox(
                      title: '',
                      isCheck: widget.cubit.check,
                      onChange: (isCheck) {
                        widget.cubit.check = !widget.cubit.check;
                        // widget.cubit.checkAllSelect();
                        setState(() {});
                      },
                    )
                  else
                    Text(
                      '${widget.index}. ',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                  Text(
                    '${S.current.phien_hop}: ${widget.infoModel.phienHop}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '${widget.infoModel.tthoiGian}',
                    style: textNormalCustom(
                      fontSize: 16,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${S.current.ten_can_bo}:  ${widget.infoModel.nguoiPhatBieu}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${S.current.ten_can_bo}: ${widget.infoModel.ndPhatBieu}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
