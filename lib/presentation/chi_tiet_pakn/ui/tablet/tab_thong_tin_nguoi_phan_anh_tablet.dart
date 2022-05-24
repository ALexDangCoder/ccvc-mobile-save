import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/widgets/row_title_ft_description.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TabThongTinNguoiPhanAnhTablet extends StatefulWidget {
  const TabThongTinNguoiPhanAnhTablet({
    Key? key,
    required this.taskId,
    required this.id,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;
  @override
  State<TabThongTinNguoiPhanAnhTablet> createState() =>
      _TabThongTinNguoiPhanAnhTabletState();
}

class _TabThongTinNguoiPhanAnhTabletState extends State<TabThongTinNguoiPhanAnhTablet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getThongTinNguoiPhanAnh(widget.id, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {},
      child: _content(),
    );
  }

  Widget _content() {
    return StreamBuilder<ChiTietYKienNguoiDanRow>(
      stream: widget.cubit.rowDataChiTietYKienNguoiDan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (data?.thongTinPhanAnhRow ?? []).length,
              itemBuilder: (context, index) {
                return ItemRow(
                  title: (data?.thongTinPhanAnhRow ?? [])[index].title,
                  content: (data?.thongTinPhanAnhRow ?? [])[index].content,
                );
              },
            ),
          );
        } else {
          return const NodataWidget();
        }
      },
    );
  }
}
