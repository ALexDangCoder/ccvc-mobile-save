import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_den_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_income_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDenMobile extends StatefulWidget {
  final CommonDetailDocumentCubit cubit;
  final String processId;
  final String taskId;

  const WidgetHeadChiTietVanBanDenMobile({
    Key? key,
    required this.cubit,
    required this.processId,
    required this.taskId,
  }) : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDenMobile> createState() =>
      _WidgetHeadChiTietVanBanDenMobileState();
}

class _WidgetHeadChiTietVanBanDenMobileState
    extends State<WidgetHeadChiTietVanBanDenMobile>
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
                      Column(
                        children: data.toListRow().map(
                          (row) {
                            return DetailDocumentRow(
                              row: row,
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                        children: snapshot.data!
                            .toListCheckBox()
                            .map(
                              (row) => Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 41,
                                    child: CustomCheckBox(
                                      title: '',
                                      isCheck: row.value,
                                      onChange: (bool check) {},
                                    ),
                                  ),
                                  AutoSizeText(
                                    row.title,
                                    style: textNormalCustom(
                                      color: titleItemEdit,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
