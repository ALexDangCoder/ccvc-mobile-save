
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/widgets/explan_group/expanded_only_widget.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/y_kien_xu_ly_yknd_model.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/presentation/chi_tiet_yknd/ui/widget/y_kien_su_ly_pakn_widget.dart';
import 'package:ccvc_mobile/y_kien_nguoi_dan_module/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class YKienXuLyPAKNWidgetExpand extends StatelessWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const YKienXuLyPAKNWidgetExpand({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      name: S.current.y_kien_xu_ly,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: StreamBuilder<List<YKienXuLyYKNDModel>>(
            stream: cubit.yKienXuLyYkndStream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? [];
              if (data.isNotEmpty) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return YKienXuLyPAKNWidget(
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
            }),
      ),
    );
  }
}
