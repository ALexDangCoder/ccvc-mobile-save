import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/phat_bieu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
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
    return screenDevice(
      mobileScreen: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: borderItemCalender),
            color: borderItemCalender.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${S.current.phien_hop}:',
                      style: textNormalCustom(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.ten_can_bo}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.noi_dung}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Expanded(
                      child: Text(
                        '${S.current.thoi_gian}:',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${widget.infoModel.phienHop}',
                        style: textNormalCustom(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.nguoiPhatBieu}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.ndPhatBieu}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Expanded(
                        child: Text(
                          '${widget.infoModel.tthoiGian}',
                          style: textNormalCustom(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.cubit.typeStatus.value !=
                  widget.cubit.danhSachphatBieu)
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
                const Text('')
            ],
          ),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: (widget.cubit.typeStatus.value !=
                        widget.cubit.danhSachphatBieu)
                    ? CustomCheckBox(
                        title: '',
                        isCheck: widget.cubit.check,
                        onChange: (isCheck) {
                          widget.cubit.check = !widget.cubit.check;
                          // widget.cubit.checkAllSelect();
                          setState(() {});
                        },
                      )
                    : Text(
                        '${widget.index}.',
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                        ),
                      ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        '${S.current.phien_hop}: ${widget.infoModel.phienHop}',
                        style: textNormalCustom(
                          fontSize: 16,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                '${S.current.nguoi_phat_bieu}:',
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            Text(
                              '${S.current.noi_dung_phat_bieu}:',
                              style: textNormalCustom(
                                fontSize: 14,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                '${widget.infoModel.nguoiPhatBieu}',
                                style: textNormalCustom(
                                  fontSize: 14,
                                  color: infoColor,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.infoModel.ndPhatBieu}',
                              style: textNormalCustom(
                                fontSize: 14,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 17),
                  child: Text(
                    '${widget.infoModel.tthoiGian}',
                    style: textNormalCustom(
                      fontSize: 14,
                      color: textBodyTime,
                    ),
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
