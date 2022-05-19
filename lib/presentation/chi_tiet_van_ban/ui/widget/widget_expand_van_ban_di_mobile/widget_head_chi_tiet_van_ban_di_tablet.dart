import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/document_detail_row.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_go_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/widget/detail_document_row_tablet.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanDiTablet extends StatefulWidget {
  final CommonDetailDocumentGoCubit cubit;
  final String id;

  const WidgetHeadChiTietVanBanDiTablet(
      {Key? key, required this.cubit, required this.id,})
      : super(key: key);

  @override
  State<WidgetHeadChiTietVanBanDiTablet> createState() =>
      _WidgetHeadChiTietVanBanDiTabletState();
}

class _WidgetHeadChiTietVanBanDiTabletState
    extends State<WidgetHeadChiTietVanBanDiTablet>
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
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        children: snapshot.data!.toListRowHead().map(
                              (row) {
                            return DetailDocumentRowTablet(
                              row: row,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    ...snapshot.data!.toListCheckBox().map(checkRow).toList()
                  ],
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

  Widget checkRow(DocumentDetailRow row) => Padding(
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
  );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
