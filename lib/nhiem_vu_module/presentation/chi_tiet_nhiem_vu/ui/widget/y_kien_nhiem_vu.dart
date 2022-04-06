import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/y_kien_su_ly_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/bloc/chi_tiet_nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import 'expand_only_nhiem_vu.dart';

class YKienNhiemVuWidget extends StatelessWidget {
  final ChiTietNVCubit cubit;

  const YKienNhiemVuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyNhiemVu(
      name: S.current.y_kien_xu_ly,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.textScale(space: 4),
          ),
          child: StreamBuilder<List<YKienSuLyNhiemVuModel>>(
              stream: cubit.yKienXuLyNhiemVuStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return YKienSuLyNhiemVuWidget(
                        object: data[index],
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: NodataWidget(),
                  );
                }
              })),
    );
  }
}
