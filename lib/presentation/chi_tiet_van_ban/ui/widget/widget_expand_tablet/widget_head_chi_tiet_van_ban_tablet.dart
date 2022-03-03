import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/widget/detail_document_row_tablet.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBanTablet extends StatelessWidget {
  final DetailDocumentCubit cubit;

  const WidgetHeadChiTietVanBanTablet({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderButtomColor,
        ),
        color: backgroundColorApp,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            StreamBuilder<DetailDocumentModel>(
              initialData: cubit.detailDocumentModel,
              stream: cubit.detailDocumentSubject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Column(
                        children: snapshot.data!.toListRow().map(
                          (row) {
                            return DetailDocumentRowTablet(
                              row: row,
                            );
                          },
                        ).toList(),
                      ),
                      Column(
                        children: snapshot.data!
                            .toListCheckBox()
                            .map(
                              (row) => Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: AutoSizeText(
                                        row.title,
                                        style: textNormalCustom(
                                          color: titleItemEdit,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: SizedBox(
                                        height: 20,
                                        width: 41,
                                        child: CustomCheckBox(
                                          title: '',
                                          isCheck: row.value,
                                          onChange: (bool check) {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  );
                } else {
                  return const NodataWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
