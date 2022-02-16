import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellThanhPhanThamGia extends StatefulWidget {
  final index;

  CellThanhPhanThamGia({Key? key, required this.index}) : super(key: key);

  @override
  State<CellThanhPhanThamGia> createState() => _CellThanhPhanThamGiaState();
}

class _CellThanhPhanThamGiaState extends State<CellThanhPhanThamGia> {
  @override
  Widget build(BuildContext context) {
    bool check2 = false;
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor.withOpacity(0.5)),
          color: colorNumberCellQLVB,
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
                  CustomCheckBox(
                    title: '',
                    isCheck: true,
                    onChange: (value) {
                      check2 = !check2;
                    },
                  ),
                  Text(
                    '${S.current.ten_can_bo}: ${cubit.listFakeThanhPhanThamGiaModel[widget.index].tebCanBo}',
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
                      '${S.current.ten_can_bo}:  ${cubit.listFakeThanhPhanThamGiaModel[widget.index].tenDonVi}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '${S.current.trang_thai}: ${cubit.listFakeThanhPhanThamGiaModel[widget.index].trangThai}',
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
                      '${S.current.ten_can_bo}: ${cubit.listFakeThanhPhanThamGiaModel[widget.index].tenDonVi}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    '${S.current.diem_danh}: ${cubit.listFakeThanhPhanThamGiaModel[widget.index].diemDanh}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  )
                ],
              ),
            ),
            Text(
              '${S.current.noi_dung}: ${cubit.listFakeThanhPhanThamGiaModel[widget.index].ndCongViec}',
              style: textNormalCustom(
                fontSize: 14,
                color: infoColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
