import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/cong_tac_chuan_bi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/widget/detail_document_row/detail_document_row_widget.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/cupertino.dart';

class CongTacChuanBiWidgetTablet extends StatefulWidget {
  const CongTacChuanBiWidgetTablet({Key? key}) : super(key: key);

  @override
  _CongTacChuanBiWidgetTabletState createState() =>
      _CongTacChuanBiWidgetTabletState();
}

class _CongTacChuanBiWidgetTabletState
    extends State<CongTacChuanBiWidgetTablet> {
  @override
  Widget build(BuildContext context) {
    final DetailMeetCalenderCubit cubit = DetailMeetCalenderCubit();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              S.current.thong_tin_phong,
              style: titleAppbar(
                fontSize: 14.0.textScale(),
                color: dateColor,
              ),
            ),
          ),
          StreamBuilder<CongTacChuanBiModel>(
            initialData: cubit.thongTinPhong,
            // stream: cubit.detailDocumentGuiNhan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderItemCalender),
                        color: borderItemCalender.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Column(
                        children: snapshot.data!.toListRowThongTinPhong().map(
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
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(S.current.khong_co_du_lieu),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            S.current.thong_tin_yeu_cau_thiet_bi,
            style: titleAppbar(
              fontSize: 14.0,
              color: dateColor,
            ),
          ),
          StreamBuilder<CongTacChuanBiModel>(
            initialData: cubit.thongTinYeuCauThietBi,
            // stream: cubit.detailDocumentGuiNhan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderItemCalender),
                        color: borderItemCalender.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Column(
                        children: snapshot.data!.toListRowYeuCauThietBi().map(
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
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(S.current.khong_co_du_lieu),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}