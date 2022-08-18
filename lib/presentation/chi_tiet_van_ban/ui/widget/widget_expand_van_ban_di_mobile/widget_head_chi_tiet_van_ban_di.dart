import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/widget_in_expand_van_ban.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDi extends StatefulWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String id;

  const WidgetHeadChiTietVanBanDi({
    Key? key,
    required this.cubit,
    required this.id,
  }) : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDi> createState() =>
      _WidgetHeadChiTietVanBanDiState();
}

class _WidgetHeadChiTietVanBanDiState extends State<WidgetHeadChiTietVanBanDi>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    widget.cubit.getChiTietVanBanDi(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        widget.cubit.getChiTietVanBanDi(widget.id);
      },
      error: AppException('', S.current.something_went_wrong),
      stream: widget.cubit.stateStream,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.cubit.getChiTietVanBanDi(widget.id);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: StreamBuilder<ChiTietVanBanDiModel>(
            stream: widget.cubit.chiTietVanBanDiSubject,
            builder: (context, snapshot) {
              final data = snapshot.data ?? ChiTietVanBanDiModel();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      children: data.toListRowHead().map(
                        (row) {
                          return DetailDocumentRow(
                            row: row,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  checkRow(
                    S.current.van_ban_tra_loi,
                    value: data.isLaVanBanTraLoi ?? false,
                  ),
                  ...?data.vanBanDenResponses
                      ?.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: WidgetInExpandVanBan(
                            row: e.toListRowView(),
                          ),
                        ),
                      )
                      .toList(),
                  checkRow(
                    S.current.van_ban_qppl,
                    value: data.isVanBanQppl ?? false,
                  ),
                  checkRow(
                    S.current.van_ban_chi_dao,
                    value: data.isVanBanChiDao ?? false,
                  ),
                  ...?data.vanBanChiDaoResponses
                      ?.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: WidgetInExpandVanBan(
                            row: e.toListRowView(),
                          ),
                        ),
                      )
                      .toList(),
                  spaceH30,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget checkRow(String title, {required bool value}) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
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
        ),
      );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
