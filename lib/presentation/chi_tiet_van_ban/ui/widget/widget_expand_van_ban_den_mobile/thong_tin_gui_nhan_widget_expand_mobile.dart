import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/XemLuongXuLyScreen/xem_luong_xu_ly_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/item_thong_bao_gui_nhan.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanExpandWidgetMobile extends StatefulWidget {
  final DeliveryNoticeDetailDocumentCubit cubit;
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder<List<ThongTinGuiNhanModel>>(
              stream: widget.cubit.thongTinGuiNhanStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (data.isEmpty) {
                  return CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Column(
                          children: [
                            buttonStream,
                            const Expanded(
                              child: NodataWidget(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buttonStream,
                      ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ItemThongBaoGuiNhan(
                            model: data[index],
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get buttonStream => InkWell(
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
      );

  @override
  bool get wantKeepAlive => true;
}
