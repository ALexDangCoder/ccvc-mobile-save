import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/widget/chi_tiet_header.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TabThongTinNguoiPhanAnh extends StatefulWidget {
  const TabThongTinNguoiPhanAnh({
    Key? key,
    required this.taskId,
    required this.id,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;

  @override
  State<TabThongTinNguoiPhanAnh> createState() =>
      _TabThongTinNguoiPhanAnhState();
}

class _TabThongTinNguoiPhanAnhState extends State<TabThongTinNguoiPhanAnh>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.cubit.getThongTinNguoiPhanAnh(widget.id, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {
        widget.cubit.getThongTinNguoiPhanAnh(widget.id, widget.taskId);
      },
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

  @override
  bool get wantKeepAlive => true;
}
