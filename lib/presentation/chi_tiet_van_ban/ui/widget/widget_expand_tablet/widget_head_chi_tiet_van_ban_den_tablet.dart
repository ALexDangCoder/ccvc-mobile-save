import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDenTablet extends StatefulWidget {
  final CommonDetailDocumentCubit cubit;
  final String processId;

  final String taskId;

  const WidgetHeadChiTietVanBanDenTablet({
    Key? key,
    required this.cubit,
    required this.processId,
    required this.taskId,
  }) : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDenTablet> createState() =>
      _WidgetHeadChiTietVanBanDenTabletState();
}

class _WidgetHeadChiTietVanBanDenTabletState
    extends State<WidgetHeadChiTietVanBanDenTablet>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getChiTietVanBanDen(widget.processId, widget.taskId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getChiTietVanBanDen(widget.processId, widget.taskId);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit
              .getChiTietVanBanDen(widget.processId, widget.taskId);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: StreamBuilder<ChiTietVanBanDenModel>(
            initialData: widget.cubit.chiTietVanBanDenModel,
            stream: widget.cubit.chiTietVanBanDenSubject,
            builder: (context, snapshot) {
              final data = snapshot.data ?? ChiTietVanBanDenModel();
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: data.toListRowTablet().map(
                          (row) {
                            return Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: row
                                    .map(
                                      (e) => DetailDocumentRow(
                                        row: e,
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      DetailDocumentRow(
                        isTablet: true,
                        row: DocumentDetailRow(
                          S.current.trich_yeu,
                          data.trichYeu ?? '',
                          TypeDocumentDetailRow.text,
                        ),
                      ),
                      DetailDocumentRow(
                        isTablet: true,
                        row: DocumentDetailRow(
                          S.current.file_dinh_kem,
                          data.fileDinhKems
                                  ?.map((e) => e.toFileDinhKemModel())
                                  .toList() ??
                              [],
                          TypeDocumentDetailRow.fileActacks,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      checkRow(
                        S.current.van_ban_qppl,
                        value: data.isQPPL ?? false,
                      ),
                      spaceH16,
                      checkRow(
                        S.current.hoi_bao_van_ban,
                        value: data.isHoiBao ?? false,
                      ),
                      StreamBuilder<List<VanBanHoiBaoModel>>(
                        stream: widget.cubit.vanBanHoiBaoSubject,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: data
                                .map(
                                  (e) => WidgetInExpandVanBan(
                                    flexValue: 8,
                                    row: e.toListRow(),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      spaceH16,
                      checkRow(
                        S.current.da_nhan_ban_giay,
                        value: data.isNhanBanGiay ?? false,
                      ),
                      spaceH8,
                      if (data.isNhanBanGiay ?? false)
                        DetailDocumentRow(
                          isTablet: true,
                          row: DocumentDetailRow(
                            S.current.ngay_nhan_ban_giay,
                            data.ngayNhanBanGiay ?? '',
                            TypeDocumentDetailRow.text,
                          ),
                        )
                      else
                        const SizedBox.shrink()
                    ],
                  ),
                );
              } else {
                return const NodataWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget checkRow(String title, {required bool value}) => Row(
    children: [
      SizedBox(
        height: 20,
        width: 41,
        child: CustomCheckBox(
          isCheck: value,
          onChange: (bool check) {},
        ),
      ),
      AutoSizeText(
        title,
        style: textNormalCustom(
          color: titleItemEdit,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
