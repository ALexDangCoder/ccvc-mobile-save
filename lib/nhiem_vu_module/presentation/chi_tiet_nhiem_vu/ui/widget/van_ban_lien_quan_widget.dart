import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/widget_in_expand.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'expand_only_nhiem_vu.dart';

class VanBanLienQuanWidget extends StatefulWidget {
  final ChiTietNVCubit cubit;

  const VanBanLienQuanWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<VanBanLienQuanWidget> createState() => _VanBanLienQuanWidgetState();
}

class _VanBanLienQuanWidgetState extends State<VanBanLienQuanWidget> {
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
            StreamBuilder<List<VanBanLienQuanNhiemVuModel>>(
              stream: widget.cubit.vanBanGiaoNhiemvuStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return Column(
                    children: data
                        .map(
                          (e) => WidgetInExpand(
                            row: e.dataRowVBLQ(),
                            cubit: widget.cubit,
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: NodataWidget(),
                  );
                }
              },
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
            StreamBuilder<List<VanBanLienQuanNhiemVuModel>>(
              stream: widget.cubit.vanBanKhacNhiemvuStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return Column(
                    children: data
                        .map(
                          (e) => WidgetInExpand(
                            row: e.dataRowVBLQ(),
                            cubit: widget.cubit,
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: NodataWidget(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
