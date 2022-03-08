import 'package:auto_size_text/auto_size_text.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/chi_tiet_van_ban_di_model.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/detail_document.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/bloc/detail_document_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/login/ui/widgets/custom_checkbox.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class WidgetHeadChiTietVanBan extends StatelessWidget {
  final DetailDocumentCubit cubit;

  const WidgetHeadChiTietVanBan({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietVanBanDiModel>(
      initialData: cubit.chiTietVanBanDiModel,
      stream: cubit.chiTietVanBanDiSubject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Column(
                children: snapshot.data!.toListRow().map(
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
                        // mainAxisSize: MainAxisSize.min,
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
          );
        } else {
          return const NodataWidget();
        }
      },
    );
  }
}
