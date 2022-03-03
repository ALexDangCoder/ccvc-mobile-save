import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';

import 'expand_only_nhiem_vu.dart';

class VanBanLienQuanWidget extends StatelessWidget {
  final VanBanLienQuanModel dataModel;
  final ChiTietNVCubit cubit;

  const VanBanLienQuanWidget(
      {Key? key, required this.dataModel, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.van_ban_lien_quan,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.textScale(space: 4),
          vertical: 16.0.textScale(space: 4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.van_ban_giao_nhiem_vu,
              style: textNormalCustom(
                color: radioFocusColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0.textScale(),
              ),
            ),
            Column(
              children: dataModel.vanBanGiaoNV
                  .map((e) => WidgetInExpand(
                        row: e.dataRowVBLQ(),
                        cubit: cubit,
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 14.0.textScale(),
            ),
            Text(
              S.current.van_ban_khac,
              style: textNormalCustom(
                color: radioFocusColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.0.textScale(),
              ),
            ),
            Column(
              children: dataModel.vanBanKhac
                  .map(
                    (e) => WidgetInExpand(
                      row: e.dataRowVBLQ(),
                      cubit: cubit,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
