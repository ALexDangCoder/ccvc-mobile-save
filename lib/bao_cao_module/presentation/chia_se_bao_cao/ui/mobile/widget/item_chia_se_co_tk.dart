import 'package:ccvc_mobile/bao_cao_module/presentation/chia_se_bao_cao/bloc/chia_se_bao_cao_cubit.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/user_ngoai_he_thong_duoc_truy_cap_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:flutter/material.dart';

class ItemChiaSeCoTk extends StatefulWidget {
  const ItemChiaSeCoTk({
    Key? key,
    required this.model,
    required this.cubit,
  }) : super(key: key);
  final UserNgoaiHeThongDuocTruyCapModel model;
  final ChiaSeBaoCaoCubit cubit;

  @override
  State<ItemChiaSeCoTk> createState() => _ItemChiaSeCoTkState();
}

class _ItemChiaSeCoTkState extends State<ItemChiaSeCoTk> {
  bool valueCkc = false;

  @override
  void initState() {
    super.initState();
    valueCkc = widget.cubit.checkTick(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        // left: 16,
        // right: 16,
        top: 8,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        // color: colorNumberCellQLVB,
        color: colorNumberCellQLVB,
        borderRadius: BorderRadius.circular(
          6,
        ),
        border: Border.all(color: borderItemCalender),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                RowTitleFeatDescription(
                  title: S.current.ho_ten,
                  titleStyle: textNormalCustom(
                    color: color667793,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  description: model.fullName,
                  descriptionStyle: textNormalCustom(
                    color: textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceH10,
                RowTitleFeatDescription(
                  title: S.current.email,
                  titleStyle: textNormalCustom(
                    color: color667793,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  description: model.email,
                  descriptionStyle: textNormalCustom(
                    color: textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceH10,
                RowTitleFeatDescription(
                  title: S.current.chuc_vu,
                  titleStyle: textNormalCustom(
                    color: color667793,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  description: model.chucVu,
                  descriptionStyle: textNormalCustom(
                    color: textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                spaceH10,
                RowTitleFeatDescription(
                  title: S.current.don_vi,
                  titleStyle: textNormalCustom(
                    color: color667793,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  description: model.donVi,
                  descriptionStyle: textNormalCustom(
                    color: textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                checkColor: AppTheme.getInstance().backGroundColor(),
                activeColor: AppTheme.getInstance().colorField(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                value: valueCkc,
                onChanged: (value) {
                  setState(() {
                    valueCkc = !valueCkc;
                  });
                  if (valueCkc) {
                    widget.cubit.idUsersNgoaiHeTHongDuocTruyCap.add(model.id);
                  } else {
                    widget.cubit.idUsersNgoaiHeTHongDuocTruyCap
                        .remove(model.id);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
