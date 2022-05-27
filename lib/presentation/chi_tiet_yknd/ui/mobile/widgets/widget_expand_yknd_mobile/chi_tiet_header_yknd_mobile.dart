import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chi_tiet_yknd_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/bloc/chi_tiet_y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';

class ChiTietHeaderYKNDMobile extends StatelessWidget {
  final ChiTietYKienNguoiDanCubit cubit;

  const ChiTietHeaderYKNDMobile({Key? key, required this.cubit})
      : super(key: key);

  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietYKNDModel>(
      stream: cubit.chiTietYKNDSubject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Column(
                children: snapshot.data!.toListHeader().map(
                  (row) {
                    return DetailDocumentRow(
                      row: row,
                    );
                  },
                ).toList(),
              ),
            ],
          );
        } else {
          return const NodataWidget();
        }
      },
    );
  }
}
