import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/xem_luong_xu_ly_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanWidgetExpandTablet extends StatefulWidget {
  final DeliveryNoticeDetailDocumentCubit cubit;
  final String processId;

  const ThongTinGuiNhanWidgetExpandTablet({
    Key? key,
    required this.cubit,
    required this.processId,
  }) : super(key: key);

  @override
  State<ThongTinGuiNhanWidgetExpandTablet> createState() =>
      _ThongTinGuiNhanWidgetExpandTabletState();
}

class _ThongTinGuiNhanWidgetExpandTabletState
    extends State<ThongTinGuiNhanWidgetExpandTablet>
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
                      child: data.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buttonStream,
                                  Column(
                                    children: data
                                        .map(
                                          (e) => WidgetInExpandVanBan(
                                            row: e.toListRow(),
                                            flexValue: 8,
                                          ),
                                        )
                                        .toList(),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buttonStream,
                                const Expanded(
                                  child: NodataWidget(),
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

  Widget get buttonStream => Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 24.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => XemLuongXuLyScreen(
                  id: widget.processId,
                ),
              ),
            );
          },
          child: Container(
            width: 250,
            color: borderColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 12,
            ),
            child: Center(
              child: Text(
                S.current.xem_luong_xu_ly,
                style: textNormalCustom(
                  color: textTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
