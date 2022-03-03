import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_only_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class ThongTinGuiNhanExpandWidget extends StatelessWidget {
  final DetailDocumentCubit cubit;

  const ThongTinGuiNhanExpandWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandOnlyWidget(
      header: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.transparent,
              child: Text(
                S.current.thong_tin_gui_nhan,
                style: textNormalCustom(color: titleColumn, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      child: StreamBuilder<DetailDocumentProfileSend>(
        initialData: cubit.thongTinGuiNhan,
        stream: cubit.detailDocumentGuiNhan,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderButtomColor),
                    color: borderButtomColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    children: snapshot.data!.toListRow().map(
                      (row) {
                        return DetailDocumentRow(
                          row: row,
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            );
          } else {
            return const NodataWidget();
          }
        },
      ),
    );
  }
}
