import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_can_bo/bloc/them_can_bo_cubit.dart';
import 'package:flutter/material.dart';

class CanBoWidget extends StatefulWidget {
  final DonViModel canBoModel;
  final Function(bool) onCheckBox;
  final ThemCanBoCubit themCanBoCubit;
  const CanBoWidget({
    Key? key,
    required this.canBoModel,
    required this.onCheckBox,
    required this.themCanBoCubit,
  }) : super(key: key);

  @override
  State<CanBoWidget> createState() => _CanBoWidgetState();
}

class _CanBoWidgetState extends State<CanBoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: colorE2E8F0.withOpacity(0.1),
        border: Border.all(color: colorE2E8F0),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomCheckBox(
                title: '',
                onChange: (isCheck) {
                  widget.onCheckBox(!isCheck);
                  setState(() {});
                },
                isCheck: widget.themCanBoCubit.listSelectCanBo
                    .contains(widget.canBoModel),
              ),
              Text(
                widget.canBoModel.name,
                style: textNormalCustom(
                    color: color3D5586, fontSize: 14.0.textScale(),),
              )
            ],
          ),
           SizedBox(
            height: 11.0.textScale(space: 11),
          ),
          rowInfo(key: S.current.ten_can_bo, value: widget.canBoModel.tenCanBo),
           SizedBox(
            height: 11.0.textScale(space: 9),
          ),
          rowInfo(key: S.current.chuc_vu, value: widget.canBoModel.chucVu)
        ],
      ),
    );
  }

  Widget rowInfo({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            key,
            style: textNormal(color667793, 14.0.textScale()),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: textNormal(color3D5586, 14.0.textScale()),
          ),
        )
      ],
    );
  }
}
