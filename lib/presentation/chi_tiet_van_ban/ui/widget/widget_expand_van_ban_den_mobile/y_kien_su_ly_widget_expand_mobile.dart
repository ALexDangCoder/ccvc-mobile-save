import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/danh_sach_y_kien_xu_ly_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/widget/expand_only_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/y_kien_su_ly_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YKienXuLyExpandWidgetMobile extends StatefulWidget {
  final DetailDocumentCubit cubit;
  final String processId;

  const YKienXuLyExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<YKienXuLyExpandWidgetMobile> createState() =>
      _YKienXuLyExpandWidgetMobileState();
}

class _YKienXuLyExpandWidgetMobileState
    extends State<YKienXuLyExpandWidgetMobile>  with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    widget.cubit.getDanhSachYKienXuLy(widget.processId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getDanhSachYKienXuLy(widget.processId);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async{
          await widget.cubit.getDanhSachYKienXuLy(widget.processId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: StreamBuilder<List<DanhSachYKienXuLy>>(
                  stream: widget.cubit.danhSachYKienXuLyStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    if (data.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return YKienSuLyWidget(
                            object: data[index],
                          );
                        },
                      );
                    } else {
                      return const   Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: NodataWidget(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
