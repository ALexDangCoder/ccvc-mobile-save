import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/phat_bieu_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_item_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/ket_luan_hop_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CellPhatBieu extends StatefulWidget {
  final Function(bool)? onChangeCheckBox;
  final PhatBieuModel infoModel;
  final DetailMeetCalenderCubit cubit;
  final int index;
  final bool isthePhatBieu;

  const CellPhatBieu({
    Key? key,
    required this.infoModel,
    required this.cubit,
    required this.index,
    this.isthePhatBieu = true,
    this.onChangeCheckBox,
  }) : super(key: key);

  @override
  State<CellPhatBieu> createState() => _CellPhatBieuState();
}

class _CellPhatBieuState extends State<CellPhatBieu> {
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(top: 10, bottom: 16, left: 16),
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
            widgetRow(
              name: S.current.phien_hop,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.infoModel.phienHop}',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  StreamBuilder<int>(
                    stream: widget.cubit.typeStatus,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? 0;
                      if (data != StatePhatBieu.danh_Sach_phat_bieu &&
                          widget.isthePhatBieu == true) {
                        return CustomCheckBox(
                          isCheck: widget.cubit.selectPhatBieu
                              .contains(widget.infoModel.id),
                          onChange: (isCheck) {
                            check = !check;
                            setState(() {});
                            widget.onChangeCheckBox?.call(isCheck);
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
            ),
            widgetRow(
              name: S.current.nguoi_phat_bieu,
              child: Text(
                '${widget.infoModel.nguoiPhatBieu}',
                style: textNormalCustom(
                  fontSize: 14,
                  color: infoColor,
                ),
              ),
            ),
            widgetRow(
              name: S.current.nd_phat_bieu,
              child: Text(
                widget.infoModel.ndPhatBieu ?? '',
                style: textNormalCustom(
                  fontSize: 14,
                  color: infoColor,
                ),
              ),
            ),
            widgetRow(
              name: S.current.thoi_gian,
              child: Text(
                '${widget.infoModel.tthoiGian} ${S.current.phut_lower_case}',
                style: textNormalCustom(
                  fontSize: 14,
                  color: infoColor,
                ),
              ),
            ),
          ],
        ),
      ),
      tabletScreen: Padding(
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: StreamBuilder<int>(
                      stream: widget.cubit.typeStatus,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? 0;
                        if (data != StatePhatBieu.danh_Sach_phat_bieu) {
                          return CustomCheckBox(
                            isCheck: widget.cubit.selectPhatBieu
                                .contains(widget.infoModel.id),
                            onChange: (isCheck) {
                              check = !check;
                              widget.onChangeCheckBox?.call(isCheck);
                              setState(() {});
                            },
                          );
                        }
                        return Text(
                          '${widget.index}.',
                          style: textNormalCustom(
                            fontSize: 16,
                            color: color667793,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${S.current.phien_hop}: ${widget.infoModel.phienHop}',
                      style: textNormalCustom(
                        fontSize: 16,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.infoModel.tthoiGian}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: color667793,
                    ),
                  ),
                ],
              ),
              widgetRow(
                name: S.current.nguoi_phat_bieu,
                child: Text(
                  '${widget.infoModel.nguoiPhatBieu}:',
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                  ),
                ),
              ),
              widgetRow(
                name: S.current.noi_dung_phat_bieu,
                child: Text(
                  '${widget.infoModel.ndPhatBieu}:',
                  style: textNormalCustom(
                    fontSize: 14,
                    color: color667793,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
