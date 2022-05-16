import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/button/button_custom_bottom.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/xem_luong_xu_ly_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanExpandWidgetMobile extends StatefulWidget {
  final DetailDocumentCubit cubit;
  final String processId;

  const ThongTinGuiNhanExpandWidgetMobile({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<ThongTinGuiNhanExpandWidgetMobile> createState() =>
      _ThongTinGuiNhanExpandWidgetMobileState();
}

class _ThongTinGuiNhanExpandWidgetMobileState
    extends State<ThongTinGuiNhanExpandWidgetMobile>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getThongTinGuiNhan(widget.processId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {
          widget.cubit.getThongTinGuiNhan(widget.processId);
        },
        error: AppException('', S.current.something_went_wrong),
        stream: widget.cubit.stateStream,
        child: RefreshIndicator(
          onRefresh: () async {
            await widget.cubit.getThongTinGuiNhan(widget.processId);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                child: StreamBuilder<List<ThongTinGuiNhanModel>>(
                  stream: widget.cubit.thongTinGuiNhanStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? [];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 24.0,
                            ),
                            child: ButtonCustomBottom(
                              isColorBlue: false,
                              title: S.current.xem_luong_xu_ly,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => XemLuongXuLyScreen(
                                      id: widget.processId,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: data.isNotEmpty
                                ? Column(
                                    children: data
                                        .map(
                                          (e) => WidgetInExpandVanBan(
                                            row: e.toListRow(),
                                            cubit: widget.cubit,
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const NodataWidget(),
                          ),
                        ],
                      ),
                    );
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
  bool get wantKeepAlive => true;
}
