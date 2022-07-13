import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/env/model/app_constants.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/bloc/chi_tiet_pakn_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/widgets/list_row_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabKetQuaXuLyTablet extends StatefulWidget {
  const TabKetQuaXuLyTablet({
    Key? key,
    required this.id,
    required this.taskId,
    required this.cubit,
  }) : super(key: key);
  final ChiTietPaknCubit cubit;
  final String id;
  final String taskId;

  @override
  State<TabKetQuaXuLyTablet> createState() => _TabKetQuaXuLyTabletState();
}

class _TabKetQuaXuLyTabletState extends State<TabKetQuaXuLyTablet>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.cubit.getKetQuaXuLy(widget.id, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      stream: widget.cubit.stateStream,
      error: AppException('', S.current.something_went_wrong),
      retry: () {
        widget.cubit.getKetQuaXuLy(widget.id, widget.taskId);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 30.0),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return StreamBuilder<List<List<ListRowYKND>>>(
      stream: widget.cubit.ketQuaXuLyRowData,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        if (data.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, indexItem) {
              return Container(
                padding: const EdgeInsets.only(left: 16, top: 16),
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: bgDropDown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: bgDropDown),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data[indexItem].length,
                  itemBuilder: (context, index) {
                    return ListItemRow(
                      title: data[indexItem][index].title,
                      content: data[indexItem][index].content,
                      urlFile: data[indexItem][index].urlDownload ?? [],
                      nameFile: data[indexItem][index].nameFile ?? [],
                      domainDownload:
                          '${Get.find<AppConstants>().baseUrlPAKN}/',
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: NodataWidget(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
