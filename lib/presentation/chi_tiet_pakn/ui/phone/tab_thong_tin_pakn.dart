import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class TabThongTinPAKN extends StatefulWidget {
  const TabThongTinPAKN({
    Key? key,
    required this.taskId,
    required this.id,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;

  @override
  State<TabThongTinPAKN> createState() => _TabThongTinPAKNState();
}

class _TabThongTinPAKNState extends State<TabThongTinPAKN> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.getThongTinPAKN(widget.id, widget.taskId);
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
    return StreamBuilder<List<ListRowYKND>>(
      stream: widget.cubit.headerRowData,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        if (data.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListItemRow(
                  title: data[index].title,
                  content: data[index].content,
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
