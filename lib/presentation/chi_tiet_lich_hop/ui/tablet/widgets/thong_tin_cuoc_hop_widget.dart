import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chi_tiet_lich_hop_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/status_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thong_tin_lien_he_widget.dart';
import 'package:flutter/material.dart';

class ThongTinCuocHopWidget extends StatelessWidget {
  final DetailMeetCalenderCubit cubit;

  const ThongTinCuocHopWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChiTietLichHopModel>(
      stream: cubit.chiTietLichHopSubject,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final data = snapshot.data ?? ChiTietLichHopModel();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: statusCalenderRed,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    data.title,
                    style: textNormalCustom(
                      color: titleCalenderWork,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data
                      .valueData()
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: RowDataWidget(
                            urlIcon: e.urlIcon,
                            text: e.text,
                          ),
                        ),
                      )
                      .toList(),
                ),
                spaceH24,
                StatusWidget(
                  status: data.getStatus,
                ),
                spaceW16,
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ThongTinLienHeWidget(
                    thongTinTxt: data.chuTriModel.dauMoiLienHe,
                    sdtTxt: data.chuTriModel.soDienThoai,
                    dsDiemCau: data.dsDiemCau ?? [],
                    thuMoiFiles: data.fileDinhKemWithDecode ?? [],
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
